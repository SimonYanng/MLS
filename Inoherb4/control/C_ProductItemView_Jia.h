//
//  C_ProductItemView_Jia.h
//  JahwaS
//
//  Created by westtalkzzz on 15/7/22.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_UIItem.h"
#import "C_CheckBox.h"
#import "F_Delegate.h"
#import "C_Label.h"
#import "C_TextField.h"
#import "C_DatePicker.h"
#import "D_Panel.h"
#import "NSMutableDictionary+Tool.h"
#import "C_DropView.h"
#import "C_GradientButton.h"

@interface C_ProductItemView_Jia : UIView

@property(nonatomic, retain) C_Label* lable;
@property(nonatomic, retain) C_TextField* textField;
//@property(nonatomic, retain) C_CheckBox* checkBox;
@property(nonatomic, retain) C_DatePicker* datePicker;
@property(nonatomic, retain) C_DropView* pickView;
@property(nonatomic, retain) C_GradientButton* shotPhoto;

@property(nonatomic, weak) NSObject<delegateView>* delegate;

- (id)initWithFrame:(CGRect)frame field:(NSMutableDictionary*)field panel:(D_Panel*)panel delegate:(NSObject<delegateView>*) delegate;

@end
