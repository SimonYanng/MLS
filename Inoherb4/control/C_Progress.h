//
//  C_Progress.h
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C_Progress : UIView

@property (nonatomic ,retain) UIView *background;
@property (nonatomic ,retain) UIActivityIndicatorView *activity;
@property (nonatomic ,retain) UILabel *label;

- (void)show;
//-(C_Progress*) newInstance:(CGRect)frame msg:(NSString*)msg;
- (id)initWithFrame:(CGRect)frame msg:(NSString*)msg;

- (void)dismissAfterDelay:(NSTimeInterval)timeInterval;
@end
