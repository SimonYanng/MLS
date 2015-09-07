//
//  D_Result.m
//  Shequ
//
//  Created by Ren Yong on 14-1-11.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "D_Result.h"
#import "NSMutableDictionary+Tool.h"

#import "NSMutableArray+Tool.h"

@implementation D_Result
@synthesize result,fieldList;

-(void)addField:(NSMutableDictionary *)field
{
    [self.fieldList addObject:field];
}

-(NSMutableDictionary*)fieldAt:(int)index
{
   return [self.fieldList dictAt:index];
}

-(void)put:(NSString*)value key:(NSString*)key
{
    [self.result put:value key:key];
}

-(NSString*)valueForKey:(NSString*)key
{
    return [self.result getString:key];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.result=[NSMutableDictionary dictionary];
        self.fieldList=[[NSMutableArray alloc] init];
    }
    return self;
}

-(int)size
{
    return self.fieldList==nil?0:[self.fieldList count];
}


@end
