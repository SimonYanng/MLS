//
//  D_Field.h
//  SFA
//
//  Created by Ren Yong on 13-10-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface D_Field : NSObject

@property(nonatomic,retain)NSMutableDictionary* field;


//-(D_Field*) newInstance;

-(id)init;

-(void) put:(NSObject*)object key:(NSString*)key;
-(void) putKey:(NSObject*) object key:(NSString*)key;
-(void) putInt:(int)value key:(NSString*)key;

-(void) putBool:(BOOL)value key:(NSString*)key;


-(NSString*) getString:(NSString*)key;
-(NSString*) getKeyString:(NSString*)key;


-(int) getInt:(NSString*)key;
-(bool) getBool:(NSString*)key;
-(double) getDouble:(NSString*)key;
@end
