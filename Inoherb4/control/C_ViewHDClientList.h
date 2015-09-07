//
//  C_ViewHDClientList.h
//  Inoherb
//
//  Created by Bruce on 15/3/31.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol hdDelegate <NSObject>
- (void)delegate_hdselected:(NSMutableDictionary*)data;
@end
@interface C_ViewHDClientList : UIView<UITableViewDataSource,UITableViewDelegate>
- (void)showInView:(UIView *) view;
- (id)initWithFrame:(CGRect)frame;
- (void)cancelPicker;
@property (weak) id<hdDelegate> delegate;
@end
