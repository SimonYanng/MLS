//
//  Frm_ReportHistoryDetail.m
//  JahwaS
//
//  Created by Bruce on 15/7/9.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "Frm_ReportHistoryDetail.h"
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
#import "F_Font.h"
#import "Frm_SubmitRpt.h"
#import "Frm_ShowReport.h"
@interface Frm_ReportHistoryDetail ()
{
    UITableView* _tableViewHD;
    D_Panel* _panelHD;
    NSMutableArray* _listHD;
    NSMutableDictionary* _dicClientInfo;
    C_ViewButtonList* viewButton;
    NSMutableDictionary* _selectData;
    
    int _questionStatus;
    C_Filter* _filter;
    NSMutableDictionary* _queryData;
    RequestType _syncType;
    NSMutableDictionary* _filterData;
}
@end

@implementation Frm_ReportHistoryDetail

-(id)init:(NSMutableDictionary*)data
{
    self = [super init];
    if(self)
    {
        _dicClientInfo=data;
        _filterData=[NSMutableDictionary dictionary ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self panelPlan];
    //    [self initData];
    [self initUI];

    pro_showInfoMsg(@"正在查询,请稍候");
    [self querData];
    
}


-(void) panelPlan
{
    _panelHD=[[D_Panel alloc]init];
    _panelHD.name=@"问题列表";
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"问题";
    item.controlType=NONE;
    item.dataKey=@"QuestionName";
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
    item.dataKey=@"ReportDate";
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
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"报告列表"];
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
    [_queryData putKey:user_Id() key:@"userId"];

    [_queryData putKey:[_dicClientInfo getString:@"ClientId"] key:@"clientid"];
    [_queryData putKey:[_dicClientInfo getString:@"reportdate"] key:@"reportdate"];

    [_queryData putKey:@"GetClientReportMain" key:METHOD];
    
    _syncType=QUERY_REQUEST;
    [[SyncWeb instance]syncWeb:QUERY_REQUEST field:_queryData delegate:self];
}

-(BOOL)checkData
{
    
    return YES;
}
-(NSMutableArray*)panelList
{
    NSMutableArray* panelList=[[NSMutableArray alloc]init];
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"筛选";
    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"问题类型";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"chanceid";
    item.dicId=@"189";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
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
    item.caption=@"拜访人";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"EmpName";
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
    _tableViewHD.separatorColor = col_Gray();
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
    return 60;
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
    static NSString* identifier=@"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
        cell=[[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    cell.textLabel.text=[field getString:@"ReportName"];
    cell.textLabel.font=fontBysize(16);
    
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

//        [_selectData put:[NSString stringWithFormat:@"%d",-200 ] key:@"templateid"];
        Frm_ShowReport * nextFrm = [[Frm_ShowReport alloc] init:_selectData ];
        [self.navigationController pushViewController:nextFrm animated:YES];

    
    //    if(viewButton)
    //    {
    //        [viewButton cancelPicker];
    //    }
    //    viewButton=[[C_ViewButtonList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) buttonList:[self buttonList] title:[_selectData getString:@"QuestionName"]];
    //    viewButton.delegate=self;
    //    [viewButton showInView:self.view];
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
