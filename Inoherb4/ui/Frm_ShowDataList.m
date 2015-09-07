//
//  Frm_ShowDataList.m
//  UzroBA
//
//  Created by Bruce on 15/3/25.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "Frm_ShowDataList.h"
#import "F_Color.h"
#import "DB.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "F_Font.h"
#import "C_ProductItemView.h"
#import "F_Phone.h"
#import "F_Date.h"
#import "F_UserData.h"
#import "SyncWeb.h"
#import "F_Alert.h"
#import "C_NavigationBar.h"
#import "Constants.h"
#import "C_Button.h"
#import "C_GradientButton.h"
#import "Frm_SubmitRpt.h"
#import "C_ViewButtonList.h"
#import "Frm_SetPlan.h"
#import "C_ShowImg.h"
#import "Frm_Rpt.h"
#import "Frm_HDlist.h"
#import "F_Tool.h"
#import "Frm_Menu.h"
@interface Frm_ShowDataList ()
{
    NSMutableDictionary* _selectData;
    C_ViewButtonList*_viewButton;
    NSMutableDictionary* _dicData;
    C_ShowImg* _showImg;
    BOOL isFirst;
    
}
@end

@implementation Frm_ShowDataList
@synthesize dataList,dataPanel,showType;

//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initPanel];
    [self initUI];
}


