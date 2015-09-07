//
//  Frm_MainMenu.m
//  Inoherb
//
//  Created by Bruce on 15/3/26.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "Frm_MainMenu.h"

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
#import "Frm_HDlist.h"
#import "Frm_SubmitRpt.h"
#import "F_Tool.h"
#import "Frm_ShowDocment.h"
#import "Frm_SetPlan.h"
//#import "Frm_Map.h"
#import "F_Font.h"
#import "Frm_SkuList.h"

@interface Frm_MainMenu ()
{
    UITableView* _tableViewPlan;
    D_Panel* _panelPlan;
    NSMutableArray* _listPlan;
    NSMutableDictionary* _selectClient;
    D_Report* _syncRpt;
    RequestType _syncType;
    C_ViewHDClientList* _viewHDClientList;
    BOOL isStart;
    NSMutableArray* _listDownloadMsg;
    NSMutableDictionary* _queryData;
    int _index;
    
    C_ClientInfo* _clientInfo;
    BOOL isPlan;
}
@end

@implementation Frm_MainMenu

-(id)init:(NSMutableArray*)msgList
{
    self = [super init];
    if (self) {
        _listDownloadMsg=msgList;
        //        NSLog(@"日期%@---------今天%@",[login_date() substringToIndex:7],[today() substringToIndex:7]);
    }
    return self;
}



//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self panelPlan];
    [self initData];
    [self initUI];
    
    //    isStart=YES;
    //    float timerInterval = 5.0;
    //    [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(syncRpt) userInfo:nil repeats:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    isStart=YES;
    [self initData];
    [_tableViewPlan reloadData];
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(syncRpt)
                                                   object:nil];
    [myThread start];
    //
    //    [self ];
}


-(void)syncRpt
{
    //    _syncRpt=[[DB instance] submitPlan];
    //    if([[_syncRpt getString:@"isSaved"] isEqualToString:@"Y"])
    //    {
    //        _syncType=UPLOAD_PLAN;
    //        [[SyncWeb instance]syncWeb:UPLOAD_PLAN report:_syncRpt delegate:self];
    //    }
    //    else
    //    {
    _syncRpt=[[DB instance] submitRpt];
    if([[_syncRpt getString:@"isSaved"] isEqualToString:@"Y"])
    {
        _syncType=UPLOAD_REQUEST;
        [[SyncWeb instance]syncWeb:UPLOAD_REQUEST report:_syncRpt delegate:self];
    }
    else
    {
        _syncRpt=[[DB instance] submitMsg];
        if([[_syncRpt getString:@"isSaved"] isEqualToString:@"Y"])
        {
            _syncType=UPLOAD_MSG;
            [[SyncWeb instance]syncWeb:UPLOAD_MSG report:_syncRpt delegate:self];
        }
        else
        {
            isStart=NO;
            _syncType=QUERY_MSG;
            [self queryMessage];
        }
        //        }
    }
}



-(void)queryMessage
{
    NSMutableDictionary *queryData=[NSMutableDictionary dictionary];
    [queryData putKey:user_Id() key:USERID];
    [queryData putKey:@"0" key:ISALL];
    [queryData putKey:@"0" key:STARTROW];
    [queryData putKey:today() key:@"lastTime"];
    [queryData putKey:@"GetMessageList" key:METHOD];
    
    [self syncWeb:QUERY_MSG field:queryData];
}

