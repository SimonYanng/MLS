//
//  NSMutableDictionary+Tool.h
//  SFA1
//
//  Created by Ren Yong on 14-4-9.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Tool)

-(void) put:(NSObject*) object key:(NSString*)key;
-(void) putBool:(BOOL)value key:(NSString*)key;
-(void) putInt:(int)value key:(NSString*)key;
-(NSString*) getString:(NSString*)key;
-(int) getInt:(NSString*)key;
-(double) getDouble:(NSString*)key;
-(BOOL) getBool:(NSString*)key;
-(void) putKey:(NSObject*) object key:(NSString*)key;
-(NSString*) getKeyString:(NSString*)key;

@end