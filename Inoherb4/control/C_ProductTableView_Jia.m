//
//  C_ProductTableView.m
//  Inoherb4
//
//  Created by Ren Yong on 14-2-17.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_ProductTableView_Jia.h"
#import "C_ProductItemView_Jia.h"

#import "F_Color.h"
#import "C_Label.h"
#import "F_Phone.h"

#import "NSMutableArray+Tool.h"
#import "NSMutableDictionary+Tool.h"

@implementation C_ProductTableView_Jia

@synthesize productList,productPanel,keyboardShow;

int KeybHeight_Jia = 216;

- (id)init:(CGRect)frame panel:(D_Panel *)panel productList:(NSMutableArray*)list delegate:(NSObject<delegateView>*) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _delegate=delegate;
        productPanel=panel;
        productList=list;
        keyboardShow=NO;
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

-(void)dismiss
{
    [self endEditing:YES];
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
    frame.size.height -= (KeybHeight_Jia-20);
    
    
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
    frame.size.height += (KeybHeight_Jia-20);
    _tableView.frame = frame;
    [UIView beginAnimations:@ "ResizeView"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView commitAnimations];
    keyboardShow=NO;
}


-(void) initTableView:(CGRect)frame
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor=col_White();
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self addSubview:_tableView];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* field=[productList dictAt:(int)indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //    if(!cell)
    //    {
    //       cell=[[C_RptProductCell alloc]initWith:field panel:productPanel];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    C_ProductItemView_Jia* itemView=[[C_ProductItemView_Jia alloc] initWithFrame:CGRectMake(0, 0, screenW(), CELLHEIGHT) field:field panel:productPanel delegate:_delegate];
    
    [cell addSubview:itemView];
    
    if([[field getString:@"int1" ] isEqualToString:@"1"])
    {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
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
     NSMutableDictionary* field=[productList dictAt:(int)indexPath.row];
    if([[field getString:@"int1"] isEqualToString:@"1"])
        [field put:@"2" key:@"int1"];
    else
          [field put:@"1" key:@"int1"];
    
    [_tableView reloadData];
}

//设置section的标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static int itemHeight=40;
    //    static int viewGap=0;
    int width=screenW();
    int lableW=0;
    int oldLableW=0;
    int count=[productPanel itemCount];
    
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    titleView.autoresizesSubviews = YES;
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleView.userInteractionEnabled = YES;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, width, itemHeight);
    UIColor *endColor = UIColorFromRGB(0xD9ECF1);
    gradient.colors = [NSArray arrayWithObjects:(id)[endColor CGColor],
                       (id)[endColor CGColor],nil];
    [titleView.layer insertSublayer:gradient atIndex:0];

    C_Label*  lable;
    
    //-----------
    lableW= width - 100;
    
    lable=[[C_Label alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW, itemHeight)  label:nil];
    lable.backgroundColor=col_ClearColor();
    lable.textAlignment=NSTextAlignmentCenter;
    lable.textColor=[ UIColor blackColor ];
    
    [titleView addSubview:lable];
    
    NSString *title =  [[NSString alloc] initWithFormat:@"%@/( %@+%@ )", [productPanel itemAt:0].caption, [productPanel itemAt:1].caption, [productPanel itemAt:2].caption];
    
    lable.text = title;
    
    return titleView;
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

