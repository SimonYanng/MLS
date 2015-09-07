//
//  C_CheckBox.h
//  SFA
//
//  Created by Ren Yong on 13-10-15.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_UIItem.h"


#import "F_Delegate.h"


//@class C_DropView;
//@protocol delegateCheckBox
//
//- (void)delegate_Checked:(BOOL)value;
//
//@end

@interface C_CheckBox : UIControl
{
//    UILabel *label;
//    UIImageView *icon;
   
//
//    NSObject<onCheckedChanged>* delegate;
        NSMutableDictionary* data;
        D_UIItem* item;
     BOOL checked;
}


//@property (retain, nonatomic) id delegate;
//@property (retain, nonatomic) UILabel *label;
//@property (retain, nonatomic) UIImageView *icon;
@property(nonatomic, weak) NSObject<delegateView>* delegate;

//@property(nonatomic, retain) D_Field* data;
//@property(nonatomic, retain) D_UIItem* item;
@property(nonatomic, retain) UILabel* lable;
@property(nonatomic, retain) UIImageView* icon;
//@property(nonatomic, assign) BOOL checked;

-(BOOL)isChecked;
-(void)setChecked: (BOOL)flag;
//- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)style;
//-(C_CheckBox*) newInstance:(CGRect)frame item:(D_UIItem*)item data:(D_Field*)data delegate:(NSObject<delegateView>*) delegate;
//-(void)clicked;
- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)uiItem data:(NSMutableDictionary*)userData;

- (id)initWithFrameNoLabel:(CGRect)frame item:(D_UIItem*)uiItem data:(NSMutableDictionary*)userData Size:(int)size callBackWithData:(BOOL)isCall;

@end
