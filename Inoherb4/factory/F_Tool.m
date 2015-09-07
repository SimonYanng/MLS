//
//  F_Tool.m
//  SFA
//
//  Created by Ren Yong on 13-11-13.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "F_Tool.h"
#import "GTMBase64.h"
/**
 [""]	<#Description#>判断String是否为空
 [""]	@param path"] <#path"] description#>
 [""] */
BOOL isEmpty(NSString* value)
{
    if(!value || [value isEqualToString:@""])
        return YES;
    return NO;
}

NSString* encodeBase64Data(NSData *data)
{
    data = [GTMBase64 encodeData:data];
    //    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}



UIImage *scaleToSize(UIImage *img ,CGSize size)
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//CGSize getsize(NSString* str ,wid:(CGFloat)th font:(CGFloat)size)
//2
//{
//    3
//    CGSize constraint = CGSizeMake(th, 20000.0f);
//    4
//    CGSize size_ = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//    5
//    return size_;
//    6
//}

NSString* myUUID()
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    
    NSLog(@"%@",result);
    CFRelease(puuid);
    CFRelease(uuidString);
    

    return result ;
}
