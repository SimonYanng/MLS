//
//  C_TempView.m
//  SFA
//
//  Created by Ren Yong on 13-11-21.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_TempView.h"
#import "F_Color.h"
#import "D_Panel.h"
#import "C_ItemView.h"
#import "F_Phone.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"

@interface C_TempView ()
{
    UITableView *_tableView;
    NSObject<delegateView> *_delegate;
    int _type;
    D_Report*_curRpt;
}
@end
@implementation C_TempView
int KeybHeight=216;

@synthesize list,field,keyboardShow;

- (id)init:(CGRect)frame panelList:(NSMutableArray *)panelList data:(NSMutableDictionary*)data delegate:(NSObject<delegateView> *) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type=1;
        list=panelList;
        field=data;
        _delegate=delegate;
        keyboardShow=NO;
        [self initTableView:frame];
        [self regKeyBoard];
    }
    return self;
}

- (id)init:(CGRect)frame panelList:(NSMutableArray *)panelList rpt:(D_Report*)rpt delegate:(NSObject<delegateView> *) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type=2;
        _curRpt=rpt;
        list=panelList;
        //        field=data;
        _delegate=delegate;
        keyboardShow=NO;
        [self initTableView:frame];
        [self regKeyBoard];
    }
    return self;
}

-(void)regKeyBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)dismiss
{
//    [self endEditing:YES];
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
    frame.size.height -= (KeybHeight+40);
    
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
    frame.size.height += (KeybHeight+40);
    _tableView.frame = frame;
    [UIView beginAnimations:@ "ResizeView"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView commitAnimations];
    keyboardShow=NO;
}

-(void) initTableView:(CGRect)frame
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = col_LightGray();
    [self addSubview:_tableView];
}

-(void)reloadData
{
    [_tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    C_RptCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    D_Panel* panel=[list panelAt:indexPath.section];
    D_UIItem* item=[panel itemAt:indexPath.row];
    //    if(!cell)
    //       cell=[[C_RptCell  alloc]initWith:field item:item];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //    if(!cell)
    //    {
    //       cell=[[C_RptProductCell alloc]initWith:field panel:productPanel];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    C_ItemView* itemView;
    //    if(item.verifyType==BIGTEXT)
    //        itemView=[[C_ItemView alloc]initWithFrame:CGRectMake(0, 0, screenW(), 2*CELLHEIGHT) item:item data:field delegate:_delegate];
    //    else
    
    if(_type==2)
        field=[_curRpt detailFieldAt:indexPath.section];
    
    itemView=[[C_ItemView alloc]initWithFrame:CGRectMake(0, 0, screenW(), 70) item:item data:field delegate:_delegate];
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
    //    D_Field* field=(D_Field*)[mList objectAt:(int)indexPath.row];
    //    if (mDelegate && [mDelegate respondsToSelector:@selector(delegate_clickCell:)])
    //    {
    //        [mDelegate delegate_clickCell:field];
    //    }
    //    [_tableView  deselectRowAtIndexPath:[_tableView  indexPathForSelectedRow] animated:YES];
    //    [self  endEditing:YES];
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
    //    D_Panel* panel=[list panelAt:indexPath.section];
    //    D_UIItem* item=[panel itemAt:indexPath.row];
    //    if(item.verifyType==BIGTEXT)
    //        return 2*CELLHEIGHT;
    //    else
    return 70;
}
@end
