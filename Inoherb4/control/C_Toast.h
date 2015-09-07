//
//  C_Toast.h
//  SFA
//
//  Created by Ren Yong on 13-12-4.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_DISPLAY_DURATION 2.0f

@interface C_Toast : NSObject
{
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
}

+ (void)showWithText:(NSString *) text_;
+ (void)showWithText:(NSString *) text_
            duration:(CGFloat)duration_;

+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset_;
+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset
            duration:(CGFloat) duration_;

+ (void)showWithText:(NSString *) text_ bottomOffset:(CGFloat) bottomOffset_;
+ (void)showWithText:(NSString *) text_ bottomOffset:(CGFloat) bottomOffset_ duration:(CGFloat) duration_;

@end
