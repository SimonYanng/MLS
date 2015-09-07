//
//  C_ViewHDClientList.m
//  Inoherb
//
//  Created by Bruce on 15/3/31.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "C_ViewHDClientList.h"
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
@interface C_ViewHDClientList()
{
    UITableView* _tvDataList;
    NSMutableDictionary* _data;
    D_UIItem* _item;
    NSMutableArray* _dataList;
    D_Panel* dataPanel;
}
@end
@implementation C_ViewHDClientList
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor=col_Black1();
        [self initPanel];
        [self addNavigationBar];
        [self initDataList];
        [self initTableView];
    }
    return self;
}


-(void)initDataList
{
    NSMutableString* sql=[NSMutableString stringWithFormat:@"SELECT * FROM t_outlet_main where outlettype=1 and serverid in (select clientid from t_activity_main)  order by  fullname"];
    _dataList = [[DB instance] fieldListBy:sql];
}

-(void)addNavigationBar
{
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SYSTITLEHEIGHT) title:@"活动门店"];
    [self addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    [btn_Back setTitle:@"返回" forState:UIControlStateNormal];
    [btn_Back useAddHocStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
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
    
    _tvDataList.showsVerticalScrollIndicator=NO;
    [self addSubview:_tvDataList];
}

- (void)showInView:(UIView *) view
{
    self.alpha=1;
    [view addSubview:self];
    
    [UIView animateWithDuration:0.5
                     animations:^
     {
         [UIView  setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
     }
                     completion:^(BOOL finished){
                     }];
}


- (void)cancelPicker
{
    self.alpha=0;
    [UIView animateWithDuration:0.5
                     animations:^
     {
         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[self superview] cache:YES];
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
    C_ProductItemView* itemView=[[C_ProductItemView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50) field:field panel:dataPanel delegate:nil report:nil];
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
        [_delegate delegate_hdselected:field];
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
