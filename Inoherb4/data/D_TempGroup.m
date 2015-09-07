//
//  D_TempGroup.m
//  SFA
//
//  Created by Ren Yong on 13-11-14.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "D_TempGroup.h"
#import "NSMutableArray+Tool.h"

@implementation D_TempGroup
//static D_TempGroup* mInstance;
@synthesize tempList, groupId,type,name,showTitle;

-(id)init
{
    self=[super init];
    if(self)
    {
        self.tempList=[[NSMutableArray alloc]init];
    }
    return self;
}

//-(void)initTempList
//{
//    if(!self.tempList)
//        self.tempList=[[D_ArrayList alloc]init];
//}

-(void) addTemp:(D_Template*)temp
{
//    [self initTempList];
    [self.tempList addTemplate:temp];
}

-(D_Template*)templateAt:(int)index
{
    return [tempList templateAt:index];
}

-(int)tempCount
{
    return [tempList count];
}


-(void) addDict:(NSMutableDictionary*)dict
{
    [self.tempList addDict:dict];
}

-(NSMutableDictionary*)dictAt:(int)index
{
    return [tempList dictAt:index];
}

@end
