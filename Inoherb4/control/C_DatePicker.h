//
//  C_DatePicker.h
//  Inoherb4
//
//  Created by Ren Yong on 14-2-14.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_UIItem.h"

#import "F_Delegate.h"



@interface C_DatePicker : UIView <UITextFieldDelegate>
{
    UITextField* textField;//文本框
    UIDatePicker* datePicker;//日期选择控件
    NSDateFormatter *dateFormatter;//日期格式
    UIDatePickerMode datePickerMode;//日期控件显示风格
    NSDate* date;
    UIView* subview;
    
    D_UIItem* item;
    NSMutableDictionary* field;
}
@property(nonatomic, weak) NSObject<delegateView>* delegate;
@property(nonatomic) UIDatePickerMode datePickerMode;
//@property(nonatomic,retain)UITextField* textField;
@property(nonatomic,retain)NSDateFormatter* dateFormatter;
@property(nonatomic,retain)NSDate* date;
//@property(nonatomic,retain)UIDatePicker* datePicker;
//-(UIDatePickerMode)datePickerMode;
//-(void)setDatePickerMode:(UIDatePickerMode)mode;
//-(NSDateFormatter*)dateFormatter;
//-(void)setDateFormatter:(NSDateFormatter *)df;
//-(NSDate*)date;
//-(void)setDate:(NSDate*)d;
//-(UITextField*)textField;
//-(UIDatePicker*)datePicker;

- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)uiItem data:(NSMutableDictionary*)userData;
@end
