//
//  Frm_PlanList.m
//  SFA1
//
//  Created by Ren Yong on 14-4-10.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "Frm_PlanList.h"
#import "F_Color.h"
#import "C_NavigationBar.h"
#import "C_Button.h"
#import "Constants.h"
#import "DB.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "F_Alert.h"
//#import "C_DrawerView.h"
#import "F_Font.h"
#import "C_TempView.h"
#import "F_Template.h"
#import "NSString+Tool.h"
#import "F_Tool.h"
#import "C_GradientButton.h"
#import "F_date.h"
@interface Frm_PlanList ()
{
    UISearchBar* _searchBar;
    UITableView* _tabView;
    NSMutableArray* _clientList;
    NSMutableDictionary* _selectClientList;
    NSString* selectDate;
    C_Filter* _filter;
    NSMutableDictionary* _filterData;
}
@end

@implementation Frm_PlanList

-(id)initWithDate:(NSString*)callDate
{
    self = [super init];
    if (self)
    {
        selectDate=callDate;
        _filterData=[NSMutableDictionary dictionary];
        [_filterData put:@"1" key:@"plan"];
    }
    return self;
}

//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
    _selectClientList=[NSMutableDictionary dictionary];
    NSMutableDictionary* data=[NSMutableDictionary dictionary];
    [data put:selectDate key:@"date"];
    _clientList =[[DB instance] fieldListBy:[NSMutableString stringWithFormat:@"SELECT t.* ,case when p.key_id is not null then 1 else 0 end as selected FROM t_outlet_main t left join (select * from  T_Visit_Plan_Detail  where visittime ='%@' and isdel=0 and issubmit!=2) p on t.serverid=p.clientid order by selected desc,fullname limit 100",[data getString:@"date"]]];
    
    for (NSMutableDictionary* client in _clientList) {
        if ([[client getString:@"selected"] isEqualToString:@"1"])
            [_selectClientList putKey:client key:[client getString:@"serverid"]];
    }
}


-(void)initUI
{
    self.view.backgroundColor = col_Background();
    //    self.view.layer.cornerRadius=CORNERRADIUS;
    
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:selectDate];
    [self.view addSubview:bar];
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Back setTitle:@"返回" forState:UIControlStateNormal];
    [btn_Back useAddHocStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    C_GradientButton* btn_Submit=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Submit setTitle:@"筛选" forState:UIControlStateNormal];
    [btn_Submit useAddHocStyle];
    [btn_Submit addTarget:self action:@selector(filterClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addRightButton1:btn_Submit];
    
    btn_Submit=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Submit setTitle:@"提交" forState:UIControlStateNormal];
    [btn_Submit useAddHocStyle];
    [btn_Submit addTarget:self action:@selector(addPlanClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addRightButton:btn_Submit];
    
//    btn_Submit=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, SYSTITLEHEIGHT, self.view.frame.size.width, 40)];
//    [btn_Submit setTitle:@"添加事件" forState:UIControlStateNormal];
//    [btn_Submit useToStyle];
//    [btn_Submit addTarget:self action:@selector(addPlanClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_Submit];
    
//    [self initSearchBar];
    [self initTableView];
}

-(void)filterClicked:(id)sender
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
    [self initDataList];
    for (NSMutableDictionary* client in _clientList) {
        if([_selectClientList objectForKey:[client getString:@"serverid"]]) {
            [client put:@"1" key:@"selected"];
        }
        else
            [client put:@"0" key:@"selected"];
    }
    
    [_tabView reloadData];
}

-(void)initDataList
{
    NSMutableString* sql=[NSMutableString stringWithFormat:@"select * ,0 as selected,outletcode||fullname as fullname ,fullname as name  from t_outlet_main where 1=1 "];
  
    if(![[_filterData getString:@"OutletName"] isEmpty])
        [sql appendFormat:@" and (fullname like '%%%@%%' or outletcode like '%%%@%%')", [_filterData getString:@"OutletName"],[_filterData getString:@"OutletName"]];
    if(![[_filterData getString:@"clienttype"] isEmpty])
        [sql appendFormat:@" and int1='%@'", [_filterData getString:@"clienttype"]];
    if(![[_filterData getString:@"OutletType"] isEmpty])
        [sql appendFormat:@" and int2='%@'", [_filterData getString:@"OutletType"]];
    if(![[_filterData getString:@"address"] isEmpty])
        [sql appendFormat:@" and address like'%%%@%%' ", [_filterData getString:@"address"]];
    if(![[_filterData getString:@"DistrictId"] isEmpty])
        [sql appendFormat:@" and ParentId='%@'", [_filterData getString:@"DistrictId"]];
    if(![[_filterData getString:@"CityId"] isEmpty])
        [sql appendFormat:@" and OrgId='%@'", [_filterData getString:@"CityId"]];
    [sql appendFormat:@" order by selected desc,fullname  limit 50"];
    NSLog(@"%@",sql);
    _clientList = [[DB instance] fieldListBy:sql];
}

