//
//  D_SyncResult.h
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D_Result.h"
#import "D_Result.h"

@interface D_SyncResult : NSObject

@property(nonatomic,retain)NSMutableDictionary* field;
@property(nonatomic,retain)NSMutableArray* list;

//-(D_SyncResult*) newInstance;

-(id)init;

-(NSString*) getString:(NSString*)key;
-(void) put:(NSString*)object key:(NSString*)key;
-(int) getInt:(NSString*)key;


-(NSMutableDictionary*) getField:(int)index;
-(void) addField:(NSMutableDictionary*)value;
-(NSMutableArray*) getFieldList;

-(void) addResult:(D_Result*)result;
-(D_Result*) getResult:(int)index;

-(int) size;
@end