-(void) syncWeb:(RequestType)type field:(NSMutableDictionary* )field
{
    [[SyncWeb instance]syncWeb:type field:field delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData
{
    NSMutableString* sql=[NSMutableString stringWithFormat:@"SELECT o.int1 as int1,  o.str1 as str1,o.str2 as str2,o.str3 as str3,o.str4 as str4,  o.str21 as str21,o.str22 as str22,o.str23 as str23,o.str24 as str24,o.str25 as str25,o.str26 as str26,o.fullname as name, o.address as address, o.outletcode as outletcode, o.OutletLevel as OutletLevel, case when  sum(c.issubmit is not null and c.issubmit is not -1) is 0 then '未拜访' else (sum(c.issubmit is 1)*100/sum(c.issubmit is not null and c.issubmit is not -1 ))||'%%' end as status1,case when  sum(c.issubmit is not null and c.issubmit is not -1) is 0 then '未拜访' else  sum(c.issubmit is 1)||'/'||sum(c.issubmit is not null and c.issubmit is not -1 ) end as status,  o.outlettype as outlettype, o.serverid as serverid, o.outletcode||o.fullname  as fullname,o.facialdiscount as clienttype FROM (select * from t_visit_plan_detail where strftime('%%Y-%%m-%%d',VisitTime)  ='%@')  vd left join (select * from t_data_callreport where ReportDate='%@') c on c.clientid=vd.clientid left join t_outlet_main o on o.outletid=vd.clientid group by vd.clientid order by str1 desc ",today(),today()];
    _listPlan=[[DB instance] fieldListBy:sql];
}

-(void)initUI
{
    self.view.backgroundColor = col_Background();
    [self addNavigationBar];
    [self initTableViewPlan];
    [self addViewBottom];
}

-(void)addNavigationBar
{
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"当日拜访"];
    [self.view addSubview:bar];
    
    C_GradientButton* btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Hoc setTitle:@"计划外" forState:UIControlStateNormal];
    [btn_Hoc useAddHocStyle];
    [btn_Hoc addTarget:self action:@selector(addHoc:) forControlEvents:UIControlEventTouchUpInside];
    [bar addRightButton:btn_Hoc];
    
    //    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) buttonId:-1];
    //    [btn_Back setTitle:@"" forState:UIControlStateNormal];
    //    [btn_Back useImgStyle];
    //    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [bar addLeftButton:btn_Back];
}

- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)navClicked:(id)sender
{
    //    [self showAlert];
}

//-(void)showAlert
//{
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确认下载？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//    [alertView show];
//}
//


/**
 [""]	;数据查询
 [""]	@param result <#result description#>
 [""]	@returns <#return value description#>
 [""] */
-(void)querALLData
{
    _index=0;
    NSMutableDictionary* msg = [_listDownloadMsg dictAt:_index];
    pro_showInfoMsg([msg getString:@"MsgInfo" ]);//DESC
    _queryData=[NSMutableDictionary dictionary];
    [_queryData putKey:user_Id() key:USERID];
    [_queryData putKey:@"0" key:@"isAll"];
    [_queryData putKey:@"0" key:@"startRow"];
    [_queryData putKey:today() key:@"lastTime"];
    [_queryData putKey:[msg getString:@"MsgType"] key:METHOD];
    _syncType=UPLOAD_REQUEST;
    [self syncWeb:UPLOAD_REQUEST field:_queryData];
}

-(void)addHoc:(id)sender
{
    C_ViewHocList* viewHoc=[[C_ViewHocList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewHoc.delegate=self;
    [viewHoc showInView:self.view];
}


-(void)initTableViewPlan
{
    _tableViewPlan = [[UITableView alloc]initWithFrame:CGRectMake(0, SYSTITLEHEIGHT,self.view.frame.size.width,self.view.frame.size.height-SYSTITLEHEIGHT) style:UITableViewStylePlain];
    _tableViewPlan.delegate = self;
    _tableViewPlan.dataSource = self;
    _tableViewPlan.separatorColor = col_Background();
    [self.view addSubview:_tableViewPlan];
}

-(void)addViewBottom
{
    C_Bottom* bottom=[[C_Bottom alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-BOTTOMHEIGHT, self.view.frame.size.width, BOTTOMHEIGHT) buttonList:[self buttonList] buttonList1:nil];
    bottom.delegate=self;
    [self.view addSubview:bottom];
}

- (void)delegate_selected:(NSMutableDictionary*)data
{
    NSLog(@"%@",[data getString:@"fullname"]);
    _selectClient=data;
    isPlan=NO;
    if([[_selectClient getString:@"int1"] isEqualToString:@"1"])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请收集相关的销售数据，核实及验证改善的结果！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alertView show];
    }
    else
        [self toCallCard];
    //    [self toCallCard:0];
}



