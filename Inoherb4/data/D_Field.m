//
//  D_Field.m
//  SFA
//
//  Created by Ren Yong on 13-10-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "D_Field.h"

@implementation D_Field

@synthesize field;

-(id)init
{
    self=[super init];
    if(self)
    {
        self.field=[NSMutableDictionary dictionary];
    }
    return self;
}

/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(void) put:(NSObject*) object key:(NSString*)key
{
    [self.field setObject:object forKey:[key lowercaseString]];
}

/**
 <#Description#>存入数据不转换key的大小写
 @param key <#key description#>
 */
-(void) putKey:(NSObject*) object key:(NSString*)key
{
    [self.field setObject:object forKey:key];
}

/**
 <#Description#>存入Bool值
 @param key <#key description#>
 */
-(void) putBool:(BOOL)value key:(NSString*)key
{
//    NSNumber *boolNumber = [NSNumber numberWithBool:value];
    [self put:[NSNumber numberWithBool:value] key:key];
}

/**
 <#Description#>存入Bool值
 @param key <#key description#>
 */
-(void) putInt:(int)value key:(NSString*)key
{
//    NSNumber *intNumber = [NSNumber numberWithInt:value];
    [self put:[NSNumber numberWithInt:value] key:key];
}

-(id)objectForLowKey:(NSString*)key
{
    return [self.field objectForKey:[key lowercaseString]];
}

-(id)objectForKey:(NSString*)key
{
    return [self.field objectForKey:key];
}

-(NSString*) getString:(NSString*)key
{
    NSString* value=[self objectForLowKey:key];
    return value==nil?@"":value;
}

-(NSString*) getKeyString:(NSString*)key
{
    NSString* value=[self objectForKey:key];
    return value==nil?@"":value;
}

-(int) getInt:(NSString*)key
{
    NSNumber* value=[self objectForLowKey:key];
    return value==nil?0:[value intValue];
}

-(double) getDouble:(NSString*)key
{
    NSString* value=[self objectForLowKey:key];
//    NSLog(value);
    return value==nil?0:[value doubleValue];
}

//-(CLLocationDegrees) getDouble:(NSString*)key
//{
//    NSString* value=[self objectForLowKey:key];
//    return value==nil?0:[value doubleValue];
//}

-(bool) getBool:(NSString*)key
{
    NSNumber* value=[self objectForLowKey:key];
    return value==nil?NO:[value boolValue];
}

//-(int) size
//{
//      field.count
//    return [field.count intValue];
//}



//for(NSString *compKey in level.components) {    // 正确的字典遍历方式
//    BYComponent *comp = [level.components objectForKey:compKey];
//    [self createDynamicIce:comp];
//}

@end
