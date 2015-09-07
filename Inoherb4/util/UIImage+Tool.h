//
//  UIImage+Tool.h
//  Inoherb
//
//  Created by Bruce on 15/5/4.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)
- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;
- (UIImage *)imageWithLogoText:(UIImage *)img text:(NSString *)text1;

// 图片水印
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect;
- (UIImage *)imageWithLogoImage:(UIImage *)img logo:(UIImage *)logo;//图片水印

//透明水印
- (UIImage *)imageWithTransImage:(UIImage *)useImage addtransparentImage:(UIImage *)transparentimg;
@end
