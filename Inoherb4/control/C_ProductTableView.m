//
//  C_ProductTableView.m
//  Inoherb4
//
//  Created by Ren Yong on 14-2-17.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_ProductTableView.h"

#import "F_Color.h"
#import "C_ProductItemView.h"
#import "C_Label.h"
#import "F_Phone.h"
#import "NSMutableArray+Tool.h"
#import "NSMutableDictionary+Tool.h"
#import "F_Alert.h"
#import "F_Font.h"
@implementation C_ProductTableView
@synthesize delegateProduct=_delegateProduct;
@synthesize productList,productPanel,keyboardShow;

int KeybHeight1=216;

- (id)init:(CGRect)frame panel:(D_Panel *)panel productList:(NSMutableArray*)list delegate:(NSObject<delegateView>*) delegate report:(D_Report*)report
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _report=report;
        _delegate=delegate;
        productPanel=panel;
        productList=list;
        keyboardShow=NO;
        [self initScrollView:frame];
        [self initTableView:frame];
        [self regKeyBoard];
    }
    
    return self;
}

//- (id)init:(CGRect)frame panel:(D_Panel *)panel productList:(D_ArrayList*)list delegate:(NSObject<delegateView> *) delegate
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
////        mList=panelList;
//        productPanel=panel;
////        _delegate=delegate;
//        productList=list;
//        keyboardShow=NO;
//        [self initTableView:frame];
//        [self regKeyBoard];
//    }
//    return self;
//}

-(void)initScrollView:(CGRect)frame
{
    CGFloat w=screenW();
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
    _scrollView.contentSize = CGSizeMake(w, frame.size.height);
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
}

-(void)dismiss
{
//    [self endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
}

-(void)regKeyBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)reloadData
{
    [_tableView reloadData];
}

-(void)refreshData:(NSMutableArray*)list
{
    productList=list;
    [_tableView reloadData];
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = [_tableView frame];
    //    CGRect frame1 = [mCancelBack frame];
    if(keyboardShow)
        return;
    //    KeybHeight1=keyboardRect.size.height;
    frame.size.height -= (KeybHeight1-20);
    
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
    frame.size.height += (KeybHeight1-20);
    _tableView.frame = frame;
    [UIView beginAnimations:@ "ResizeView"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView commitAnimations];
    keyboardShow=NO;
}


-(void) initTableView:(CGRect)frame
{
    CGFloat w=screenW();
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,0,w,frame.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor=col_White();
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_scrollView addSubview:_tableView];
}

-(NSMutableArray*)haveValueList
{
    NSMutableArray* arr_list=[[NSMutableArray alloc]init];
    for (NSMutableDictionary * dic in productList) {
        if(![[dic getString:@"int1"] isEqualToString:@""])
            [arr_list addDict:dic];
    }
    return arr_list;
}

-(void)setTableViewFram:(CGRect)frame
{
    _tableView.frame=frame;
    [_tableView scrollRectToVisible:frame animated:YES];
}

-(BOOL)isInput:(NSMutableDictionary*)product
{
    for (D_UIItem* item in productPanel.itemList) {
        if(item.controlType!=NONE &&![[product getString:item.dataKey] isEqualToString:@""])
        {
            return YES;
        }
    }
    return NO ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* field=[productList dictAt:(int)indexPath.row];
    //    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //    if(!cell)
    //    {
    //       cell=[[C_RptProductCell alloc]initWith:field panel:productPanel];
    UITableViewCell*  cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    //    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(productPanel.intputType==1)
    {
        D_UIItem* item=[productPanel itemAt:0];
        cell.textLabel.text =[field getString:item.dataKey] ;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = col_DarkText();
        cell.textLabel.font=fontBysize(15);
        
        if([self isInput:field])
        {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else
    {
        C_ProductItemView* itemView=[[C_ProductItemView alloc]initWithFrame:CGRectMake(0, 0, screenW(), CELLHEIGHT) field:field panel:productPanel delegate:_delegate report:_report];
        [cell addSubview:itemView];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [productList count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [self endEditing:YES];
    if(productPanel.intputType==1)
    {
        if (_delegateProduct)
        {
            [_delegateProduct delegate_productClick:[productList dictAt:indexPath.row] panel:productPanel];
        }
    }
}

//设置section的标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static int itemHeight=40;
    //    static int viewGap=0;
    int width=screenW();
    int lableW=0;
    int oldLableW=5;
    int count=[productPanel itemCount];
    
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 40)];
    titleView.autoresizesSubviews = YES;
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleView.userInteractionEnabled = YES;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, _tableView.frame.size.width, itemHeight);
    UIColor *endColor =UIColorFromRGB(0xD9ECF1);
    gradient.colors = [NSArray arrayWithObjects:(id)[endColor CGColor],
                       (id)[endColor CGColor],nil];
    [titleView.layer insertSublayer:gradient atIndex:0];
    D_UIItem* item;
    C_Label*  lable;
    if(productPanel.intputType==1)
    {
        item=[productPanel itemAt:0];
        lableW=width;
        
        lable=[[C_Label alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW, itemHeight)  label:item.caption];
        lable.backgroundColor=col_ClearColor();
        lable.textAlignment=NSTextAlignmentLeft;
        lable.textColor=[ UIColor blackColor ];
        [titleView addSubview:lable];
    }
    else
    {
        for (int i=0; i<count; i++) {
            item=[productPanel itemAt:i];
            lableW=width*item.lableWidth/100;
            
            lable=[[C_Label alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW-0.3, itemHeight)  label:item.caption];
            lable.backgroundColor=col_ClearColor();
            lable.textAlignment=NSTextAlignmentCenter;
            lable.textColor=[ UIColor blackColor ];
            [titleView addSubview:lable];
            oldLableW+=lableW;
        }
    }
    return titleView;
}

//设置section的标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;//HEADHEIGHT;
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
