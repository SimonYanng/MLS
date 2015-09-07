//
//  C_ItemView.h
//  SFA
//
//  Created by Ren Yong on 13-11-14.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "D_UIItem.h"
#import "C_CheckBox.h"
#import "F_Delegate.h"
#import "C_Label.h"
#import "C_TextField.h"
#import "C_DatePicker.h"
#import "C_DropView.h"
#import "C_GradientButton.h"
@interface C_ItemView : UIView


@property(nonatomic, weak) NSObject<delegateView>* delegate;
//
@property(nonatomic, retain) C_Label* lable;
@property(nonatomic, retain) C_TextField* textField;
@property(nonatomic, retain) C_CheckBox* checkBox;
@property(nonatomic, retain) C_DatePicker* datePicker;
@property(nonatomic, retain) C_DropView* pickView;

@property(nonatomic, retain) C_GradientButton* takePhoto;
@property(nonatomic, retain) C_GradientButton* selectProduct;

- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data delegate:(NSObject<delegateView>*) delegate;
-(CGFloat)cellHight;
@end
