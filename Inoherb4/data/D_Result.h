//
//  D_Result.h
//  Shequ
//
//  Created by Ren Yong on 14-1-11.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface D_Result : NSObject
@property(nonatomic,retain)NSMutableDictionary* result;
@property(nonatomic,retain)NSMutableArray* fieldList;

-(id)init;
-(void)addField:(NSMutableDictionary *)field;
-(void)put:(NSString*)value key:(NSString*)key;

-(NSString*)valueForKey:(NSString*)key;

-(NSMutableDictionary*)fieldAt:(int)index;
-(int)size;
@end
