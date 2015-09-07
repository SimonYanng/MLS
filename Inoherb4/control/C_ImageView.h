//
//  C_ImageView.h
//  SFA
//
//  Created by Ren Yong on 13-11-14.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface C_ImageView : UIImageView
//-(C_ImageView*) newInstance:(CGRect)frame image:(UIImage*)image;
//-(C_ImageView*) newInstance:(UIImage*)image;

- (id)initWithFrame:(CGRect)frame image:(UIImage*)image;
- (id)initWithFrame:(UIImage*)image;
@end
