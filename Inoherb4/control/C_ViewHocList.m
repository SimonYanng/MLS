//
//  C_ViewHocList.m
//  Inoherb
//
//  Created by Bruce on 15/3/26.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "C_ViewHocList.h"
#import "F_Color.h"
#import "DB.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "F_Font.h"
#import "C_Label.h"
#import "F_Date.h"
#import "C_NavigationBar.h"
#import "C_GradientButton.h"
#import "C_ProductItemView.h"
#import "NSString+Tool.h"

@interface C_ViewHocList()
{
    UITableView* _tvDataList;
    NSMutableDictionary* _data;
    D_UIItem* _item;
    NSMutableArray* _dataList;
    D_Panel* dataPanel;
    UISearchBar* _searchBar;
    NSMutableDictionary* _filterData;
}
@end

@implementation C_ViewHocList
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor=col_Black1();
        _filterData=[NSMutableDictionary dictionary];
         [_filterData put:@"1" key:@"plan"];
        [self initPanel];
        [self addNavigationBar];
        
//        [self addSearch];
        [self initDataList:@""];
        [self initTableView];
    }
    return self;
}


//-(void)addSearch
//{
//    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,SYSTITLEHEIGHT, self.frame.size.width, 40)];
//    
//    if(!SYSTEM_VERSION_LESS_THAN(@"7.0"))
//    {
//        _searchBar.barTintColor = col_Background();
//        _searchBar.tintColor=[UIColor redColor];
//        _searchBar.layer.borderColor=col_Background().CGColor;
//        _searchBar.layer.borderWidth=1;
//    }
//    _searchBar.placeholder=@"搜索门店";
//    _searchBar.delegate = self;
//    
//    
//    //    [_searchBar.subviews objectAtIndex:0]  ;
//    //    _searchBar.barStyle =UIBarStyleBlackTranslucent;
//    //    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
//    //    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    //    _searchBar.keyboardType = UIKeyboardTypeDefault;
//    
//    [self addSubview:_searchBar];
//}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self endEditing:YES];
    [_searchBar setShowsCancelButton:NO animated:YES];
    if([[searchBar text]isEmpty])
    {
        [searchBar setText:@""];
        [self initDataList:@""];
        [_tvDataList reloadData];
    }
}

-(void)delegate_filter_ok
{
    [self initDataList:@""];
    [_tvDataList reloadData];
}

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
//    _searchBar.showsScopeBar = NO;
//    [_searchBar setShowsCancelButton:YES animated:YES];
//    
//    if(!SYSTEM_VERSION_LESS_THAN(@"7.0"))
//    {
//        for(id cc in [searchBar subviews])
//        {
//            for (id zz in [cc subviews]) {
//                if([zz isKindOfClass:[UIButton class]])
//                {
//                    UIButton *btn = (UIButton *)zz;
//                    [btn setTitle:@"取消"  forState:UIControlStateNormal];
//                    [btn.titleLabel setFont:fontBysize(15)];
//                }
//            }
//        }
//    }
//    
//    return YES;
//}
//
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    
//    [self endEditing:YES];
//    if([[searchBar text] length]>0)
//    {
//        [self initDataList:[searchBar text]];
//        [_tvDataList reloadData];
//    }
//}


-(void)initDataList:(NSString*)key
{
    NSMutableString* sql=[NSMutableString stringWithFormat:@"select * ,0 as selected,outletcode||fullname as fullname ,fullname as name  from t_outlet_main where serverid not in ( select clientid from t_visit_plan_detail where strftime('%%Y-%%m-%%d',VisitTime) ='%@') ",today()];
    
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
     [sql appendFormat:@" order by outlettype desc, fullname limit 20"];
//    else
//        sql=[NSMutableString stringWithFormat:@"SELECT *,facialdiscount as clienttype FROM t_outlet_main where fullname like  '%%%@%%' or outletcode like '%%%@%%' and serverid not in ( select clientid from t_visit_plan_detail where strftime('%%Y-%%m-%%d',VisitTime) ='%@') order by outlettype desc, fullname limit 20",key,key,today()];
    NSLog(@"%@",sql);
    _dataList = [[DB instance] fieldListBy:sql];
}

