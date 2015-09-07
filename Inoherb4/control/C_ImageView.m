//
//  C_ImageView.m
//  SFA
//
//  Created by Ren Yong on 13-11-14.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_ImageView.h"
#import "F_Color.h"


@implementation C_ImageView

- (id)initWithFrame:(UIImage*)image
{
    self = [super initWithFrame:CGRectMake(0, 5, 16, 16)];
    if (self) {
        // Initialization code
        self.backgroundColor = col_ClearColor();
        self.clipsToBounds = YES;
        self.image = image;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame image:(UIImage*)image
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = col_ClearColor();
        self.clipsToBounds = YES;
        self.image = image;
        self.contentMode =  UIViewContentModeScaleAspectFit;
        self.contentScaleFactor=[[UIScreen mainScreen] scale];
    }
    return self;
}

@end
