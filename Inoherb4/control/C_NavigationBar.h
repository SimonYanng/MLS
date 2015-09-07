//
//  C_NavigationBar.h
//  SFA
//
//  Created by Ren Yong on 13-11-15.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C_NavigationBar : UIView


-(C_NavigationBar*) newInstance:(NSString*)title;
- (void)addRightButton:(UIButton *)rightButton;
- (void)addLeftButton:(UIButton *)leftButton;
-(C_NavigationBar*) newInstanceBy:(NSString*)title;
- (void)addRightButtonNormal:(UIButton *)rightButton;

- (id)initWithFrame:(CGRect)frame title:(NSString*)title;
-(void)resetTitle:(NSString*)title;

- (void)addGestureRecognizer:(UIGestureRecognizer *)tap;
- (void)addRightButton1:(UIButton *)rightButton;
@end
