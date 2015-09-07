//
//  C_Filter.m
//  JahwaS
//
//  Created by Bruce on 15/7/9.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "C_Filter.h"
#import "F_Color.h"
#import "D_Panel.h"
#import "C_ItemView.h"
#import "F_Phone.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "C_NavigationBar.h"
#import "C_GradientButton.h"
#import "F_Alert.h"
#import "DB.h"
#import "F_Date.h"
@interface C_Filter ()
{
    UITableView *_tableView;
    //    NSObject<delegateView> *_delegate;
    int _type;
    C_PickView* _pickView;
}
@end
@implementation C_Filter
@synthesize delegate_filter=_delegate_filter;
int KeybHeightFilter=216;

@synthesize list,field,keyboardShow;

- (id)init:(CGRect)frame panelList:(NSMutableArray *)panelList data:(NSMutableDictionary*)data{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor colorWithWhite:0.7 alpha:0.5];
        _type=1;
        list=panelList;
        field=data;
        //        _delegate=delegate;
        keyboardShow=NO;
        //        [self initTableView:frame];
        [self addNavigationBar];
        [self regKeyBoard];
    }
    return self;
}

-(void)addNavigationBar
{
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(50, 0, self.frame.size.width-50, SYSTITLEHEIGHT) title:@"筛选"];
    [self addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    [btn_Back setTitle:@"取消" forState:UIControlStateNormal];
    [btn_Back useAddHocStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    C_GradientButton* btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Hoc setTitle:@"确定" forState:UIControlStateNormal];
    [btn_Hoc useAddHocStyle];
    [btn_Hoc addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
    [bar addRightButton:btn_Hoc];
}
-(BOOL)checkData
{
    if([[field getString:@"plan"]isEqualToString:@"1"])
        return YES;
    if([[field getString:@"startdate"] isEqualToString:@""]||[[field getString:@"enddate"] isEqualToString:@""])
    {
        toast_showInfoMsg(@"请选择时间段", 100);
        return NO;
    }
    else if([[field getString:@"startdate"] compare:[field getString:@"enddate"]]==NSOrderedDescending)
    {
        toast_showInfoMsg(@"结束时间不能小于开始时间", 100);
        return NO;
    }
    else
    {
        NSString* date=diffDate([field getString:@"startdate"] , 30);
        if([date compare:[field getString:@"enddate"]]==NSOrderedAscending)
        {
            toast_showInfoMsg(@"时间段选择不能超过30天", 100);
            return NO;
        }
    }
    return YES;
}

//-(NSString *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month
//{
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//
//    [comps setMonth:month];
//
//    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//
//    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
//
//    return  mDate;
//}

- (void)okClick:(id)sender
{
    if([self checkData ])
    {
        [self cancelPicker];
        if (_delegate_filter) {
            [_delegate_filter delegate_filter_ok];
        }
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


-(void)regKeyBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)dismiss
{
    [self endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = [_tableView frame];
    //    CGRect frame1 = [mCancelBack frame];
    if(keyboardShow)
        return;
    //    KeybHeight=keyboardRect.size.height;
    frame.size.height -= (KeybHeightFilter+40);
    _tableView.frame =frame;
    CGRect rect = [_tableView frame];
    [_tableView scrollRectToVisible:rect animated:YES];
    
    [UIView beginAnimations:@ "ResizeView"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView commitAnimations];
    
    keyboardShow=YES;
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = [_tableView frame];
    frame.size.height +=  (KeybHeightFilter+40);
    _tableView.frame = frame;
    [UIView beginAnimations:@ "ResizeView"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView commitAnimations];
    keyboardShow=NO;
}

-(void) initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(50,SYSTITLEHEIGHT,self.frame.size.width-50,self.frame.size.height-SYSTITLEHEIGHT) style:UITableViewStylePlain];
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

- (void)delegate_clickButton:(D_UIItem*)item data:(NSMutableDictionary*)data
{
    [self dismissKeyboard];


    if([item.dataKey isEqualToString:@"IsDeal"])
    {
        if([[data getString:@"chanceid"] isEqualToString:@""])
        {
            toast_showInfoMsg(@"请先选择问题类型", 100);
            return;
        }
       else if([[data getString:@"chanceid"] isEqualToString:@"3"])
            item.dicId=@"202";
        else
            item.dicId=@"191";
    }
   else if([item.dataKey isEqualToString:@"CityId"])
    {
        if([[data getString:@"DistrictId"] isEqualToString:@""])
        {
            toast_showInfoMsg(@"请先选择省份", 100);
            return;
        }
    }
    
    [self showPickerView:item data:data];
    
}

-(void)showPickerView:(D_UIItem *)item data:(NSMutableDictionary *)data
{
    if(_pickView)
        [_pickView cancelPicker];
    _pickView=[[C_PickView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) item:item data:data];
    _pickView.delegate=self;
    [_pickView showInView:self];
}

-(void)delegate_selected
{
    
    
    
    if(_tableView)
        [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    D_Panel* panel=[list panelAt:indexPath.section];
    D_UIItem* item=[panel itemAt:indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    C_ItemView* itemView;
    itemView=[[C_ItemView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 70) item:item data:field delegate:self];
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
