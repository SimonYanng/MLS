//
//  C_Visit.h
//  JahwaS
//
//  Created by westtalkzzz on 15/7/9.
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

@interface C_Visit : UIView

- (id)initWithFrame:(CGRect)frame field:(NSMutableDictionary*)field panel:(D_Panel*)panel;
@end
