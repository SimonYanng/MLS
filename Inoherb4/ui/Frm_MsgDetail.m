//
//  Frm_MsgDetail.m
//  Inoherb4
//
//  Created by Ren Yong on 14-6-10.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "Frm_MsgDetail.h"
#import "C_NavigationBar.h"
#import "F_Color.h"
#import "C_Button.h"
#import "Constants.h"
#import "C_Bottom.h"
#import "C_MsgCell.h"
#import "Frm_Rpt.h"
#import "D_Report.h"
#import "F_Alert.h"
#import "DB.h"
#import "F_Template.h"
#import "F_Date.h"
#import "C_Label.h"
#import "F_Font.h"
#import "C_ItemView.h"
#import "C_GradientButton.h"
@implementation Frm_MsgDetail

//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(id)init:(NSMutableDictionary*)data
{
    self = [super init];
    if(self)
    {
        _msgDetail=data;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _template=temp_Message();
//    _panel=[_template panelAt:0];
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)initUI
{
    self.view.backgroundColor = col_Background();
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"消息详情"];
    [self.view addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    [btn_Back setTitle:@"返回" forState:UIControlStateNormal];
    [btn_Back useAddHocStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    [self initSkuView];
    [self updateStatus];
    
}

- (void)updateStatus
{
    if([[_msgDetail getString:@"status"] isEqualToString:@"未读"])
        [[DB instance] execSql:[NSString stringWithFormat:@"update t_message_detail set status='已读', issubmit=0 where serverid='%@'",[_msgDetail getString:@"serverid"]]];
}

-(void)initSkuView
{
    _msgDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SYSTITLEHEIGHT+1,self.view.frame.size.width,self.view.frame.size.height-SYSTITLEHEIGHT-1) style:UITableViewStylePlain];
    _msgDetailTableView.delegate = self;
    _msgDetailTableView.dataSource = self;
    _msgDetailTableView.separatorColor = col_LightGray();
    [self.view addSubview:_msgDetailTableView];
}

//加载分类数据
//- (void)loadMsgList{
//    _msgList=[[DB instance] fieldListBy:[NSMutableString stringWithFormat:@"select * from t_message_detail where stime>='%@' order by str1,stime",today()]];
//}


#pragma mark - TableViewdelegate&&TableViewdataSource
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    
    
    D_Panel* panel=[_template panelAt:indexPath.section];
    D_UIItem* item=[panel itemAt:indexPath.row];
    C_ItemView* itemView=[[C_ItemView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self heightForCell:indexPath]) item:item data:_msgDetail delegate:nil];
    
    NSLog(@"高%f",[itemView cellHight]);
    
    return [itemView cellHight];// [self heightForCell:indexPath];// [self cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section!=0) {
        return 30;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
////    return [self.headViewArray objectAtIndex:section];
//    return <#expression#>
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static int itemHeight=30;
//    //    static int viewGap=0;
//    int width=self.view.frame.size.width;
//    int lableW=0;
//    //    int count=[productPanel itemCount];
//
//    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
//    titleView.autoresizesSubviews = YES;
//    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    titleView.userInteractionEnabled = YES;
//    titleView.backgroundColor=col_buttonColor2();
//
//
//    lableW=width*20/100;
//
//    UILabel* lable=[[UILabel alloc] initWithFrame: CGRectMake(5, 0, self.view.frame.size.width-5, itemHeight)];
//    lable.text=@"状态";
//    lable.font=fontBysize(12);
//    //    lable.backgroundColor=col_buttonColor2();
//    lable.textAlignment=NSTextAlignmentCenter;
//    lable.textColor=col_White();
//    [titleView addSubview:lable];
////    oldLableW+=lableW;
//
////    lableW=width*45/100;
////    lable=[[UILabel alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW, itemHeight)];
////    lable.text=@"标题";
////    lable.font=fontBysize(12);
////    //    lable.backgroundColor=col_buttonColor2();
////    lable.textAlignment=NSTextAlignmentCenter;
////    lable.textColor=col_White();
////    [titleView addSubview:lable];
////    oldLableW+=lableW;
////
////    lableW=width*25/100;
////    lable=[[UILabel alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW, itemHeight)];
////    lable.text=@"发送时间";
////    lable.font=fontBysize(12);
////    //    lable.backgroundColor=col_buttonColor2();
////    lable.textAlignment=NSTextAlignmentCenter;
////    lable.textColor=col_White();
////    [titleView addSubview:lable];
//
//    return titleView;
//}

//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section!=0) {
        return [NSString stringWithFormat:@" %@:",[_template panelAt:section].name ];
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    D_Panel* panel=[_template panelAt:section];
    return panel.itemCount;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _template.panelCount;
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    D_Panel* panel=[_template panelAt:indexPath.section];
    D_UIItem* item=[panel itemAt:indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //    if(!cell)
    //    {
    //       cell=[[C_RptProductCell alloc]initWith:field panel:productPanel];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    C_ItemView* itemView=[[C_ItemView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self heightForCell:indexPath]) item:item data:_msgDetail delegate:nil];
    [cell sizeToFit];
    [cell addSubview:itemView];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(float)heightForCell:(NSIndexPath*)indexPath
{
    D_Panel* panel=[_template panelAt:indexPath.section];
    D_UIItem* item=[panel itemAt:indexPath.row];

        int width=self.view.frame.size.width-10;
        int lableW=width*item.lableWidth/100;
        int content=width-lableW-20;
    return [self heightForString:[_msgDetail getString:item.dataKey] fontSize:17 andWidth:content];
    
}


- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:fontBysize(fontSize) constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    if(sizeToFit.height>70)
        return sizeToFit.height+35;
    return 70;
}


@end
