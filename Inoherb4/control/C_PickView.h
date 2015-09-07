//
//  C_PickView.h
//  SFA1
//
//  Created by Ren Yong on 14-4-11.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_UIItem.h"
@protocol pickerDelegate <NSObject>
- (void)delegate_selected;
@end

@interface C_PickView : UIView<UITableViewDataSource,UITableViewDelegate>
- (void)showInView:(UIView *) view;
- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data;
@property (weak) id<pickerDelegate> delegate;

- (void)cancelPicker;
@end
