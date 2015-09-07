//
//  C_Filter.h
//  JahwaS
//
//  Created by Bruce on 15/7/9.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
#import "C_PickView.h"

@protocol delegate_filter <NSObject>
- (void)delegate_filter_ok;
@end
@interface C_Filter : UIView<UITableViewDataSource, UITableViewDelegate,delegateView,pickerDelegate>

@property(nonatomic, retain) NSMutableArray* list;
@property(nonatomic, retain) NSMutableDictionary* field;
@property(nonatomic, assign) BOOL keyboardShow;

- (void)showInView:(UIView *) view;
- (id)init:(CGRect)frame panelList:(NSMutableArray *)panelList data:(NSMutableDictionary*)data;
- (void)cancelPicker;

@property (weak) id<delegate_filter> delegate_filter;
@end
