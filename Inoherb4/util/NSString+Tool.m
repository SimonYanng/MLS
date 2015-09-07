//
//  NSString+Tool.m
//  SFA1
//
//  Created by Ren Yong on 14-4-11.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "NSString+Tool.h"

@implementation NSString (Tool)
-(BOOL) isEmpty
{
    if(!self || [self isEqualToString:@""])
        return YES;
    return NO;
}

-(BOOL) isEqualToLowerString:(NSString *)aString
{
    if([self isEqualToString:[aString lowercaseString]])
        return YES;
    return NO;
}
@end
