//
//  Frm_ShowDocment.m
//  SFA1
//
//  Created by Ren Yong on 14-4-15.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "Frm_ShowDocment.h"
#import "F_Color.h"
#import "C_NavigationBar.h"
#import "C_Button.h"
#import "Constants.h"
#import "DB.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "F_Alert.h"
#import "C_NavigationBar.h"
#import "F_Font.h"
#import "C_DocmentCell.h"
#import "C_GradientButton.h"




@interface Frm_ShowDocment ()
{
    UITableView* _tabView;
    NSMutableArray* _docmentList;
    UIDocumentInteractionController* document;
    
    C_DocmentCell *curDownloadingCell;
    NSMutableDictionary* selectDownloadEoc;
    
}
@end

@implementation Frm_ShowDocment

-(id)init
{
    self = [super init];
    if (self)
    {
        self.sharedDownloadManager = [TCBlobDownloadManager sharedDownloadManager];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self initUI];
}

-(void)loadData
{
    _docmentList=[[DB instance] docmentList];
}

//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)initUI
{
    self.view.backgroundColor = col_Background();
    //    self.view.layer.cornerRadius=CORNERRADIUS;
    
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"电子资料"];
    [self.view addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) buttonId:-1];
    
    [btn_Back setTitle:@"" forState:UIControlStateNormal];
    [btn_Back useImgStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    [self initTableView];
}

-(void)initTableView
{
    _tabView=[[UITableView alloc] initWithFrame:CGRectMake(0,SYSTITLEHEIGHT+1, self.view.frame.size.width, self.view.frame.size.height-SYSTITLEHEIGHT-1) style:UITableViewStylePlain];
    [_tabView setSeparatorColor:col_Background()];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    [self.view addSubview:_tabView];
}

