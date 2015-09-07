//
//  C_InputView.m
//  SFA
//
//  Created by Ren Yong on 13-12-3.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_InputView.h"
#import "F_Color.h"
#import "Constants.h"
#import "D_Panel.h"
#import "C_Button.h"
#import "C_NavigationBar.h"
#import "C_ImageView.h"
#import "F_Image.h"
#import "C_ItemView.h"
#import "F_Phone.h"
//@interface C_InputView ()
//{
////    NSObject<delegateInputView>* mDelegate;
//    bool mKeyboardShow;
//    D_Panel* mPanel;
//    D_Field* mInputField;
//    NSObject<delegateView> * mPickDelegate;
//}
//@end

@implementation C_InputView
@synthesize panel=_panel,field=_field,keyboardShow,delegate_View;

int kbHeight=240;
//bool keyboardShown=NO;

-(void)dealloc
{
//    mDelegate=nil;
}

- (id)initWithFrame:(CGRect)frame panel:(D_Panel*)panel field:(NSMutableDictionary*)field
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = col_Background();
        
        [self initTableView:frame];

        _panel=panel;

        _field=field;
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
    frame.size.height -= (kbHeight-20);
    
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
    frame.size.height += (kbHeight-20);
    _tableView.frame = frame;
    [UIView beginAnimations:@ "ResizeView"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView commitAnimations];
    keyboardShow=NO;
}

-(void) initTableView:(CGRect)frame
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor=col_Background();
    
    [_tableView setSeparatorColor:col_Background()];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self addSubview:_tableView];
}

-(void)setTableViewFram:(CGRect)frame
{
    _tableView.frame=frame;
    [_tableView scrollRectToVisible:frame animated:YES];
}

-(void)reloadData
{
    [_tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    D_UIItem* item=[_panel itemAt:indexPath.row];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    }
    [cell.contentView addSubview:[[C_ItemView alloc]initWithFrame:CGRectMake(0, 0, screenW(), 70) item:item data:_field delegate:delegate_View ]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    D_Field* group=[mList objectAt:section];
//    D_Panel* panel=(D_Panel*)[list objectAt:section];
    
    return [_panel itemCount];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self  endEditing:YES];
}

//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //    D_TempGroup* group=[mList objectAt:section];
//    D_Panel* panel=(D_Panel*)[list objectAt:section];
    return _panel.name;
}

//设置section的标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;//HEADHEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
}


@end