-(NSMutableArray*)panelList
{
    NSMutableArray* panelList=[[NSMutableArray alloc]init];
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"筛选";
    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
//    D_UIItem* item=[[D_UIItem alloc]init];
//    item.caption=@"客户类型";
//    item.controlType=SINGLECHOICE;
//    item.dataKey=@"clienttype";
//    item.dicId=@"70";
//    item.lableWidth=100;
//    [panel addItem:item];
//    
//    item=[[D_UIItem alloc]init];
//    item.caption=@"渠道";
//    item.controlType=SINGLECHOICE;
//    item.dataKey=@"OutletType";
//    item.dicId=@"185";
//    item.lableWidth=100;
//    [panel addItem:item];
//    
//    item=[[D_UIItem alloc]init];
//    item.caption=@"省份";
//    item.controlType=SINGLECHOICE;
//    item.dataKey=@"DistrictId";
//    item.dicId=@"-101";
//    item.lableWidth=100;
//    [panel addItem:item];
//    
//    item=[[D_UIItem alloc]init];
//    item.caption=@"城市";
//    item.controlType=SINGLECHOICE;
//    item.dataKey=@"CityId";
//    item.dicId=@"-102";
//    item.lableWidth=100;
//    [panel addItem:item];
    
  D_UIItem*  item=[[D_UIItem alloc]init];
    item.caption=@"门店名称/编码";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"OutletName";
    item.dicId=@"-101";
    item.lableWidth=100;
    [panel addItem:item];
    
//    item=[[D_UIItem alloc]init];
//    item.caption=@"门店地址";
//    item.controlType=TEXT;
//    item.verifyType=DEFAULT;
//    item.dataKey=@"address";
//    item.dicId=@"-101";
//    item.lableWidth=100;
//    [panel addItem:item];
    
    [panelList addPanel:panel];
    return panelList;
}


-(void)dismissKeyboard
{
    [[self view] endEditing:YES];
}


-(void)initTableView
{
    _tabView=[[UITableView alloc] initWithFrame:CGRectMake(0,SYSTITLEHEIGHT, self.view.frame.size.width, self.view.frame.size.height-SYSTITLEHEIGHT) style:UITableViewStylePlain];
    [_tabView setSeparatorColor:col_Background()];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    [self.view addSubview:_tabView];
}

-(void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addPlanClicked:(id)sender
{
//    [self cancelSearch];
    if ([[DB instance] upsertPlan:[_selectClientList allValues] callDate: selectDate]>0) {
        toast_showInfoMsg(@"计划设定成功", 100);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
        toast_showInfoMsg(@"计划设定失败", 100);
}

//-(void)cancelSearch
//{
//    [self.view endEditing:YES];
//    [_searchBar setShowsCancelButton:NO animated:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary* field=[_clientList dictAt:indexPath.row];
    static NSString* identifier=@"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
        cell=[[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    cell.textLabel.text=[field getString:@"fullname"];
    cell.textLabel.font=fontBysize(14);
    if (indexPath.row % 2)
    {
        [cell setBackgroundColor:col_Background()];
    }else {
        [cell setBackgroundColor:col_ClearColor()];
    }
    
    if ([[field getString:@"selected"] isEqualToString:@"1"])
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType=UITableViewCellAccessoryNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_clientList count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* field=[_clientList dictAt:indexPath.row];
    if ([[field getString:@"selected"] isEqualToString:@"1"])
    {
        [field put:@"0" key:@"selected"];
        NSLog(@"serverid:%@",[field getString:@"serverid"]);
        [_selectClientList removeObjectForKey:[field getString:@"serverid"]];
    }
    else
    {
        [field put:@"1" key:@"selected"];
        [_selectClientList put:field key:[field getString:@"serverid"]];
    }
    
//    [self cancelSearch];
    [_tabView reloadData];
}

//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"门店";
}

//设置section的标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 50;
}

@end
