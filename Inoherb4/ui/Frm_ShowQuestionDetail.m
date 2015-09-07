//
//  Frm_ShowQuestionDetail.m
//  JahwaS
//
//  Created by Bruce on 15/7/10.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "Frm_ShowQuestionDetail.h"
#import "F_Color.h"
#import "F_UserData.h"
#import "F_Alert.h"
#import "C_NavigationBar.h"
#import "Constants.h"
#import "C_Bottom.h"
#import "C_GradientButton.h"
#import "D_Panel.h"
#import "Constants.h"
#import "C_Label.h"
#import "C_ProductItemView.h"
#import "F_Date.h"
#import "DB.h"
#import "Frm_ShowDataList.h"
#import "Frm_MsgList.h"
#import "Frm_Menu.h"
#import "SyncWeb.h"
#import "NSMutableArray+Tool.h"
#import "NSMutableDictionary+Tool.h"
#import "Frm_Rpt.h"
#import "C_Question.h"
#import "C_Filter.h"
#import "Frm_SubmitRpt.h"
#import "C_ItemView.h"
#import "F_Template.h"
@interface Frm_ShowQuestionDetail ()
{
    UITableView* _tableViewHD;
    D_Panel* _panelHD;
    NSMutableArray* _listHD;
    NSMutableDictionary* _dicClientInfo;
    C_ViewButtonList* viewButton;
    NSMutableDictionary* _selectData;
    
    int _questionStatus;
    NSMutableDictionary* _queryData;
    RequestType _syncType;
    
    D_Template* _template;
}
@end

@implementation Frm_ShowQuestionDetail

-(id)init:(NSMutableDictionary*)data
{
    self = [super init];
    if(self)
    {
        _dicClientInfo=data;
        _template=temp_Question1();
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 [self panelPlan];
    //    [self initData];
    [self initUI];

}

-(void)viewDidAppear:(BOOL)animated
{
    pro_showInfoMsg(@"正在查询,请稍候");
    [self querData];
}
//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)initUI
{
    self.view.backgroundColor = col_Background();
    [self addNavigationBar];
    [self initTableViewHD];
    //    [self addViewBottom];
}

-(void)addNavigationBar
{
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"问题跟踪"];
    [self.view addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) buttonId:-1];
    [btn_Back setTitle:@"" forState:UIControlStateNormal];
    [btn_Back useImgStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
}

-(void)querData
{
    _queryData=[NSMutableDictionary dictionary];
    [_queryData putKey:user_Id() key:@"userid"];
    
    [_queryData putKey:[_dicClientInfo getString:@"serverid"] key:@"questionid"];
    
    [_queryData putKey:@"GetVisitQuestionDetail" key:METHOD];
    _syncType=QUERY_REQUEST;
    [[SyncWeb instance]syncWeb:QUERY_REQUEST field:_queryData delegate:self];
}

-(BOOL)checkData
{
    
    return YES;
}



- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTableViewHD
{
    _tableViewHD = [[UITableView alloc]initWithFrame:CGRectMake(0, SYSTITLEHEIGHT,self.view.frame.size.width,self.view.frame.size.height-SYSTITLEHEIGHT) style:UITableViewStylePlain];
    _tableViewHD.delegate = self;
    _tableViewHD.dataSource = self;
    _tableViewHD.separatorColor = col_Background();
    [self.view addSubview:_tableViewHD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) panelPlan
{
    _panelHD=[[D_Panel alloc]init];
    _panelHD.name=@"问题详情";
    _panelHD.type=@"1";
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"拜访人";
    item.controlType=NONE;
    item.dataKey=@"EmpName";
    item.lableWidth=50;
    item.placeholder=@"编码";
    item.isShowCaption=YES;
    item.isMustInput=YES;
    item.textAlignment=NSTextAlignmentLeft;
    [_panelHD addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"门店";
    item.controlType=NONE;
    item.verifyType=DEFAULT;
    item.dataKey=@"FullName";
    item.lableWidth=25;
    item.textAlignment=NSTextAlignmentCenter;
    item.isShowCaption=YES;
    [_panelHD addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"拜访人";
    item.controlType=NONE;
    item.verifyType=DEFAULT;
    item.dataKey=@"empname";
    item.lableWidth=25;
    item.textAlignment=NSTextAlignmentCenter;
    item.isShowCaption=YES;
    [_panelHD addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"日期";
    item.controlType=NONE;
    item.verifyType=DEFAULT;
    item.dataKey=@"STR1";
    item.lableWidth=25;
    item.textAlignment=NSTextAlignmentCenter;
    item.isShowCaption=YES;
    [_panelHD addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"状态";
    item.controlType=NONE;
    item.verifyType=DEFAULT;
    item.dataKey=@"DealName";
    item.lableWidth=25;
    item.textAlignment=NSTextAlignmentCenter;
    item.isShowCaption=YES;
    [_panelHD addItem:item];
}

#pragma mark - TableViewdelegate&&TableViewdataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    C_RptCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(indexPath.section==0)
    {
        D_Panel* panel=[_template panelAt:indexPath.section];
        D_UIItem* item=[panel itemAt:indexPath.row];
        C_ItemView* itemView=[[C_ItemView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70) item:item data:_dicClientInfo delegate:nil];
        [cell addSubview:itemView];
    }
    else
    {
        NSMutableDictionary* field=[_listHD dictAt:(int)indexPath.row];
        C_Question* itemView=[[C_Question alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) field:field panel:_panelHD];
        cell.selectionStyle=UITableViewCellSelectionStyleBlue;
        [cell addSubview:itemView];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{if(section==0)
{
    D_Panel* panel=[_template panelAt:section];
    return [panel itemCount];
}
else
    return [_listHD count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableViewHD reloadData];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static int itemHeight=40;
    D_Panel* panel=[_template panelAt:section];
    
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, itemHeight)];
    titleView.autoresizesSubviews = YES;
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleView.userInteractionEnabled = YES;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.view.frame.size.width, itemHeight);
    UIColor *endColor =UIColorFromRGB(0xF2F8FA);
    gradient.colors = [NSArray arrayWithObjects:(id)[endColor CGColor],
                       (id)[endColor CGColor],nil];
    [titleView.layer insertSublayer:gradient atIndex:0];
    
    C_Label* lable=[[C_Label alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, itemHeight)  label:panel.name];
    lable.backgroundColor=col_ClearColor();
    lable.textAlignment=NSTextAlignmentLeft;
    lable.textColor=[UIColor blackColor];
    [lable setText:[NSString stringWithFormat:@"  %@",panel.name]];
    [titleView addSubview:lable];
    
    return titleView;
}

//设置section的标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    D_Panel* panel=[_template panelAt:section];
    if(panel.showTitle)
        return 40;//HEADHEIGHT;
    else
        return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_template panelCount];
}

//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 50;
}
- (void)delegate_requestDidSuccess:(D_SyncResult*)result
{
    stopProgress();
    int status=[result getInt:SUCCESS];
    if (status==1)
    {
        
        _listHD=result.getFieldList;
        if([_listHD count]>0)
            [_tableViewHD reloadData];
        else
            toast_showInfoMsg(@"未查询到流转记录", 100);
    }
    else
    {
        toast_showInfoMsg([result getString:ERRMSG], 100);
    }
}

-(void) delegate_requestDidFail:(NSString*) errMsg
{
    stopProgress();
    toast_showInfoMsg(errMsg, 100);
}

@end