-(void)toCallCard
{
    if(!isPlan)
    {
        NSMutableString* sql = [NSMutableString stringWithFormat:@"REPLACE into t_visit_plan_detail  ( clientid ,serverid ,VisitTime)values ('%@' ,'-%@','%@') ",[_selectClient getString:@"serverid"],[_selectClient getString:@"serverid"],today()];
        if(![[DB instance] execSql:sql])
        {
            toast_showInfoMsg(@"计划保存失败,请重试", 100);
            return;
        }
    }
    
    if ([[_selectClient getString:@"outlettype"] isEqualToString:@"-1"]||[[_selectClient getString:@"clienttype"] isEqualToString:@"2"])
    {
        NSMutableArray* rptList=[[DB instance] fieldListBy:[NSMutableString stringWithFormat:@"SELECT *, strftime('%%H:%%M:%%S',updatetime) as updatetime ,case when issubmit is 0 then '已保存'  when issubmit is 1 then '已上传'  when issubmit is 2 then '上传失败' end as issubmit, '' as dictname  FROM t_data_callreport where onlyType='%d' and ReportDate='%@' and clientId='%@' order by issubmit desc,updatetime desc",-1,today(),[_selectClient getString:@"serverid"] ]];
        
        if([rptList count]>0)
        {
            Frm_ShowDataList * nextFrm = [[Frm_ShowDataList alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height) type:200 data:_selectClient];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
        else
            [self toCall:myUUID()];
        
    }
    else
    {
        [self toCall:@""];
    }
}

-(void) toCall:(NSString*) key
{
    [_selectClient put:key key:@"key"];
    Frm_Menu* nextFrm = [[Frm_Menu alloc] init:_selectClient];
    [self.navigationController pushViewController:nextFrm animated:YES];
}

//-(void)delegate_hdselected:(NSMutableDictionary *)data
//{
//    Frm_HDlist * nextFrm = [[Frm_HDlist alloc] init:data ];
//    [self.navigationController pushViewController:nextFrm animated:YES];
//}

-(NSMutableArray*)buttonList
{
    NSMutableArray* buttonList=[[NSMutableArray alloc] init];
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"签到" key:@"name"];
    [button putInt:11 key:@"buttonId"];
    [buttonList addDict:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"公告消息" key:@"name"];
    [button putInt:14 key:@"buttonId"];
    [buttonList addDict:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"修改密码" key:@"name"];
    [button putInt:15 key:@"buttonId"];
    [buttonList addDict:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"潜在客户" key:@"name"];
    [button putInt:13 key:@"buttonId"];
    [buttonList addDict:button];
    
    return buttonList;
}

-(void)delegate_buttonClick:(int)buttonId
{
    switch (buttonId) {
            
        case 11:{
            Frm_SkuList* nextFrm = [[Frm_SkuList alloc] init];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
            
        case 14:{
            Frm_MsgList* nextFrm = [[Frm_MsgList alloc] init];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
        case 15:{
            NSMutableDictionary* dicRptData=[NSMutableDictionary dictionary];
            [dicRptData put:[NSString stringWithFormat:@"%d",-1001 ] key:@"templateid"];
            Frm_SubmitRpt * nextFrm = [[Frm_SubmitRpt alloc] init:dicRptData ];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
        case 13:{
            Frm_HDlist* nextFrm = [[Frm_HDlist alloc] init];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
            
            
        default:
            break;
    }
}


#pragma mark - TableViewdelegate&&TableViewdataSource
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    D_Result* value=[result getResult:section];
    return [_listPlan count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static int itemHeight=40;
    //    static int viewGap=0;
    int width=self.view.frame.size.width;
    int lableW=0;
    int oldLableW=0;
    int count=[_panelPlan itemCount];
    
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, itemHeight)];
    titleView.autoresizesSubviews = YES;
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleView.userInteractionEnabled = YES;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, width, itemHeight);
    UIColor *endColor =UIColorFromRGB(0xD9ECF1);
    gradient.colors = [NSArray arrayWithObjects:(id)[endColor CGColor],
                       (id)[endColor CGColor],nil];
    [titleView.layer insertSublayer:gradient atIndex:0];
    
    D_UIItem* item;
    C_Label*  lable;
    for (int i=0; i<count; i++) {
        item=[_panelPlan itemAt:i];
        lableW=width*item.lableWidth/100;
        
        lable=[[C_Label alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW-0.3, itemHeight)  label:item.caption];
        lable.backgroundColor=col_ClearColor();
        lable.textAlignment=item.textAlignment;
        lable.textColor=[UIColor blackColor];
        
        if(item.textAlignment==NSTextAlignmentLeft)
            [lable setText:[NSString stringWithFormat:@"  %@",item.caption]];
        //         if([item.caption isEqualToString:@"详情"])
        //              [lable setText:@""];
        [titleView addSubview:lable];
        oldLableW+=lableW;
    }
    return titleView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary* field=[_listPlan dictAt:(int)indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    C_ProductItemView* itemView=[[C_ProductItemView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CELLHEIGHT) field:field panel:_panelPlan delegate:nil report:nil];
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    [cell addSubview:itemView];
    
    
    if (indexPath.row % 2)
    {
        [cell setBackgroundColor:col_Background()];
    }else {
        [cell setBackgroundColor:col_ClearColor()];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectClient=[_listPlan dictAt:(int)indexPath.row];
    isPlan=YES;
    if([[_selectClient getString:@"int1"] isEqualToString:@"1"])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请收集相关的销售数据，核实及验证改善的结果！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alertView show];
    }
    else
        [self toCallCard];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        [self showClientInfo];
    }
}

