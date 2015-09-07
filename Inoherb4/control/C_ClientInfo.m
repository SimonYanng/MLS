//
//  C_ClientInfo.m
//  JahwaS
//
//  Created by Bruce on 15/7/9.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "C_ClientInfo.h"
#import "F_Color.h"
#import "D_Panel.h"
#import "C_ItemView.h"
#import "F_Phone.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "C_NavigationBar.h"
#import "C_GradientButton.h"
@interface C_ClientInfo ()
{
    UITableView *_tableView;
    int _type;
    C_PickView* _pickView;
}
@end

@implementation C_ClientInfo
@synthesize delegate_clientInfo=_delegate_clientInfo;

@synthesize list,field,keyboardShow;

- (id)init:(CGRect)frame panelList:(NSMutableArray *)panelList data:(NSMutableDictionary*)data{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor colorWithWhite:0.7 alpha:0.5];
        _type=1;
        list=panelList;
        field=data;
        keyboardShow=NO;
        //        [self initTableView];
        [self addNavigationBar];
    }
    return self;
}

-(void)addNavigationBar
{
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SYSTITLEHEIGHT) title:@"门店信息"];
    [self addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    [btn_Back setTitle:@"取消" forState:UIControlStateNormal];
    [btn_Back useAddHocStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    if([list count]>1)
    {
        C_GradientButton* btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [btn_Hoc setTitle:@"开始拜访" forState:UIControlStateNormal];
        [btn_Hoc useAddHocStyle];
        [btn_Hoc addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
        [bar addRightButton:btn_Hoc];
    }
}

- (void)okClick:(id)sender
{
    [self cancelPicker];
    if (_delegate_clientInfo) {
        [_delegate_clientInfo delegate_clientInfo_ok];
    }
}

- (void)backClicked:(id)sender
{
    [self cancelPicker];
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
                         [self dismiss];
                     }];
}



-(void)dismiss
{
    [self endEditing:YES];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
}

-(void) initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,SYSTITLEHEIGHT,self.frame.size.width,self.frame.size.height-SYSTITLEHEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = col_LightGray();
    [self addSubview:_tableView];
}

-(void)reloadData
{
    [_tableView reloadData];
}

-(void)dismissKeyboard
{
    [self  endEditing:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    D_Panel* panel=[list panelAt:indexPath.section];
    D_UIItem* item=[panel itemAt:indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    C_ItemView* itemView;
    itemView=[[C_ItemView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 70) item:item data:field delegate:nil];
    [cell addSubview:itemView];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    D_Field* group=[mList objectAt:section];
    D_Panel* panel=[list panelAt:section];
    
    return [panel itemCount];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView reloadData];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static int itemHeight=40;
    D_Panel* panel=[list panelAt:section];
    
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, itemHeight)];
    titleView.autoresizesSubviews = YES;
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleView.userInteractionEnabled = YES;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.frame.size.width, itemHeight);
    UIColor *endColor =UIColorFromRGB(0xF2F8FA);
    gradient.colors = [NSArray arrayWithObjects:(id)[endColor CGColor],
                       (id)[endColor CGColor],nil];
    [titleView.layer insertSublayer:gradient atIndex:0];
    
    C_Label* lable=[[C_Label alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, itemHeight)  label:panel.name];
    lable.backgroundColor=col_ClearColor();
    lable.textAlignment=NSTextAlignmentLeft;
    lable.textColor=[UIColor blackColor];
    [lable setText:[NSString stringWithFormat:@"  %@",panel.name]];
    [titleView addSubview:lable];
    
    return titleView;
}

//设置section的标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    D_Panel* panel=[list panelAt:section];
    if(panel.showTitle)
        return 40;//HEADHEIGHT;
    else
        return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [list count];
}

//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
}

@end
