//
//  Frm_HDlist.m
//  Inoherb
//
//  Created by Bruce on 15/3/31.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "Frm_HDlist.h"
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
#import "F_Tool.h"
#import "F_Font.h"
//#import "Frm_ShowQuestionDetail.h"
@interface Frm_HDlist ()
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

@implementation Frm_HDlist

-(id)init
{
    self = [super init];
    if(self)
    {
        //        _dicClientInfo=data;
        //        _filterData=[NSMutableDictionary dictionary ];
        //        NSString* lastDate=diffDate(today(),-30);
        //        [_filterData put:lastDate key:@"StartDate"];
        //        [_filterData put:today() key:@"EndDate"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    [self panelPlan];
    [self initData];
    [self initUI];
    
    //    [self showFilter];
    
}

-(void)initData
{
    _listHD=[[DB instance] fieldListBy1:[NSString stringWithFormat:@"select * from t_data_callreport where onlytype=9 and issubmit!=2"]];
}

-(void)viewDidAppear:(BOOL)animated
{
    _listHD=[[DB instance] fieldListBy1:[NSString stringWithFormat:@"select * from t_data_callreport where onlytype=9 and issubmit!=2"]];
    [_tableViewHD reloadData];
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
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"潜在客户"];
    [self.view addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) buttonId:-1];
    [btn_Back setTitle:@"" forState:UIControlStateNormal];
    [btn_Back useImgStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    C_GradientButton* btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Hoc setTitle:@"新增" forState:UIControlStateNormal];
    [btn_Hoc useAddHocStyle];
    [btn_Hoc addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [bar addRightButton:btn_Hoc];
}

- (void)addClick:(id)sender
{
    //    [self showFilter];
    NSMutableDictionary* dicRptData=[NSMutableDictionary dictionary];
    [dicRptData put:@"-1" key:@"serverid"];
    [dicRptData put:@"9" key:@"templateid"];
    
    [dicRptData put:@"1" key:@"outlettype"];
    
    [dicRptData put:@"-1" key:@"key_id"];
    
    //    [dicRptData put:[_dicClientInfo getString:@"fullname"] key:@"fullname"];
    
    [dicRptData put:myUUID() key:@"key"];
    
    [dicRptData put:@"潜在客户" key:@"name"];
    
    Frm_Rpt * nextFrm = [[Frm_Rpt alloc] init:dicRptData ];
    [self.navigationController pushViewController:nextFrm animated:YES];
    
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
    _tableViewHD.separatorColor = [UIColor colorWithWhite:0.9 alpha:1];
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
    return 50;
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

//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    static int itemHeight=40;
//    //    static int viewGap=0;
//    int width=self.view.frame.size.width;
//    int lableW=0;
//    int oldLableW=0;
//    int count=[_panelHD itemCount];
//
//    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, itemHeight)];
//    titleView.autoresizesSubviews = YES;
//    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    titleView.userInteractionEnabled = YES;
//
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = CGRectMake(0, 0, width, itemHeight);
//    UIColor *endColor =UIColorFromRGB(0xD9ECF1);
//    gradient.colors = [NSArray arrayWithObjects:(id)[endColor CGColor],
//                       (id)[endColor CGColor],nil];
//    [titleView.layer insertSublayer:gradient atIndex:0];
//
//    D_UIItem* item;
//    C_Label*  lable;
//    for (int i=0; i<count; i++) {
//        item=[_panelHD itemAt:i];
//        lableW=width*item.lableWidth/100;
//
//        lable=[[C_Label alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW-0.3, itemHeight)  label:item.caption];
//        lable.backgroundColor=col_ClearColor();
//        lable.textAlignment=item.textAlignment;
//        lable.textColor=[UIColor blackColor];
//        if(item.textAlignment==NSTextAlignmentLeft)
//            [lable setText:[NSString stringWithFormat:@"  %@",item.caption]];
//        [titleView addSubview:lable];
//        oldLableW+=lableW;
//    }
//    return titleView;
//}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary* field=[_listHD dictAt:(int)indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleBlue;
        if (indexPath.row % 2)
        {
            [cell setBackgroundColor:col_Background()];
        }else {
            [cell setBackgroundColor:col_ClearColor()];
        }
        [cell.textLabel setFont:fontBysize(14)];
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@  --  %@",[field  getString:@"str1"],[field  getString:@"updatetime"] ];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    _selectClient=[_listPlan dictAt:(int)indexPath.row];
    //    [self toCallCard:1];
    _selectData=[_listHD dictAt:(int)indexPath.row];
    NSMutableDictionary* dicRptData=[NSMutableDictionary dictionary];
    [dicRptData put:@"-1" key:@"serverid"];
    [dicRptData put:@"9" key:@"templateid"];
    
    [dicRptData put:@"1" key:@"outlettype"];
    
    [dicRptData put:[_selectData getString:@"key_id"] key:@"key_id"];
    
    //    [dicRptData put:[_dicClientInfo getString:@"fullname"] key:@"fullname"];
    
    [dicRptData put:myUUID() key:@"key"];
    
    [dicRptData put:@"潜在客户" key:@"name"];
    
    Frm_Rpt * nextFrm = [[Frm_Rpt alloc] init:dicRptData ];
    [self.navigationController pushViewController:nextFrm animated:YES];
}



@end
