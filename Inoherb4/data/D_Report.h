//
//  D_Report.h
//  SFA
//
//  Created by Ren Yong on 13-11-27.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D_ArrayList.h"
#import "D_Template.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"

#define TERMINAL @"teminalCode"
#define CHAINSTORE @"chainstoreid"
#define DISTRIBUTE @"distributeid"

#define CLIENTTYPE @"clienttype"

#define CALLDATE @"reportdate"
#define TEMPLATEID @"templateid"
#define USEREDID @"userid"
#define TEMPGROUPID @"templategroupid"


#define ISEVENT @"isevent"
#define EVENTTYPE @"eventtype"

#define EVENTNAME @"eventname"
#define PLANID @"planid"


@interface D_Report : NSObject


@property(nonatomic,assign)BOOL isSaved;

@property(nonatomic,retain)NSMutableDictionary* field;

@property(nonatomic,retain)NSMutableArray* detailList;
@property(nonatomic,retain)NSMutableArray* attList;
@property(nonatomic,retain)D_Template* temp;
@property(nonatomic,copy)NSString* type;
@property(nonatomic,copy)NSString* templateId;



- (id)init:(D_Template*)temp;


//-(void) setField:(NSMutableDictionary *)fields;
-(void) putValue:(NSString*)object key:(NSString*)key;

-(void) addDetailField:(NSMutableDictionary*)value;
-(void) addAttField:(NSMutableDictionary*)value;
-(void) resetDetailField:(NSMutableArray*)list;

-(NSString*) getString:(NSString*)key;
-(NSMutableArray*) detailList;
-(NSMutableArray*) attList;
-(NSMutableDictionary*) rptField;

-(void) putKey:(NSString*)object key:(NSString*)key;
-(void) resetAttField:(NSMutableDictionary*)value;
-(int) detailSize;
-(int) attSize;
-(NSMutableDictionary*) attFieldAt:(int)index;

-(NSMutableDictionary*) detailFieldAt:(int)index;

-(NSString*)checkData;

-(void) resetAttField;
-(void) setDetailField:(NSMutableDictionary*)value;
@end