-(void)showClientInfo
{
    if(_clientInfo)
    {
        [_clientInfo cancelPicker];
        _clientInfo=nil;
    }
    _clientInfo=[[C_ClientInfo alloc] init:self.view.frame panelList:[self panelList] data:_selectClient];
    _clientInfo.delegate_clientInfo=self;
    [_clientInfo showInView:self.view];
}

-(void)delegate_clientInfo_ok
{
    [self toCallCard];
}


-(NSMutableArray*)panelList
{
    NSMutableArray* panelList=[[NSMutableArray alloc]init];
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"上次拜访该店的机会点";
    //    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"一";
    item.controlType=NONE;
    item.dataKey=@"str21";
    item.dicId=@"70";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"二";
    item.controlType=NONE;
    item.dataKey=@"str22";
    item.dicId=@"185";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"三";
    item.controlType=NONE;
    item.dataKey=@"str23";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    
    [panelList addPanel:panel];
    
    panel=[[D_Panel alloc]init];
    panel.name=@"上次拜访该店员工的机会点";
    //    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    item=[[D_UIItem alloc]init];
    item.caption=@"一";
    item.controlType=NONE;
    item.dataKey=@"str24";
    item.dicId=@"70";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"二";
    item.controlType=NONE;
    item.dataKey=@"str25";
    item.dicId=@"185";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"三";
    item.controlType=NONE;
    item.dataKey=@"str26";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    
    [panelList addPanel:panel];
    
    panel=[[D_Panel alloc]init];
    panel.name=@"基本信息";
    //    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    item=[[D_UIItem alloc]init];
    item.caption=@"编码";
    item.controlType=NONE;
    item.dataKey=@"outletcode";
    item.dicId=@"70";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"名称";
    item.controlType=NONE;
    item.dataKey=@"name";
    item.dicId=@"185";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"地址";
    item.controlType=NONE;
    item.dataKey=@"address";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"渠道";
    item.controlType=NONE;
    item.dataKey=@"str1";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    item=[[D_UIItem alloc]init];
    item.caption=@"省份";
    item.controlType=NONE;
    item.dataKey=@"str2";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    item=[[D_UIItem alloc]init];
    item.caption=@"城市";
    item.controlType=NONE;
    item.dataKey=@"str3";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"销售组织";
    item.controlType=NONE;
    item.dataKey=@"str4";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    
    [panelList addPanel:panel];
    return panelList;
}