-(void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary* field=[[_docmentList tempGroupAt: indexPath.section] dictAt:indexPath.row];
    static NSString* identifier=@"Cell";
    C_DocmentCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell=[[C_DocmentCell alloc] init:field];
    NSString *status = [field getString:@"status"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake( 0.0, 0.0, 40, 24 );
    button.frame = frame;
    //          [button setImage:image forState:UIControlStateNormal ];    //可以给button设置图片
    //          button.backgroundColor = [UIColor clearColor ];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if( [status isEqualToString:@"未下载"]) {
        [button setTitle:@"下载" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(downloadBtAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [button setTitle:@"查看" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(viewBtAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.actionBt = button;
    cell.accessoryView = button;
    //cell.detailTextLabel.text =@"下载";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_docmentList tempGroupAt: section] tempCount];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[_docmentList tempGroupAt: section] name];
}

//设置section的标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_docmentList count];
}

//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 50;
}

#pragma mark -
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self;
}

#pragma mark - bt action
- (NSMutableDictionary *)getAssignedDataFromCell:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    UITableViewCell *cell;
    
    int ver = [[[UIDevice currentDevice].systemVersion substringWithRange:NSMakeRange(0,1)] intValue];
    
    
    if ( 7 == ver ) {
        cell = (UITableViewCell *)button.superview.superview;
    }
    else
    {
        cell = (UITableViewCell *)button.superview;
    }
    
    curDownloadingCell = (C_DocmentCell*)cell;
    
    int section = [_tabView indexPathForCell:cell].section;
    int row = [_tabView indexPathForCell:cell].row;
    
    NSLog(@"section:%d, row:%d", section, row);
    
    
    NSMutableDictionary *field = [[_docmentList tempGroupAt: section] dictAt:row];
    
    return field;
}


- (void)downloadBtAction:(id)sender
{
    selectDownloadEoc = [self getAssignedDataFromCell:sender];
    
    NSString *fileUrl = [selectDownloadEoc getString:@"attachmenturl"];

    if(fileUrl){
        [self download:fileUrl];
        pro_showInfoMsg(@"正在下载，请耐心等待...");
    }
}

- (void)download:(NSString*)url
{
    NSLog(@"下载链接%@",url);
    
    NSString *utf8_url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * URL = [NSURL URLWithString:utf8_url];
    
    if (URL) {
        [_sharedDownloadManager startDownloadWithURL:URL customPath:nil delegate:self];
    }
}

- (void)viewBtAction:(id)sender
{
    [self previewDocument:[self getAssignedDataFromCell:sender]];
    
}

- (void)previewDocument:(NSMutableDictionary*)field {
    
    NSString *fileUrl=[field getString:@"attachmenturl"];
    NSArray *arry=[fileUrl componentsSeparatedByString:@"/"];
    NSString* file=[arry objectAtIndex:[arry count]-1];
    
    NSString* urlString=[NSString stringWithFormat:@"%@%@",[NSString stringWithString:NSTemporaryDirectory()],file];
    
    NSLog(@"downloaded doc%@",urlString);
    
    NSURL *URL = [NSURL fileURLWithPath:urlString];
    if (URL) {
        document = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        document.name=[field getString:@"docname"];
        [document setDelegate:self];
        [document presentPreviewAnimated:YES];
    }
}


#pragma mark - BlobDownloadManager Delegate (Optional, your choice)


- (void)download:(TCBlobDownload *)blobDownload didFinishWithSucces:(BOOL)downloadFinished atPath:(NSString *)pathToFile
{
    
    if(downloadFinished)
    {
        
//         if(downloadType==0)
//         {
//         [[DB instance] execSql:[NSString stringWithFormat:@"update t_data_edoc set issubmit = '0' where key_id=%@",[selectDownloadEoc getString:@"key_id"]]];
//         [self downloadDoc];
//         }else
//         {
         NSLog(@"文件地址:%@",pathToFile);
         [[DB instance] execSql:[NSString stringWithFormat:@"update T_Train_List set issubmit = '1' where key_id=%@",[selectDownloadEoc getString:@"key_id"]]];
//         [self downLoadEoc];
//         }
         
        
        UIButton *button = curDownloadingCell.actionBt;
        
        [button setTitle:@"查看" forState:UIControlStateNormal];
        [button removeTarget:self action:@selector(downloadBtAction:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(viewBtAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UITableViewCell *cell = curDownloadingCell;
        int section = [_tabView indexPathForCell:cell].section;
        int row = [_tabView indexPathForCell:cell].row;
        
        NSMutableDictionary *field = [[_docmentList tempGroupAt: section] dictAt:row];
        [field setObject:@"已下载" forKey:@"status"];
        [curDownloadingCell refreshCaption:field];
        
        stopProgress();
    }
    else
    {
        toast_showInfoMsg(@"网络异常", 100);
        stopProgress();
    }
}


- (void)download:(TCBlobDownload *)blobDownload didStopWithError:(NSError *)error
{
    NSLog(error.description);
    
    /*
    if(downloadType==0)
    {
        [[DB instance] execSql:[NSString stringWithFormat:@"update t_data_edoc set issubmit = '2', str10='%@' where key_id=%@",error.description,[selectDownloadEoc getString:@"key_id"]]];
        [self downloadDoc];
    }else
    {
        [[DB instance] execSql:[NSString stringWithFormat:@"update t_data_edoc set issubmit = '3',str10='%@' where key_id=%@",error.description,[selectDownloadEoc getString:@"key_id"]]];
        [self downLoadEoc];
    }
     */
    
    stopProgress();
}



- (void)download:(TCBlobDownload *)blobDownload didReceiveFirstResponse:(NSURLResponse *)response
{
    
}


- (void)download:(TCBlobDownload *)blobDownload didReceiveData:(uint64_t)receivedLength onTotal:(uint64_t)totalLength
{
    //    if(receivedLength==totalLength)
    //        NSLog(@"下载完成");
    //    NSLog(@"asdasd:%lld,asdasd:%lld",receivedLength,totalLength);
}


- (void)download:(TCBlobDownload *)blobDownload didCancelRemovingFile:(BOOL)fileRemoved
{
    
}


@end
