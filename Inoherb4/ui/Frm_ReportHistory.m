//
//  Frm_ReportHistory.m
//  JahwaS
//
//  Created by Bruce on 15/7/9.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "Frm_ReportHistory.h"
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
#import "Frm_ReportHistoryDetail.h"
#import "C_Visit.h"
@interface Frm_ReportHistory ()
{
    UITableView* _tableViewHD;
    D_Panel* _panelHD;
    NSMutableArray* _listHD;
    C_ViewButtonList* viewButton;
    NSMutableDictionary* _selectData;
    
    int _questionStatus;
    C_Filter* _filter;
    NSMutableDictionary* _queryData;
    RequestType _syncType;
    NSMutableDictionary* _filterData;
}
@end

@implementation Frm_ReportHistory

-(id)init
{
    self = [super init];
    if(self)
    {
        _filterData=[NSMutableDictionary dictionary ];
        NSString* lastDate=diffDate(today(),-7);
        [_filterData put:lastDate key:@"StartDate"];
        [_filterData put:today() key:@"EndDate"];
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


-(void) panelPlan
{
    _panelHD=[[D_Panel alloc]init];
    _panelHD.name=@"拜访列表";
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"日期";
    item.controlType=NONE;
    item.dataKey=@"ReportDate";
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
    item.caption=@"地址";
    item.controlType=NONE;
    item.verifyType=DEFAULT;
    item.dataKey=@"Address";
    item.lableWidth=25;
    item.textAlignment=NSTextAlignmentCenter;
    item.isShowCaption=YES;
    [_panelHD addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"渠道";
    item.controlType=NONE;
    item.verifyType=DEFAULT;
    item.dataKey=@"OutletTypeName";
    item.lableWidth=25;
    item.textAlignment=NSTextAlignmentCenter;
    item.isShowCaption=YES;
    [_panelHD addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"省";
    item.controlType=NONE;
    item.verifyType=DEFAULT;
    item.dataKey=@"DistrictName";
    item.lableWidth=25;
    item.textAlignment=NSTextAlignmentCenter;
    item.isShowCaption=YES;
    [_panelHD addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"城市";
    item.controlType=NONE;
    item.verifyType=DEFAULT;
    item.dataKey=@"CityName";
    item.lableWidth=25;
    item.textAlignment=NSTextAlignmentCenter;
    item.isShowCaption=YES;
    [_panelHD addItem:item];
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
    [self showFilter];
}

-(void)addNavigationBar
{
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"拜访回顾"];
    [self.view addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) buttonId:-1];
    [btn_Back setTitle:@"" forState:UIControlStateNormal];
    [btn_Back useImgStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    C_GradientButton* btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Hoc setTitle:@"筛选" forState:UIControlStateNormal];
    [btn_Hoc useAddHocStyle];
    [btn_Hoc addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside];
    [bar addRightButton:btn_Hoc];
}

- (void)filterClick:(id)sender
{
    [self showFilter];
}

-(void)showFilter
{
    if(_filter)
    {
        [_filter cancelPicker];
        _filter=nil;
    }
    _filter=[[C_Filter alloc]init:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) panelList:[self panelList] data:_filterData ];
    _filter.delegate_filter=self;
    [_filter showInView:self.view];
}

-(void)delegate_filter_ok
{
        if(_filter)
        {
            [_filter cancelPicker];
            _filter=nil;
        }
        pro_showInfoMsg(@"正在查询,请稍候");
        [self querData];
}



-(void)querData
{
    _queryData=[NSMutableDictionary dictionary];
    [_queryData putKey:user_Id() key:@"userId"];
    
    [_queryData putKey:[_filterData getString:@"outlettype"] key:@"outlettype"];
    [_queryData putKey:[_filterData getString:@"districtid"] key:@"districtid"];
    [_queryData putKey:[_filterData getString:@"cityid"] key:@"cityid"];
//    [_queryData putKey:[_filterData getString:@"empname"] key:@"empname"];
    [_queryData putKey:[_filterData getString:@"outletname"] key:@"outletname"];
    [_queryData putKey:[_filterData getString:@"startdate"] key:@"startdate"];
    [_queryData putKey:[_filterData getString:@"enddate"] key:@"enddate"];
    
    [_queryData putKey:[_filterData getString:@"address"] key:@"address"];
    
    
    [_queryData putKey:@"GetVisitCardsList" key:METHOD];
    
    _syncType=QUERY_REQUEST;
    [[SyncWeb instance]syncWeb:QUERY_REQUEST field:_queryData delegate:self];
}

-(NSMutableArray*)panelList
{
    NSMutableArray* panelList=[[NSMutableArray alloc]init];
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"筛选";
    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"渠道";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"OutletType";
    item.dicId=@"185";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"省份";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"DistrictId";
    item.dicId=@"-101";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"城市";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"CityId";
    item.dicId=@"-102";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"门店名称/编码";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"OutletName";
    item.dicId=@"-101";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"门店地址";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"address";
    item.dicId=@"-101";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"开始时间";
    item.controlType=DATE;
    item.verifyType=DEFAULT;
    item.dataKey=@"StartDate";
    item.dicId=@"-101";
    item.isMustInput=YES;
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"结束时间";
    item.controlType=DATE;
    item.verifyType=DEFAULT;
    item.dataKey=@"EndDate";
    item.dicId=@"-101";
    item.isMustInput=YES;
    item.lableWidth=100;
    [panel addItem:item];
    
    [panelList addPanel:panel];
    return panelList;
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


#pragma mark - TableViewdelegate&&TableViewdataSource
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_listHD count];
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
    int count=[_panelHD itemCount];
    
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
        item=[_panelHD itemAt:i];
        lableW=width*item.lableWidth/100;
        
        lable=[[C_Label alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW-0.3, itemHeight)  label:item.caption];
        lable.backgroundColor=col_ClearColor();
        lable.textAlignment=item.textAlignment;
        lable.textColor=[UIColor blackColor];
        if(item.textAlignment==NSTextAlignmentLeft)
            [lable setText:[NSString stringWithFormat:@"  %@",item.caption]];
        [titleView addSubview:lable];
        oldLableW+=lableW;
    }
    return titleView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary* field=[_listHD dictAt:(int)indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    C_Visit* itemView=[[C_Visit alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CELLHEIGHT) field:field panel:_panelHD];
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
    //    _selectClient=[_listPlan dictAt:(int)indexPath.row];
    //    [self toCallCard:1];
    _selectData=[_listHD dictAt:(int)indexPath.row];
    Frm_ReportHistoryDetail * nextFrm = [[Frm_ReportHistoryDetail alloc] init:_selectData ];
    [self.navigationController pushViewController:nextFrm animated:YES];
}

-(void)delegate_buttonClick:(int)buttonId
{
    if(viewButton)
    {
        [viewButton cancelPicker];
    }
    D_Report* report=[[D_Report alloc] init];
    [report putValue:@"-200" key:@"TemplateId"];
    [report putValue:[_selectData getString:@"ServerId"] key:@"INT1"];
    
    [report putValue:today() key:@"ReportDate"];
    [report putValue:user_Id() key:@"userid"];
    
    switch (buttonId) {
        case 1:
        {
            _questionStatus=1;
            [report putValue:@"1" key:@"INT2"];
        }
            break;
        case 2:
        {
            _questionStatus=2;
            [report putValue:@"2" key:@"INT2"];
        }
            break;
            
        default:
            break;
    }
    pro_showInfoMsg(@"正在更新问题状态");
    [[SyncWeb instance]syncWeb:UPLOAD_REQUEST report:report delegate:self];
}

//-(NSMutableArray*)buttonList
//{
//    NSMutableArray* buttonList=[[NSMutableArray alloc] init];
//    NSMutableDictionary* button=[NSMutableDictionary dictionary];
//    [button put:@"已报修" key:@"name"];
//    [button putInt:1 key:@"buttonId"];
//    [buttonList addDict:button];
//
//    button=[NSMutableDictionary dictionary];
//    [button put:@"已完成" key:@"name"];
//    [button putInt:2 key:@"buttonId"];
//    [buttonList addDict:button];
//
//    return buttonList;
//}


- (void)delegate_requestDidSuccess:(D_SyncResult*)result
{
    stopProgress();
    int status=[result getInt:SUCCESS];
    if (status==1)
    {
        _listHD=result.getFieldList;
        [_tableViewHD reloadData];
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
