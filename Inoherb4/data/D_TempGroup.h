//
//  D_TempGroup.h
//  SFA
//
//  Created by Ren Yong on 13-11-14.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D_Template.h"
@interface D_TempGroup : NSObject
@property(nonatomic,retain)NSMutableArray* tempList;
@property(nonatomic,copy)NSString* type;
@property(nonatomic,copy)NSString* groupId;
@property(nonatomic,copy)NSString* name;

@property(nonatomic,assign)BOOL showTitle;

-(id)init;
-(void) addTemp:(D_Template*)temp;
-(D_Template*)templateAt:(int)index;

-(int)tempCount;


-(void) addDict:(NSMutableDictionary*)dict;
-(NSMutableDictionary*)dictAt:(int)index;

@end
