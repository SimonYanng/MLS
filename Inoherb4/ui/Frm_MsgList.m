//
//  Frm_MsgList.m
//  Inoherb4
//
//  Created by Ren Yong on 14-6-10.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "Frm_MsgList.h"
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
#import "Frm_MsgDetail.h"
#import "C_GradientButton.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "Frm_Survey.h"
@interface Frm_MsgList()
{
    UITableView* _msgTableView;
    NSMutableArray* _msgList;
}
@end

@implementation Frm_MsgList

//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadMsgList];
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
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"消息列表"];
    [self.view addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) buttonId:-1];
    
    [btn_Back setTitle:@"" forState:UIControlStateNormal];
    [btn_Back useImgStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    [self initSkuView];
}
-(void)initSkuView
{
    _msgTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SYSTITLEHEIGHT,self.view.frame.size.width,self.view.frame.size.height-SYSTITLEHEIGHT) style:UITableViewStylePlain];
    _msgTableView.delegate = self;
    _msgTableView.dataSource = self;
    _msgTableView.separatorColor = col_LightGray();
    [self.view addSubview:_msgTableView];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadMsgList];
    [_msgTableView reloadData];
}
//加载分类数据
- (void)loadMsgList{
    //    _msgList=[[DB instance] fieldListBy:[NSMutableString stringWithFormat:@"select serverid,title,content,stime,sender ,case when str1 is '' then '未读' else str1 end as str1 from t_message_detail where strftime('%%Y-%%m-%%d',stime)<='%@' order by str1 desc,stime desc",today()]];
    _msgList=[[DB instance] fieldListBy:[NSMutableString stringWithFormat:@"select 1 as type, serverid ,title,content, strftime('%%Y-%%m-%%d',stime) as stime,sender,case when status is '' then '未读' when status is null  then '未读' else status end as status from t_message_detail"]];
}


#pragma mark - TableViewdelegate&&TableViewdataSource
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    return 50;// [self cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
////    return [self.headViewArray objectAtIndex:section];
//    return <#expression#>
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static int itemHeight=40;
    //    static int viewGap=0;
    int width=self.view.frame.size.width;
    int lableW=0;
    int oldLableW=0;
    //    int count=[productPanel itemCount];
    
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    titleView.autoresizesSubviews = YES;
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleView.userInteractionEnabled = YES;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, width, itemHeight);
    UIColor *endColor =UIColorFromRGB(0xD9ECF1);
    gradient.colors = [NSArray arrayWithObjects:(id)[endColor CGColor],
                       (id)[endColor CGColor],nil];
    [titleView.layer insertSublayer:gradient atIndex:0];
    
    
    lableW=width*15/100;
    
    UILabel* lable=[[UILabel alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW, itemHeight)];
    lable.text=@"状态";
    lable.font=fontBysize(12);
    lable.textAlignment=NSTextAlignmentCenter;
    lable.textColor=[UIColor blackColor];
    [titleView addSubview:lable];
    oldLableW+=lableW;
    
    lableW=width*60/100;
    lable=[[UILabel alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW, itemHeight)];
    lable.text=@"标题";
    lable.font=fontBysize(12);
    lable.textAlignment=NSTextAlignmentCenter;
    lable.textColor=[UIColor blackColor];
    [titleView addSubview:lable];
    oldLableW+=lableW;
    
    lableW=width*25/100;
    lable=[[UILabel alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW, itemHeight)];
    lable.text=@"发送时间";
    lable.font=fontBysize(12);
    lable.textAlignment=NSTextAlignmentCenter;
    lable.textColor=[UIColor blackColor];
    [titleView addSubview:lable];
    
    return titleView;
}

//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    D_Result* value=[result getResult:section];
    return [_msgList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary* field=[_msgList dictAt:indexPath.row];
    C_MsgCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    //    if (!cell) {
    cell=[[C_MsgCell alloc ]init: field];
    //    }
    //    if(!isFirst)
    //        [cell refresh];
    //    UITableViewCell cell1=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary* field=[_msgList dictAt:indexPath.row];
    
    if([[field getString:@"type"] isEqualToString:@"1"])
    {
        Frm_MsgDetail* nextFrm = [[Frm_MsgDetail alloc] init:field];
        [self.navigationController pushViewController:nextFrm animated:YES];
    }
    else
    {
        Frm_Survey* nextFrm = [[Frm_Survey alloc] init:field];
        [self.navigationController pushViewController:nextFrm animated:YES];
    }
    
}

@end