-(void) panelPlan
{
    _panelPlan=[[D_Panel alloc]init];
    _panelPlan.name=@"当日拜访";
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"客户";
    item.controlType=NONE;
    item.dataKey=@"fullname";
    item.lableWidth=75;
    item.placeholder=@"编码";
    item.isShowCaption=YES;
    item.isMustInput=YES;
    item.textAlignment=NSTextAlignmentLeft;
    [_panelPlan addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"上传状态";
    item.controlType=NONE;
    item.verifyType=DEFAULT;
    item.dataKey=@"status1";
    item.lableWidth=25;
    item.textAlignment=NSTextAlignmentCenter;
    item.isShowCaption=YES;
    [_panelPlan addItem:item];
    
    //    item=[[D_UIItem alloc]init];
    //    item.caption=@"详情";
    //    item.controlType=BUTTON;
    //    item.verifyType=DEFAULT;
    //    item.dataKey=@"";
    //    item.lableWidth=20;
    //    item.textAlignment=NSTextAlignmentCenter;
    //    item.isShowCaption=YES;
    //    [_panelPlan addItem:item];
}


- (void)delegate_requestDidSuccess:(D_SyncResult*)result
{
    stopProgress();
    int status=[result getInt:SUCCESS];
    switch (_syncType) {
        case UPLOAD_REQUEST:
        {
            status=[[result getField:0]getInt:SUCCESS];
            if (status==1)
            {
                NSString* sql=[NSString stringWithFormat:@"update t_data_callreport set issubmit='1',serverid='%@' where key_id='%@'",[[result getField:0]getString:@"reportid"],[_syncRpt getString:@"key_id"]];
                [[DB instance] execSql:sql];
                [self initData];
                [_tableViewPlan reloadData];
                
            }
            else if(status==-1)
            {
                NSString* sql=[NSString stringWithFormat:@"update t_data_callreport set issubmit='2',errmsg='%@' where key_id='%@'",[result getString:ERRMSG],[_syncRpt getString:@"key_id"]];
                [[DB instance] execSql:sql];
                //                isSync=true;
                toast_showInfoMsg([result getString:ERRMSG], 100);
            }
            
            NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                         selector:@selector(syncRpt)
                                                           object:nil];
            [myThread start];
            
        }
            
            break;
            
            //        case UPLOAD_PLAN:
            //        {
            ////            if (status==1)
            ////            {
            //        {
            //                NSString* sql=[NSString stringWithFormat:@"update t_visit_plan_detail set issubmit='1' where issubmit='0'"];
            //                [[DB instance] execSql:sql];
            //                [self initData];
            //                [_tableViewPlan reloadData];
            ////
            ////            }
            ////            else if(status==-1)
            ////            {
            ////                NSString* sql=[NSString stringWithFormat:@"update t_visit_plan_detail set issubmit='2',errmsg='%@' where issubmit='0' ",[result getString:ERRMSG]];
            ////                [[DB instance] execSql:sql];
            ////                toast_showInfoMsg([result getString:ERRMSG], 100);
            ////            }
            //
            //            NSThread* myThread = [[NSThread alloc] initWithTarget:self
            //                                                         selector:@selector(syncRpt)
            //                                                           object:nil];
            //            [myThread start];
            //        }
            //        }
            //
            //            break;
            
            
            
        case QUERY_MSG:
            if (status==1)
            {
                //                if([[result getString:@"Type"] isEqualToString:@"T_Message_Detail"])
                //                {
                if([[DB instance] upsertData:result])
                {
                    if ([result.getFieldList count ]>0) {
                        toast_showInfoMsg(@"您有新消息",100);
                    }
                }
                else
                {
                    alert_showErrMsg([NSMutableString stringWithFormat:@"%@保存失败", [result getString:RETURNTYPE]]);
                }
                //                }
                
            }
            else if(status==-1)
            {
                alert_showErrMsg([result getString:ERRMSG]);
            }
            
            break;
            
        case UPLOAD_MSG:
            if (status==1)
            {
                NSMutableArray* sqlList=[[NSMutableArray alloc]init];;
                for (NSMutableDictionary* field in _syncRpt.detailList) {
                    [sqlList addString:[NSString stringWithFormat:@"update t_message_detail set issubmit=1 where serverid='%@'",[field getString:@"serverid"]]];
                }
                [[DB instance] execSqlList:sqlList];
            }
            else if(status==-1)
            {
                alert_showErrMsg([result getString:ERRMSG]);
            }
            
            break;
            
        default:
            break;
    }
}



-(void) delegate_requestDidFail:(NSString*) errMsg
{
    stopProgress();
    toast_showInfoMsg(errMsg, 100);
    [self syncRpt];
}


@end
