//
//  D_ArrayList.m
//  SFA
//
//  Created by Ren Yong on 13-10-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "D_ArrayList.h"

@implementation D_ArrayList
//D_ArrayList* mInstance;

@synthesize list;

//-(D_ArrayList*) newInstance
//{
//    mInstance =[[D_ArrayList alloc] init];
//    return mInstance;
//}

-(id)init
{
    self=[super init];
    if (self) {
        
    }
    return self;
}

-(void)initList
{
    if (!list) {
        self.list=[[NSMutableArray alloc] init];
    }
}

/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(void) addField:(D_Field*) object
{
    [self initList];
    [self.list addObject:object];
}

/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(void) add:(NSObject*) object
{
    [self initList];
    [self.list addObject:object];
}


/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(NSObject*) objectAt:(int) index
{
    if (self.list!=nil&&index<[self size])
        return [self.list objectAtIndex:index];
    return nil;
}

/**
 <#Description#>获取数据
 @param key <#key description#>
 */
-(D_Table*) tableAt:(int) index
{
    if (self.list!=nil&&index<[self size])
        return [self.list objectAtIndex:index];
    return nil;
}


/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(D_Field*) fieldAt:(int) index
{
    if (self.list!=nil&&index<[self size])
        return [self.list objectAtIndex:index];
    return nil;
}


/**
 <#Description#>获取数据
 @param key <#key description#>
 */
-(D_UIItem*) uiItemAt:(int) index
{
    if (self.list!=nil&&index<[self size])
        return [self.list objectAtIndex:index];
    return nil;
}

///**
// <#Description#>获取数据
// @param key <#key description#>
// */
//-(D_TempGroup*) tempGroupAt:(int) index
//{
//    if (self.list!=nil&&index<[self size])
//        return [self.list objectAtIndex:index];
//    return nil;
//}


-(int) size
{
    return self.list==nil?0:(int)self.list.count;
}
@end
