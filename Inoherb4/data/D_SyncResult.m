//
//  D_SyncResult.m
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "D_SyncResult.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"

@implementation D_SyncResult

@synthesize field,list;


-(id)init
{
    self=[super init];
    if (self) {
        self.field=[NSMutableDictionary dictionary];
        self.list=[[NSMutableArray alloc]init];
    }
    return self;
}

/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(void) addField:(NSMutableDictionary*)value
{
//    [self initList];
    [list addDict:value];
}

/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(NSMutableDictionary*) getField:(int)index
{
    return [list dictAt:index];
}

-(void) addResult:(D_Result*)result
{
    //    [self initList];
    [list addObject:result];
}

-(D_Result*) getResult:(int)index
{
    //    [self initList];
    return (D_Result*)[list objectAtIndex:index];
}


/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(NSMutableArray*) getFieldList
{
    return self.list;
}

/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(void) put:(NSString*) object key:(NSString*)key
{
//    [self initField];
    [field put:object key:key];
}


/**
 <#Description#>获取数据
 @param key <#key description#>
 */
-(NSString*) getString:(NSString*)key
{
    return [field getString:key];
}

/**
 <#Description#>获取数据
 @param key <#key description#>
 */
-(int) getInt:(NSString*)key
{
    return [field getInt:key];
}

/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(int) size
{
    return self.list==nil?0:[self.list count];
}
@end