-(void)viewWillAppear:(BOOL)animated
{
    if(showType<100)
    {
         pro_showInfoMsg(@"正在加载");//DESC
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    if(showType>100)
    {
        if(isFirst)
        {
            [self initData];
        }
        else
        {
            if(showType!=104&&showType!=200)
                [self initData];
        }
        if(_tableView)
            [_tableView reloadData];
        else
            [self initTableView];
    }
    else
    {
       
        [self querData];
    }
}

-(void)initData
{
    
    NSMutableString* sql;
    if(showType==101)
        sql=[NSMutableString stringWithFormat:@"select p.* ,case when c.key_id is null then '0' else '1' end as status from (SELECT serverid , fullname  FROM t_product where isSensitive='2') p left join (select * from t_data_callreport where onlyType=1 and  reportdate='%@') c on p.serverid=c.int8 group by p.serverid",today()];
    else  if(showType==102)
        sql=[NSMutableString stringWithFormat:@"SELECT p.*,o.fullname as fullname FROM t_client_rlt_activitypromoter p left join t_outlet_Main o on p.clientid=o.serverid order by key_id desc"];
    
    else  if(showType==103)
        sql=[NSMutableString stringWithFormat:@"select * from t_sys_dictionary where dicttype='%@' and dictclass>0",@"10027"];
    
    else  if(showType==104)
        sql=[NSMutableString stringWithFormat:@"SELECT  p.serverid as serverid , p.outletid as outletid , p.outletcode as outletcode , p.outlettype as outlettype , p.fullname as fullname , p.shortname as shortname , p.channelid as channelid , p.orgid as orgid , p.regionid as regionid , p.chainstoreid as chainstoreid , p.facialdiscount as facialdiscount , p.facediscount as facediscount , p.milkdiscount as milkdiscount , p.newdiscount as newdiscount , p.demiwarecount as demiwarecount , p.address as address , p.logesticaddress as logesticaddress , p.zip as zip , p.tel as tel , p.fax as fax , p.deldate as deldate , p.isend as isend , p.outletlevel as outletlevel , p.attribute as attribute , p.remark as remark , p.str1 as str1 , p.str2 as str2 , p.str3 as str3 , p.str4 as str4 , p.str5 as str5 , p.str6 as str6 , p.str7 as str7 , p.str8 as str8 , p.str9 as str9 , p.str10 as str10 ,  case when r.issubmit is null then '' when r.issubmit=0 then '已保存' when r.issubmit=1 then '已提交' when r.issubmit=2 then '上传失败' end as str10 FROM (select * from  t_outlet_main where outlettype=1) p  left join (select * from t_data_callreport where onlyType='1' and reportdate='%@' and int8='%@' ) r on p.serverid=r.clientid order by p.ShortName ",today(),[_dicData getString:@"serverid"]];
    else if(showType==105)
        sql=[NSMutableString stringWithFormat:@"SELECT * FROM t_outlet_main where outlettype=1 and serverid in (select clientid from t_activity_main)  order by  fullname"];
    
    else if(showType==200)
        sql=[NSMutableString stringWithFormat:@"SELECT *, strftime('%%H:%%M:%%S',updatetime) as updatetime ,case when issubmit is 0 then '已保存'  when issubmit is 1 then '已上传'  when issubmit is 2 then '上传失败' end as issubmit, '' as dictname FROM t_data_callreport where onlyType='%d' and ReportDate='%@' and clientId='%@' order by issubmit desc,updatetime desc",-1,today(),[_dicData getString:@"serverid"]];
    
    dataList=[[DB instance] fieldListBy:sql];
    isFirst=NO;
    stopProgress();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initPanel
{
    switch (showType) {
        case 1:
        {
            dataPanel =[[D_Panel alloc]init];
            dataPanel.name=@"当日拜访汇总";
            dataPanel.type=PANEL_PANEL;
            
            D_UIItem* item=[[D_UIItem alloc]init];
            item.caption=@"客户";
            item.controlType=NONE;
            item.dataKey=@"clientname";
            item.lableWidth=50;
            item.placeholder=@"编码";
            item.isShowCaption=YES;
            item.isMustInput=YES;
            item.textAlignment=NSTextAlignmentLeft;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"已拜访";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"isvisit";
            item.lableWidth=25;
            item.textAlignment=NSTextAlignmentCenter;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"耗时(分)";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"timeSpand";
            item.lableWidth=25;
            item.textAlignment=NSTextAlignmentCenter;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
        }
            break;
            
        case 2:
        {
            dataPanel =[[D_Panel alloc]init];
            dataPanel.name=@"门店销量";
            dataPanel.type=PANEL_PANEL;
            
            D_UIItem* item=[[D_UIItem alloc]init];
            item.caption=@"门店名称";
            item.controlType=NONE;
            item.dataKey=@"OutletName";
            item.lableWidth=50;
            item.placeholder=@"编码";
            item.isShowCaption=YES;
            item.isMustInput=YES;
            item.textAlignment=NSTextAlignmentLeft;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"昨天销量";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"SalesAmount";
            item.lableWidth=25;
            item.textAlignment=NSTextAlignmentCenter;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"当月销量";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"MonthsAmount";
            item.lableWidth=25;
            item.textAlignment=NSTextAlignmentCenter;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
        }
            break;
            
        case 3:
        {
            dataPanel =[[D_Panel alloc]init];
            dataPanel.name=@"美顾考勤";
            dataPanel.type=PANEL_PANEL;
            
            D_UIItem* item=[[D_UIItem alloc]init];
            item.caption=@"美顾";
            item.controlType=NONE;
            item.dataKey=@"PromoterName";
            item.lableWidth=25;
            item.placeholder=@"编码";
            item.isShowCaption=YES;
            item.isMustInput=YES;
            item.textAlignment=NSTextAlignmentCenter;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"门店名称";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"OutletName";
            item.lableWidth=50;
            item.textAlignment=NSTextAlignmentLeft;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"上班时间";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"STime";
            item.lableWidth=25;
            item.textAlignment=NSTextAlignmentCenter;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
        }
            break;
            
        case 101:
        {
            dataPanel =[[D_Panel alloc]init];
            dataPanel.name=@"新品选择";
            dataPanel.type=PANEL_PANEL;
            dataPanel.isOperation=YES;
            D_UIItem* item=[[D_UIItem alloc]init];
            item.caption=@"填写状态";
            item.controlType=NONE;
            item.dataKey=@"status";
            item.lableWidth=10;
            item.placeholder=@"编码";
            item.isShowCaption=NO;
            item.isMustInput=YES;
            item.textAlignment=NSTextAlignmentCenter;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"新品名称";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"fullname";
            item.lableWidth=90;
            item.textAlignment=NSTextAlignmentLeft;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
            
        }
            break;
            
        case 102:
        {
            dataPanel =[[D_Panel alloc]init];
            dataPanel.name=@"美顾列表";
            dataPanel.type=PANEL_PANEL;
            dataPanel.isOperation=YES;
            
            D_UIItem* item=[[D_UIItem alloc]init];
            item.caption=@"姓名";
            item.controlType=NONE;
            item.dataKey=@"promotername";
            item.lableWidth=20;
            item.placeholder=@"编码";
            item.isShowCaption=YES;
            item.isMustInput=YES;
            item.textAlignment=NSTextAlignmentCenter;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"门店";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"fullname";
            item.lableWidth=60;
            item.textAlignment=NSTextAlignmentLeft;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"是否排班";
            item.controlType=NONE;
            item.dataKey=@"str1";
            item.lableWidth=20;
            item.placeholder=@"编码";
            item.isShowCaption=YES;
            item.isMustInput=YES;
            item.textAlignment=NSTextAlignmentCenter;
            [dataPanel addItem:item];
            
        }
            break;
            
        case 103:
        {
            dataPanel =[[D_Panel alloc]init];
            dataPanel.name=@"陈列图";
            dataPanel.type=PANEL_PANEL;
            dataPanel.isOperation=YES;
            D_UIItem* item=[[D_UIItem alloc]init];
            item.caption=@"名称";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"dictname";
            item.lableWidth=100;
            item.textAlignment=NSTextAlignmentLeft;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
            
        }
            break;
            
        case 104:
        {
            dataPanel =[[D_Panel alloc]init];
            dataPanel.name=[_dicData getString:@"fullname"];
            dataPanel.type=PANEL_PANEL;
            dataPanel.isOperation=YES;
            D_UIItem* item=[[D_UIItem alloc]init];
            item.caption=@"门店名称";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"shortname";
            item.lableWidth=80;
            item.textAlignment=NSTextAlignmentLeft;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"照片";
            item.controlType=NONE;
            item.verifyType=DEFAULT;
            item.dataKey=@"str10";
            item.lableWidth=20;
            item.textAlignment=NSTextAlignmentCenter;
            item.isShowCaption=YES;
            [dataPanel addItem:item];
        }
            break;
            
        case 105:
        {
            dataPanel =[[D_Panel alloc]init];
            dataPanel.name=@"门店名称";
            dataPanel.type=PANEL_PANEL;
            dataPanel.isOperation=YES;
            D_UIItem* item=[[D_UIItem alloc]init];
            item.caption=@"门店";
            item.controlType=NONE;
            item.dataKey=@"fullname";
            item.lableWidth=100;
            item.placeholder=@"门店";
            item.isShowCaption=YES;
            item.isMustInput=YES;
            item.textAlignment=NSTextAlignmentLeft;
            [dataPanel addItem:item];
        }
            break;
            
        case 200:
        {
            dataPanel =[[D_Panel alloc]init];
            dataPanel.name=@"门店名称";
            dataPanel.type=PANEL_PANEL;
            dataPanel.isOperation=YES;
            D_UIItem* item=[[D_UIItem alloc]init];
            item.caption=@"开始时间";
            item.controlType=NONE;
            item.dataKey=@"updatetime";
            item.lableWidth=70;
            item.isShowCaption=YES;
            item.isMustInput=YES;
            item.textAlignment=NSTextAlignmentLeft;
            [dataPanel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"状态";
            item.controlType=NONE;
            item.dataKey=@"issubmit";
            item.lableWidth=30;
            item.isShowCaption=YES;
            item.isMustInput=YES;
            item.textAlignment=NSTextAlignmentCenter;
            [dataPanel addItem:item];
        }
            break;
            
            if(showType==200)
                
                default:
                break;
    }
    
}
/**
 [""]	<#Description#>加载界面
 [""]	@returns <#return value description#>
 [""] */
-(void)initUI
{
    self.view.backgroundColor = col_Background();
    //    self.view.layer.cornerRadius=CORNERRADIUS;
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"问题跟踪"];
    [self.view addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    [btn_Back setTitle:@"返回" forState:UIControlStateNormal];
    [btn_Back useAddHocStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    if(showType==102||showType==200)
    {
        C_GradientButton* btn_Submit=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        
        [btn_Submit setTitle:@"新增" forState:UIControlStateNormal];
        [btn_Submit useAddHocStyle];
        [btn_Submit addTarget:self action:@selector(submitClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bar addRightButton:btn_Submit];
    }
}
- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitClicked:(id)sender
{
    
    if(showType==102)
    {
        NSMutableDictionary* dicRptData=[NSMutableDictionary dictionary];
        [dicRptData put:@"-1" key:@"serverid"];
        [dicRptData put:[NSString stringWithFormat:@"%d", 20000 ] key:@"templateid"];
        [dicRptData put:@"" key:@"PromoterId"];
        [dicRptData put:@"-1" key:@"clienttype"];
        
        Frm_SubmitRpt * nextFrm = [[Frm_SubmitRpt alloc] init:dicRptData ];
        [self.navigationController pushViewController:nextFrm animated:YES];
    }
    else  if(showType==200)
    {
        [_dicData put:myUUID() key:@"key"];
        Frm_Menu* nextFrm = [[Frm_Menu alloc] init:_dicData];
        [self.navigationController pushViewController:nextFrm animated:YES];
    }
}

-(void)querData
{
    queryData=[NSMutableDictionary dictionary];
    [queryData putKey:user_Id() key:USERID];
    [queryData putKey:@"0" key:@"isAll"];
    [queryData putKey:@"0" key:@"startRow"];
    [queryData putKey:today() key:@"lastTime"];
    
    switch (showType) {
        case 1:
            [queryData putKey:@"GetVisitTotalList" key:METHOD];
            break;
        case 2:
            [queryData putKey:@"GetClientPromoterSalesList" key:METHOD];
            break;
        case 3:
            [queryData putKey:@"GetDPVisitRltClientSalesList" key:METHOD];
            break;
            
        case 103:
            [queryData putKey:[_selectData getString:@"dictclass"] key:@"displaytype"];
            [queryData putKey:@"GetDisplayMsgList" key:METHOD];
            break;
        default:
            break;
    }
    
    syncType=QUERY_REQUEST;
    [self syncWeb:QUERY_REQUEST field:queryData];
}


-(void) syncWeb:(RequestType)type field:(NSMutableDictionary* )field
{
    [[SyncWeb instance]syncWeb:type field:field delegate:self];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (id)initWithFrame:(CGRect)frame type:(int)type
{
    self = [super init];
    if (self) {
        isFirst=YES;
        showType=type;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame type:(int)type data:(NSMutableDictionary *)data
{
    self = [super init];
    if (self) {
        isFirst=YES;
        showType=type;
        _dicData=data;
    }
    return self;
}


-(void)initTableView
{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,SYSTITLEHEIGHT, self.view.frame.size.width, self.view.frame.size.height-SYSTITLEHEIGHT) style:UITableViewStylePlain];
    [_tableView setSeparatorColor:col_ClearColor()];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_tableView];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary* field=[dataList dictAt:(int)indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    C_ProductItemView* itemView=[[C_ProductItemView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CELLHEIGHT) field:field panel:dataPanel delegate:nil report:nil];
    [cell addSubview:itemView];
    if (indexPath.row % 2)
    {
        [cell setBackgroundColor:col_Background()];
    }else {
        [cell setBackgroundColor:col_ClearColor()];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(dataPanel.isOperation)
    {
        _selectData=[dataList dictAt:(int)indexPath.row];
        if(showType==101)
        {
            Frm_ShowDataList * nextFrm = [[Frm_ShowDataList alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height) type:104 data:_selectData];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
        else  if(showType==103)
        {
            pro_showInfoMsg(@"正在加载");
            [self querData];
        }
        else  if(showType==104)
        {
            //            NSMutableDictionary* dicRptData=[NSMutableDictionary dictionary];
            //            [dicRptData put:[_selectData getString:@"serverid"] key:@"serverid"];
            [_selectData put:[NSString stringWithFormat:@"%d", 1 ] key:@"templateid"];
            
            [_selectData put:[_dicData getString:@"serverid"] key:@"productid"];
            
            Frm_Rpt * nextFrm = [[Frm_Rpt alloc] init:_selectData ];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
        else   if(showType==105)
        {
//            Frm_HDlist * nextFrm = [[Frm_HDlist alloc] init:_selectData ];
//            [self.navigationController pushViewController:nextFrm animated:YES];
        }
        else   if(showType==200)
        {
            [_dicData put:[_selectData getString:@"decimal10"] key:@"key"];
            Frm_Menu* nextFrm = [[Frm_Menu alloc] init:_dicData];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
        else
        {
            if(_viewButton)
            {
                [_viewButton cancelPicker];
            }
            _viewButton=[[C_ViewButtonList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) buttonList:[self buttonList] title:[_selectData getString:@"promotername"]];
            _viewButton.delegate=self;
            [_viewButton showInView:self.view];
        }
    }
}

-(void)delegate_buttonClick:(int)buttonId
{
    if(_viewButton)
    {
        [_viewButton cancelPicker];
    }
    switch (buttonId) {
        case 1:
        {
//            NSMutableDictionary* dicRptData=[NSMutableDictionary dictionary];
//            [dicRptData put:[_selectData getString:@"serverid"] key:@"PromoterId"];
//            [dicRptData put:@"-1" key:@"clienttype"];
//            
//            Frm_SetPlan *nextFrm = [[Frm_SetPlan alloc] init:dicRptData];
//            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
        case 2:
        {
            NSMutableDictionary* dicRptData=[NSMutableDictionary dictionary];
            [dicRptData put:[NSString stringWithFormat:@"%d", 20000 ] key:@"templateid"];
            [dicRptData put:[_selectData getString:@"serverid"] key:@"PromoterId"];
            [dicRptData put:@"-1" key:@"clienttype"];
            
            Frm_SubmitRpt * nextFrm = [[Frm_SubmitRpt alloc] init:dicRptData ];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
            
        default:
            break;
    }
}



-(NSMutableArray*)buttonList
{
    NSMutableArray* buttonList=[[NSMutableArray alloc] init];
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"排班" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [buttonList addDict:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"修改" key:@"name"];
    [button putInt:2 key:@"buttonId"];
    [buttonList addDict:button];
    
    return buttonList;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static int itemHeight=40;
    //    static int viewGap=0;
    int width=screenW();
    int lableW=0;
    int oldLableW=0;
    int count=[dataPanel itemCount];
    
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
    D_UIItem* item;
    C_Label*  lable;
    for (int i=0; i<count; i++) {
        item=[dataPanel itemAt:i];
        lableW=width*item.lableWidth/100;
        
        if(item.isShowCaption)
        {
            lable=[[C_Label alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW-0.3, itemHeight)  label:item.caption];
            lable.backgroundColor=col_ClearColor();
            
            if(item.textAlignment==NSTextAlignmentLeft)
                lable.text =[NSString stringWithFormat:@"  %@",item.caption];
            lable.textAlignment=item.textAlignment;
            lable.textColor=[ UIColor blackColor ];
            [titleView addSubview:lable];
        }
        oldLableW+=lableW;
    }
    return titleView;
    
}

//设置section的标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return CELLHEIGHT;
}


- (void)delegate_requestDidSuccess:(D_SyncResult*)result
{
    stopProgress();
    int status=[result getInt:SUCCESS];
    switch (syncType) {
        case QUERY_REQUEST:
            if (status==1)
            {
                if(showType==103)
                {
                    
                    NSMutableDictionary* data =[result.getFieldList dictAt:0];
                    
                    NSLog(@"%@------------------",[data getString:@"Photo"]);
                    [data put:[_selectData getString:@"dictname"] key:@"dictname"];
                    if(_showImg)
                        [_showImg dismiss:YES];
                    _showImg=[[C_ShowImg alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) data:data];
                    [_showImg showInView:self.view];
                }
                else
                {
                    dataList=result.getFieldList;
                    [self initTableView];
                }
                
            }
            else if(status==-1)
            {
                if(showType==103)
                    alert_showErrMsg([result getString:@"ErrorMsg"]);
                else
                    alert_showErrMsg([result getString:ERRMSG]);
            }
            else if(status==-2)
            {
                if(showType==103)
                    alert_showErrMsg([result getString:@"ErrorMsg"]);
                else
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
    alert_showErrMsg(errMsg);
}

@end
