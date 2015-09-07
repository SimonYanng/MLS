//
//  C_MutiPickerView.h
//  SFA1
//
//  Created by Ren Yong on 14-4-11.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_UIItem.h"
#import "C_PickView.h"
@interface C_MutiPickerView : UIView<UITableViewDataSource,UITableViewDelegate>
- (void)showInView:(UIView *) view;
- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data;
@property (weak) id<pickerDelegate> delegate;
@end
