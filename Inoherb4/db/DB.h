//
//  DB.h
//  SFA
//
//  Created by Ren Yong on 13-10-29.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "D_Table.h"
#import "D_TableField.h"
#import "F_DBConfig.h"
#import "Constants.h"
#import "D_SyncResult.h"
#import "F_File.h"
#import "D_Template.h"
#import "D_TempGroup.h"
#import "D_Report.h"

@interface DB : NSObject
{
   sqlite3* mDB;
}

+ (DB*) instance;

- (void)createTable;

-(BOOL) upsertData:(D_SyncResult*)result;

- (D_Template *) surveyTemplate:(NSString *)templateId;
- (NSMutableArray*) tempGroup:(NSString *)tempGroupId;

- (NSMutableArray*) fieldList:(int)type;
- (NSMutableArray*) fieldListBy:(NSMutableString*)sql;
- (NSMutableArray*) fieldListBy1:(NSString*)sql;
- (NSMutableArray*) dictList:(NSString*)dictId;
- (NSMutableArray*) dictList:(NSString*)dictId clientId:(NSString* )clientId;
- (NSMutableArray*) fieldListByData:(NSMutableDictionary*)data type:(int)type;
- (int) upsertPlan:(NSMutableDictionary *)plan;
-(BOOL)execSql :(NSString*) sql;
-(BOOL)execSqlList :(NSMutableArray*) list;

-(int)creatRpt:(D_Report*)rpt;
-(D_Report*)curRpt:(D_Template*)temp field:(NSMutableDictionary*)field;
-(D_Report*)curDPRpt:(D_Template*)temp field:(NSMutableDictionary*)field;

-(D_Report*)curSurveyRpt:(D_Template*)temp field:(NSMutableDictionary*)field;

- (NSMutableArray*) categoryGroup:(NSString *)templateId;
- (NSMutableArray*) productList:(NSString *)categoryCode;

- (NSMutableArray*) allProductList:(NSString *)categoryCode;

- (NSString*) valueBy:(NSString*)sql key:(NSString*)key;
-(D_Report*)submitMsg;
-(D_Report*)submitRpt;

-(int)creatData:(D_Report*)rpt;

-(NSMutableArray*)docmentList;

- (int) upsertPlan:(NSArray *)planList callDate:(NSString*)callDate;

-(D_Report*)submitPlan;
- (NSMutableArray*) dictList:(NSString*)dictId link:(NSString* )link;
@end
