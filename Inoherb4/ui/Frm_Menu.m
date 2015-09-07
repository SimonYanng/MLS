//
//  Frm_Menu.m
//  Inoherb
//
//  Created by Bruce on 15/3/27.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "Frm_Menu.h"
#import "F_Color.h"
#import "F_UserData.h"
#import "F_Alert.h"
#import "C_NavigationBar.h"
#import "Constants.h"
#import "C_GradientButton.h"
#import "Frm_ShowDataList.h"
#import "C_Label.h"
#import "D_TempGroup.h"
#import "NSMutableArray+Tool.h"
#import "F_Template.h"
#import "C_CellRpt.h"

#import "NSMutableDictionary+Tool.h"
#import "Frm_Rpt.h"
#import "DB.h"
#import "Frm_HDlist.h"
#import "C_ViewButtonList.h"
@interface Frm_Menu ()
{
    NSMutableDictionary* _dicClientInfo;
    UITableView* _tableViewRptList;
    
    NSMutableArray* _listRpt;
    NSMutableArray* _listComRpt;
    
    int _selectIndex;
    C_ViewButtonList* viewButton;
    D_Template* _template;
    
}
@end

@implementation Frm_Menu

-(id)init:(NSMutableDictionary*)data
{
    self = [super init];
    if(self)
    {
        _dicClientInfo=data;
        _selectIndex=0;
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
    [self initTempList];
    [self initData];
    [self initUI];
}

-(void)initTempList
{
    if ([[_dicClientInfo getString:@"outlettype"] isEqualToString:@"-1"])
    {
        _listRpt=tempGroup_task();
    }
    else
        _listRpt=tempGroup_sales();
}
-(void)initData
{
    NSMutableDictionary* data=[NSMutableDictionary dictionary];
    [data put:[_dicClientInfo getString:@"serverid"] key:@"clientid"];
    [data put:[_dicClientInfo getString:@"key"] key:@"key"];
    _listComRpt=[[DB instance] fieldListByData:data type:COMPLETERPT];
}

-(void)initUI
{
    self.view.backgroundColor = col_Background();
    [self addNavigationBar];
    [self initCheckPhoto:CHECKIN];
    [self initCheckPhoto:CHECKOUT];
    [self initTableViewRpt];
    //    [self addViewBottom];
}

-(void)addNavigationBar
{
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:[_dicClientInfo getString:@"fullname"]];
    [self.view addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Back setTitle:@"离店" forState:UIControlStateNormal];
    [btn_Back useAddHocStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
//    C_GradientButton* btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
//    [btn_Hoc setTitle:@"提交" forState:UIControlStateNormal];
//    [btn_Hoc useAddHocStyle];
//    [btn_Hoc addTarget:self action:@selector(addHoc:) forControlEvents:UIControlEventTouchUpInside];
//    [bar addRightButton:btn_Hoc];
}




-(BOOL)checkRpt
{
    D_Template* temp;
    BOOL have=NO;
    for (D_TempGroup* temGroup in _listRpt) {
        for (int i=0;i<temGroup.tempCount;i++) {
            temp=[temGroup templateAt:i];
            have=NO;
            if(temp.isMustComplete)
            {
                for (NSMutableDictionary* dic in _listComRpt) {
                    if([dic getInt:@"onlytype"] ==temp.onlyType)
                    {
                        have=YES;
                        break;
                    }
                }
                if(!have)
                {
                    toast_showInfoMsg([NSString stringWithFormat:@"%@必须填写",temp.name], 100);
                    return  false;
                }
            }
        }
    }
    return YES;
}

- (void)backClicked:(id)sender
{
    if([self isCheckIn])
    {
        if([self checkRpt])
        {
            if(![self isCheckOut])
                toast_showInfoMsg(@"离店前请拍结束照片", 100);
            else
                [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)initCheckPhoto:(PhotoType)type
{
    C_CheckPhoto *checkin;
    if(type==CHECKIN)
        checkin = [[C_CheckPhoto alloc] initWithFrame:CGRectMake(0, SYSTITLEHEIGHT, self.view.frame.size.width, CHECKPHOTOHEIGHT) type:type clientInfo:_dicClientInfo];
    else
        checkin = [[C_CheckPhoto alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-CHECKPHOTOHEIGHT, self.view.frame.size.width, CHECKPHOTOHEIGHT) type:type clientInfo:_dicClientInfo];
    checkin.form=self;
    checkin.delegate=self;
    [self.view addSubview:checkin];
}

-(void)delegate_SavePhoto
{
    if([self isCheckIn])
    {
        if([self checkRpt])
        {
                [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
}
-(void)initTableViewRpt
{
    _tableViewRptList = [[UITableView alloc]initWithFrame:CGRectMake(0, SYSTITLEHEIGHT+CHECKPHOTOHEIGHT,self.view.frame.size.width,self.view.frame.size.height-SYSTITLEHEIGHT-CHECKPHOTOHEIGHT*2) style:UITableViewStylePlain];
    _tableViewRptList.delegate = self;
    _tableViewRptList.dataSource = self;
    _tableViewRptList.separatorColor = col_LightGray();
    [self.view addSubview:_tableViewRptList];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self initData];
    [_tableViewRptList reloadData];
}

#pragma mark - TableViewdelegate&&TableViewdataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    D_TempGroup* group=[_listRpt tempGroupAt:section];
    return group.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(_selectIndex==section)
    {
        D_TempGroup* group=[_listRpt tempGroupAt:section];
        return [group tempCount];
    }
    else
        return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_listRpt count];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static int itemHeight=40;
    D_TempGroup* group=[_listRpt tempGroupAt:section];
    
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, itemHeight-2)];
    //    titleView.autoresizesSubviews = YES;
    //    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleView.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClicked:)];
    singleTap.delegate= self;
    singleTap.accessibilityLabel=[NSString stringWithFormat:@"%d",section];
    singleTap.cancelsTouchesInView = NO;
    [titleView addGestureRecognizer:singleTap];
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.view.frame.size.width, itemHeight);
    UIColor *endColor =UIColorFromRGB(0xF2F8FA);
    gradient.colors = [NSArray arrayWithObjects:(id)[endColor CGColor],
                       (id)[endColor CGColor],nil];
    [titleView.layer insertSublayer:gradient atIndex:0];
    
    C_Label* lable=[[C_Label alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, itemHeight)  label:group.name];
    lable.backgroundColor=col_ClearColor();
    lable.textAlignment=NSTextAlignmentLeft;
    lable.textColor=[UIColor blackColor];
    [lable setText:[NSString stringWithFormat:@"  %@",group.name]];
    [titleView addSubview:lable];
    
    UIView* line=[[UIView alloc] initWithFrame:CGRectMake(0, itemHeight-0.5, self.view.frame.size.width, 0.5)];
    line.backgroundColor=col_LightGray();
    [titleView addSubview:line];
    return titleView;
}

- (void)imgClicked:(id)sender
{
    _selectIndex=[((UITapGestureRecognizer*)sender).accessibilityLabel intValue];
    [_tableViewRptList reloadData];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    D_TempGroup* group=[_listRpt tempGroupAt:indexPath.section];
    
    D_Template* template=[group templateAt:(int)indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    C_CellRpt* cellRpt=[[C_CellRpt alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) template:template];
    [cellRpt refresh:_listComRpt];
    [cell addSubview:cellRpt];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    D_TempGroup* group=[_listRpt tempGroupAt:indexPath.section];
    
    [self toCallRpt:[group templateAt:(int)indexPath.row]];
}

-(NSMutableArray*)buttonList
{
    NSMutableArray* buttonList=[[NSMutableArray alloc] init];
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"是" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [buttonList addDict:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"否" key:@"name"];
    [button putInt:2 key:@"buttonId"];
    [buttonList addDict:button];
    
    return buttonList;
}

-(void)toCallRpt:(D_Template*)template
{
    
    if([self isCheckIn])
    {
        
            if(template.inputType==2)
        {
//            Frm_HDlist * nextFrm = [[Frm_HDlist alloc] init:_dicClientInfo ];
//            [self.navigationController pushViewController:nextFrm animated:YES];
        }
        else
        {
           if(template.inputType==3)
            {
                _template=template;
                if(viewButton)
                {
                    [viewButton cancelPicker];
                }
                viewButton=[[C_ViewButtonList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) buttonList:[self buttonList] title:template.name];
                viewButton.delegate=self;
                [viewButton showInView:self.view];
            }
            else
            {

            NSMutableDictionary* dicRptData=[NSMutableDictionary dictionary];
            [dicRptData put:[_dicClientInfo getString:@"serverid"] key:@"serverid"];
            [dicRptData put:[NSString stringWithFormat:@"%d", template.onlyType ] key:@"templateid"];
            
            [dicRptData put:[_dicClientInfo getString:@"outlettype"] key:@"outlettype"];
            
            [dicRptData put:[_dicClientInfo getString:@"fullname"] key:@"fullname"];
            
            [dicRptData put:[_dicClientInfo getString:@"key"] key:@"key"];
            
            [dicRptData put:template.name key:@"name"];
            
            Frm_Rpt * nextFrm = [[Frm_Rpt alloc] init:dicRptData ];
            [self.navigationController pushViewController:nextFrm animated:YES];
            }
        }
    }
    else
        toast_showInfoMsg(@"请先拍摄进店照片", 100);
}

-(void)delegate_buttonClick:(int)buttonId
{
    if(viewButton)
    {
        [viewButton cancelPicker];
    }
    switch (buttonId) {
        case 1:
        {
            D_Template* template= temp_ById([NSString stringWithFormat:@"%d", _template.onlyType ],@"");
            D_Report* report;
            if (template) {
                report=[[DB instance] curRpt:template field:_dicClientInfo];
            }
            
            [report putValue:@"1" key:@"int2"];
            [report putValue:@"" key:@"str1"];
            [report resetAttField];
            
             if ([[DB instance] creatRpt:report]>0)
             {
                 [self initData ];
                   [_tableViewRptList reloadData];
             }
            else
                toast_showInfoMsg(@"保存失败,请重试", 100);
            
        }
            break;
        case 2:
        {
            
            NSMutableDictionary* dicRptData=[NSMutableDictionary dictionary];
            [dicRptData put:[_dicClientInfo getString:@"serverid"] key:@"serverid"];
            [dicRptData put:[NSString stringWithFormat:@"%d", _template.onlyType ] key:@"templateid"];
            
            [dicRptData put:[_dicClientInfo getString:@"outlettype"] key:@"outlettype"];
            
            [dicRptData put:[_dicClientInfo getString:@"fullname"] key:@"fullname"];
            
            [dicRptData put:[_dicClientInfo getString:@"key"] key:@"key"];
            
            [dicRptData put:_template.name key:@"name"];
            
            Frm_Rpt * nextFrm = [[Frm_Rpt alloc] init:dicRptData ];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(BOOL)isCheckIn
{
    if ( [self report:temp_CheckIn()].isSaved) {
        return YES;
    }
    return NO;
}

-(BOOL)isCheckOut
{
    if ( [self report:temp_CheckOut()].isSaved) {
        return YES;
    }
    return NO;
}

-(D_Report*)report:(D_Template*)template
{
    D_Report* report;
    if (template) {
        report=[[DB instance] curRpt:template field:_dicClientInfo];
    }
    template=nil;
    return report;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
