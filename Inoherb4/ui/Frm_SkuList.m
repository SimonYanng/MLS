//
//  Frm_SkuList.m
//  Shequ
//
//  Created by Ren Yong on 14-1-12.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "Frm_SkuList.h"

#import "C_NavigationBar.h"
#import "F_Color.h"
#import "C_Button.h"
#import "Constants.h"
#import "C_Bottom.h"
#import "Frm_SubmitRpt.h"
#import "D_Report.h"
#import "F_Alert.h"
#import "DB.h"
#import "F_Template.h"
#import "F_Date.h"
#import "C_SkuViewCell.h"

@implementation Frm_SkuList

//@synthesize skuView=_skuView;

int tableViewHeight;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    isFirst=YES;
    [self loadSkuList];
    [self initUI];
}

//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_skuView reloadData];
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
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"当日考勤"];
    [self.view addSubview:bar];
    
//    C_GradientButton* btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
//    [btn_Hoc setTitle:@"计划外" forState:UIControlStateNormal];
//    [btn_Hoc useAddHocStyle];
//    [btn_Hoc addTarget:self action:@selector(addHoc:) forControlEvents:UIControlEventTouchUpInside];
//    [bar addRightButton:btn_Hoc];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) buttonId:-1];
    [btn_Back setTitle:@"" forState:UIControlStateNormal];
    [btn_Back useImgStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    [self initSkuView];
}
-(void)initSkuView
{
    _skuView = [[UITableView alloc]initWithFrame:CGRectMake(0, SYSTITLEHEIGHT+1,self.view.frame.size.width,self.view.frame.size.height-SYSTITLEHEIGHT-1) style:UITableViewStylePlain];
    _skuView.delegate = self;
    _skuView.dataSource = self;
    _skuView.separatorColor = col_ClearColor();
    [self.view addSubview:_skuView];
}

//加载分类数据
- (void)loadSkuList{
    arr_kaoqin = [[NSMutableArray alloc]init];
    NSMutableDictionary* field=[NSMutableDictionary dictionary];
    [field put:@"上班时间" key:@"title"];
    [field put:@"-3" key:@"TemplateId"];
    [arr_kaoqin addDict:field];
    
    field=[NSMutableDictionary dictionary];
    [field put:@"下班时间" key:@"title"];
    [field put:@"-4" key:@"TemplateId"];
    [arr_kaoqin addDict:field];
    
//    field=[[D_Field alloc]init];
//    [field put:@"当日请假" key:@"title"];
//    [field put:@"3" key:@"TemplateId"];
//    [skuResult addField:field];
}

//加载分类数据
//- (void)loadOtherList{
//    otherResult = [[D_SyncResult alloc]init];
//    D_Field* field=[[D_Field alloc]init];
//    [field put:@"其他上班时间" key:@"title"];
//    [field put:@"-7" key:@"TemplateId"];
//    [otherResult addField:field];
//    
//    field=[[D_Field alloc]init];
//    [field put:@"其他下班时间" key:@"title"];
//    [field put:@"-8" key:@"TemplateId"];
//    [otherResult addField:field];
//    
//    field=[[D_Field alloc]init];
//    [field put:@"离岗事件" key:@"title"];
//    [field put:@"-5" key:@"TemplateId"];
//    [otherResult addField:field];
//}
-(int)cellHeight
{
    return (self.view.frame.size.height-SYSTITLEHEIGHT-1)/2;
}

#pragma mark - TableViewdelegate&&TableViewdataSource
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    return 200;// [self cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if(section!=0)
//    return 20;
//    else
        return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
////    return [self.headViewArray objectAtIndex:section];
//    return <#expression#>
//}

//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//     if(section!=0)
//         return @"其他";
//    else
        return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    D_Result* value=[result getResult:section];

    return [arr_kaoqin count];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary* field=[arr_kaoqin dictAt:indexPath.row];
    C_SkuViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
        cell=[[C_SkuViewCell alloc ]init: field];
//    }
    if(!isFirst)
        [cell refresh];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary* field=[arr_kaoqin dictAt:indexPath.row];

    NSString* tempId=[field getString:@"TemplateId"];
    if(([tempId isEqualToString:@"-3"]||[tempId isEqualToString:@"-4"])&&[self isSaved: [field getString:@"TemplateId"]])
    {
        toast_showInfoMsg(@"此报告不能重复填写",100);
    }
    else if(([tempId isEqualToString:@"-4"]||[tempId isEqualToString:@"-5"]||[tempId isEqualToString:@"-7"]||[tempId isEqualToString:@"-8"])&&![self isSaved: @"-3"])
    {
        toast_showInfoMsg(@"请先填写上班报告",100);
    }
    else
    {
        isFirst=NO;
        Frm_SubmitRpt *nextFrm = [[Frm_SubmitRpt alloc] init:field];
        [self.navigationController pushViewController:nextFrm animated:YES];
    }
}

-(BOOL)isSaved:(NSString*)tempLateId
{
    NSMutableDictionary* field=[NSMutableDictionary dictionary];
    [field put:today() key:@"date"];
    D_Report* rpt=[[DB instance] curRpt:temp_ById(tempLateId,@"") field:field];
    if([rpt attSize]>0)
        return YES;
    return NO;
}
@end
