//
//  NSMutableDictionary+Tool.m
//  SFA1
//
//  Created by Ren Yong on 14-4-9.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "NSMutableDictionary+Tool.h"

@implementation NSMutableDictionary (Tool)

-(void) put:(NSObject*) object key:(NSString*)key
{
    [self setObject:object forKey:[key lowercaseString]];
}

-(void) putBool:(BOOL)value key:(NSString*)key
{
    [self put:[NSNumber numberWithBool:value] key:key];
}

-(void) putInt:(int)value key:(NSString*)key
{
    [self put:[NSNumber numberWithInt:value] key:key];
}

-(id)objectForLowKey:(NSString*)key
{
    return [self objectForKey:[key lowercaseString]];
}

-(NSString*) getString:(NSString*)key
{
    NSString* value=[self objectForLowKey:key];
    return value==nil?@"":value;
}


-(int) getInt:(NSString*)key
{
    NSNumber* value=[self objectForLowKey:key];
    return value==nil?0:[value intValue];
}

-(double) getDouble:(NSString*)key
{
    NSString* value=[self getString:key];
    return value==nil?0:[value doubleValue];
}

-(BOOL) getBool:(NSString*)key
{
    NSNumber* value=[self objectForLowKey:key];
    return value==nil?NO:[value boolValue];
}

-(void) putKey:(NSObject*) object key:(NSString*)key
{
    [self setObject:object forKey:key];
}

-(NSString*) getKeyString:(NSString*)key
{
    NSString* value=[self objectForKey:key];
    return value==nil?@"":value;
}

@end