-(void)addNavigationBar
{
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SYSTITLEHEIGHT) title:@"计划外"];
    [self addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    [btn_Back setTitle:@"取消" forState:UIControlStateNormal];
    [btn_Back useAddHocStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
//    C_GradientButton* btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
//    [btn_Hoc setTitle:@"筛选" forState:UIControlStateNormal];
//    [btn_Hoc useAddHocStyle];
//    [btn_Hoc addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bar addRightButton:btn_Hoc];
}

- (void)filterClick:(id)sender
{
    
    C_Filter* filter=[[C_Filter alloc]init:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) panelList:[self panelList] data:_filterData ];
    filter.delegate_filter=self;
    [filter showInView:self];
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
    
 D_UIItem*   item=[[D_UIItem alloc]init];
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

- (void)backClicked:(id)sender
{
    [self cancelPicker];
}

-(void)initTableView
{
    _tvDataList=[[UITableView alloc] initWithFrame:CGRectMake(0,SYSTITLEHEIGHT, self.frame.size.width, self.frame.size.height-SYSTITLEHEIGHT) style:UITableViewStylePlain];
    [_tvDataList setSeparatorColor:col_Background()];
    _tvDataList.delegate = self;
    _tvDataList.dataSource = self;
    
    //    _tvDataList.showsVerticalScrollIndicator=NO;
    [self addSubview:_tvDataList];
}

- (void)showInView:(UIView *) view
{
    self.alpha=1;
    [view addSubview:self];
    //    [UIView animateWithDuration:0.5 animations:^{
    //        _tvDataList.frame = CGRectMake(0, SYSTITLEHEIGHT,self.frame.size.width,self.frame.size.height-SYSTITLEHEIGHT);
    //    }];
    
    [UIView animateWithDuration:0.5
                     animations:^
     {
         [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:view cache:YES];
     }
                     completion:^(BOOL finished){
                         [self initTableView];
                     }];
}


- (void)cancelPicker
{
    //    [UIView animateWithDuration:0.5
    //                     animations:^
    //     {
    //         _tvDataList.frame = CGRectMake(0, self.frame.size.height,self.frame.size.width,self.frame.size.height-SYSTITLEHEIGHT);
    //     }
    //                     completion:^(BOOL finished){
    //                         [self removeFromSuperview];
    //                     }];
    
    self.alpha=0;
    [UIView animateWithDuration:0.5
                     animations:^
     {
         [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:[self superview] cache:YES];
     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

-(void)cancelClicked:(id)sender
{
    [self cancelPicker];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary* field=[_dataList dictAt:(int)indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
   C_ProductItemView* itemView=[[C_ProductItemView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, CELLHEIGHT) field:field panel:dataPanel delegate:nil report:nil];
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
    return [_dataList count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* field=[_dataList dictAt:indexPath.row];
    if(_delegate)
        [_delegate delegate_selected:field];
    [self cancelPicker];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static int itemHeight=40;
    //    static int viewGap=0;
    int width=self.frame.size.width;
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
        
        lable=[[C_Label alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW-0.3, itemHeight)  label:item.caption];
        lable.backgroundColor=col_ClearColor();
        lable.textAlignment=item.textAlignment;
        lable.textColor=[ UIColor blackColor ];
        if(item.textAlignment==NSTextAlignmentLeft)
            [lable setText:[NSString  stringWithFormat:@"  %@", item.caption ]];
        [titleView addSubview:lable];
        oldLableW+=lableW;
    }
    return titleView;
    
}

-(void)initPanel
{
    dataPanel =[[D_Panel alloc]init];
    dataPanel.name=@"门店名称";
    dataPanel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"客户";
    item.controlType=NONE;
    item.dataKey=@"fullname";
    item.lableWidth=100;
    item.placeholder=@"客户";
    item.isShowCaption=YES;
    item.isMustInput=YES;
    item.textAlignment=NSTextAlignmentLeft;
    [dataPanel addItem:item];
    
    
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

@end
