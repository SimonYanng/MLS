//
//  DB.m
//  SFA
//
//  Created by Ren Yong on 13-10-29.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "DB.h"
#import "Constants.h"
#import "F_Date.h"
#import "F_Alert.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"

@implementation DB

static NSString* PRIMARY_KEY=@"key_id";

static DB* mInstance;

+ (DB*) instance
{
    @synchronized(self)
    {
        if (mInstance == nil)
        {
            mInstance = [[DB alloc] init];
        }
    }
    return mInstance;
}

- (id)init
{
    if (self = [super init])
    {
        creatPath(filePath());
    }
    return self;
}


/**
 [""]	<#Description#>打开数据库
 [""]	@returns <#return value description#>
 [""] */
- (void)openDB
{
    if (sqlite3_open([dbPath() UTF8String], &mDB) != SQLITE_OK)
    {
        [self closeDB];
        NSAssert(0, @"open database faild!");
    }
}

/**
 <#Description#>关闭数据库
 @returns <#return value description#>
 */
- (void)closeDB
{
    sqlite3_close(mDB);
}


/**
 [""]	<#Description#>开启事物
 [""]	@returns <#return value description#>
 [""] */
-(void)beginTransaction
{
    char *errMessage;
    sqlite3_exec(mDB, "BEGIN", nil, nil, &errMessage);
}

/**
 [""]	<#Description#>确认事物
 [""]	@returns <#return value description#>
 [""] */
-(void)commitTransaction
{
    char *errMessage;
    sqlite3_exec(mDB, "COMMIT", nil, nil, &errMessage);
}

/**
 [""]	<#Description#>创建表结构
 [""]	@returns <#return value description#>
 [""] */
- (void)createTable
{
    @synchronized(self)
    {
        NSMutableArray* tableList=table_List();
        NSMutableArray* sqlList=[[NSMutableArray alloc] init];
        //        D_Table* table;
        
        for (int i = 0; i < [tableList count]; i++)
        {
            [sqlList addObject:[self createTableSql:[tableList tableAt:i]]];
        }
        [self execSqlList:sqlList];
        
        tableList=nil;
        sqlList=nil;
        //        table=nil;
    }
}

/**
 [""]	<#Description#>replaceSql
 [""]	@param data <#data description#>
 [""]	@param table <#table description#>
 [""]	@returns <#return value description#>
 [""] */
-(NSString*) replaceSql:(NSMutableDictionary*)data table:(D_Table*)table
{
    NSMutableString *replaceSql = [NSMutableString stringWithFormat:@"REPLACE into %@ (", table.tableName];
    for (D_TableField* field in table.fieldList)
    {
        if (field.isDownLoad)
            [replaceSql appendFormat:@" %@ ,", [field.fieldName lowercaseString]];
    }
    replaceSql=[NSMutableString stringWithFormat:@" %@ ) VALUES (",[replaceSql substringToIndex:(replaceSql.length-1)]];
    for (D_TableField* field in table.fieldList)
    {
        if (field.isDownLoad)
            [replaceSql appendFormat:@"'%@',", [data getString:field.fieldName]];
        
    }
    replaceSql=[NSMutableString stringWithFormat:@"%@ );",[replaceSql substringToIndex:(replaceSql.length-1)]];
    //    NSLog(replaceSql);
    return replaceSql;
}

-(NSMutableArray*)docmentList
{
    NSMutableArray* docmentList = [[NSMutableArray alloc]init];
    NSString *sql= [NSString stringWithFormat:@"select key_id, case when issubmit=1 then '已下载' else '未下载' end as status,attachmentname,str1,attachmenturl,attachmenttype from T_Train_List where  isdel=0 order by str2"];
    if(sql)
    {
        NSLog(@"%@",sql);
        NSMutableDictionary * field;
        sqlite3_stmt *statement;
        NSString* categoryName;
        NSString* oldCategoryName;
        D_TempGroup* group;
        [self openDB];
        if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            //            sqlite3_column_count(<#sqlite3_stmt *pStmt#>)//获取语句返回的总的列数
            int row=0;
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                categoryName=[self valueAt:2 stmt:statement];
                NSLog(@"租:%@",categoryName);
                if(![categoryName isEqualToString:oldCategoryName])
                {
                    if(group)
                        [docmentList addTempGroup:group];
                    group=[[D_TempGroup alloc] init];
                    group.name=categoryName;
                }
                
                field=[NSMutableDictionary dictionary];
                
                row=sqlite3_data_count(statement);
                for(int i=0;i<row;i++)
                {
                    [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                }
                [group addDict:field];
                
                oldCategoryName=categoryName;
            }
            sqlite3_finalize(statement);
            
            if (group)
            {
                [docmentList addTempGroup:group];
            }
            
        }
    }
    return docmentList;
}


-(D_Report*)submitPlan
{
    @synchronized(self)
    {
        D_Report* rpt =[[D_Report alloc]init:nil];
        NSString *sql= [NSString stringWithFormat:@"SELECT key_id,clientid,visittime,isdel,ClientType FROM T_visit_plan_detail where issubmit=0"];
        if(sql)
        {
            NSLog(@"%@",sql);
            NSMutableDictionary* field;
            sqlite3_stmt *statement;
            [self openDB];
            
            if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                //            sqlite3_column_count(<#sqlite3_stmt *pStmt#>)//获取语句返回的总的列数
                int row=0;
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    row=sqlite3_data_count(statement);
                    field=[NSMutableDictionary dictionary];
                    [rpt putValue:@"-100" key:@"TemplateId"];
                    [field putKey:[self valueAt:1 stmt:statement] key:@"ClientId"];
                    [field putKey:[self valueAt:2 stmt:statement] key:@"ReportDate"];
                    [field putKey:[self valueAt:3 stmt:statement] key:@"INT10"];
                    [field putKey:[self valueAt:4 stmt:statement] key:@"ClientType"];
                    //                    [rpt putKey: key:@"userid"];
                    [field putKey:[self valueAt:0 stmt:statement] key:@"key_id"];
                    
                    [rpt putValue:@"Y" key:@"isSaved"];
                    [rpt addDetailField:field];
                }
                sqlite3_finalize(statement);
            }
            else
            {
                NSLog(@"%d", sqlite3_step(statement));
                NSLog(@"Error: %s", sqlite3_errmsg(mDB));
                NSLog(@"get data list failed!!!");
            }
            [self closeDB];
        }
        
        return rpt;
    }
}

- (int) upsertPlan:(NSArray *)planList callDate:(NSString*)callDate
{
    @synchronized(self)
    {
        NSMutableArray* sqlList=[[NSMutableArray alloc] init];
        NSString *sql;
        [self execSql:[NSString stringWithFormat:@"DELETE FROM T_Visit_Plan_Detail where VisitTime='%@'",callDate]];
        for (NSMutableDictionary* client in planList)
        {
            sql = [NSString stringWithFormat:@"INSERT INTO T_Visit_Plan_Detail( clientid ,serverid ,VisitTime,issubmit,ClientType)VALUES ('%@' ,'-%@','%@','0' ,'%@')",[client getString:@"serverid"],[NSString stringWithFormat:@"%@%@",callDate,[client getString:@"serverid"] ],callDate,[client getString:@"outlettype"]];
            
            [sqlList addObject:sql];
            //            NSLog(@"%@",sql);
        }
        [self execSqlList:sqlList];
        return (int)sqlite3_last_insert_rowid(mDB);
    }
}

- (int) upsertPlan:(NSMutableDictionary *)plan
{
    @synchronized(self)
    {
        NSString *sql;
        if([[plan getString:@"isEvent"]isEqualToString:@"N"])
            sql = [NSString stringWithFormat:@"INSERT INTO t_data_plan(clientid,clienttype,eventType,calldate,planname,isEvent,isAdHoc,%@,issubmit,updatetime,inserttime) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",MOBILE_KEY,[plan getString:@"serverid"],[plan getString:@"clienttype"],@"0",today(),[plan getString:@"terminalName"],[plan getString:@"isEvent"],@"2",[plan getString:MOBILE_KEY],@"-2",now(),now()];
        else
            sql = [NSString stringWithFormat:@"INSERT INTO t_data_plan(clientid,clienttype,eventType,calldate,planname,isEvent,isAdHoc,%@,issubmit,updatetime,inserttime) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",MOBILE_KEY,@"0",@"0",[plan getString:@"eventType"],today(),[plan getString:@"terminalName"],[plan getString:@"isEvent"],@"2",[plan getString:MOBILE_KEY],@"-2",now(),now()];
        NSLog(@"%@",sql);
        [self execSql:sql];
        return (int)sqlite3_last_insert_rowid(mDB);
    }
}

- (NSString*) category:(NSString *)templateId
{
    @synchronized(self)
    {
        NSString * sql = [NSString stringWithFormat:@"select productcategory from t_data_template_productitem where templateid='%@'",templateId];
        NSLog(@"%@",sql);
        return [self valueBy:sql key:@"productcategory"];
        //        return (int)sqlite3_last_insert_rowid(mDB);
    }
}

- (NSMutableArray*) categoryGroup:(NSString *)templateId
{
    @synchronized(self)
    {
        NSString* category=[self category:templateId];
        
        NSMutableString * sql = [NSMutableString stringWithFormat:@"select c.categorycode,c.categoryname from (select category from  t_data_product where category in (select categorycode from  t_data_productcategory where  syscode like '%@%%' ) group by  category) p left join t_data_productcategory  c on p.category =c.categorycode",category];
        NSLog(@"%@",sql);
        
        if(sql)
        {
            NSMutableArray* categoryList=[self fieldListBy:sql];
            return categoryList;
        }
        else
            return nil;
    }
}

- (NSMutableArray*) allProductList:(NSString *)templateId
{
    @synchronized(self)
    {
        
        NSString* category=[self category:templateId];
        
        NSMutableString * sql = [NSMutableString stringWithFormat:@"select * from  t_data_product where category in (select categorycode from  t_data_productcategory where  syscode like '%@%%' ) ",category];
        NSLog(@"%@",sql);
        
        if(sql)
        {
            NSMutableArray* productList=[self fieldListBy:sql];
            return productList;
        }
        else
            return nil;
    }
}

- (NSMutableArray*) productList:(NSString *)categoryCode
{
    @synchronized(self)
    {
        NSMutableString * sql = [NSMutableString stringWithFormat:@"select * from t_product"];
        NSLog(@"%@",sql);
        
        if(sql)
        {
            NSMutableArray* productList=[self fieldListBy:sql];
            return productList;
        }
        else
            return nil;
    }
}

-(D_Report*)submitRpt
{
    @synchronized(self)
    {
        D_Report* rpt =[[D_Report alloc]init:nil];
        NSString *sql= [NSString stringWithFormat:@"SELECT * FROM t_data_callreport where issubmit=0 and reportdate='%@' limit 1",today()];
        if(sql)
        {
            NSLog(@"%@",sql);
            NSMutableDictionary* field;
            sqlite3_stmt *statement;
            [self openDB];
            if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                int row=0;
                int rowCount=0;
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    row=sqlite3_data_count(statement);
                    for(int i=0;i<row;i++)
                    {
                        NSLog(@"key-----%@,value--------%@",[self columNameAt:i stmt:statement],[self valueAt:i stmt:statement] );
                        
                        [rpt putValue:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                    }
                    rowCount++;
                }
                sqlite3_finalize(statement);
                
                if(rowCount>0)
                {
                    [rpt putValue:@"Y" key:@"isSaved"];
                    
                    sql= [NSString stringWithFormat:@"SELECT * FROM t_data_callreportphoto where callReportId='%@'",[rpt getString:PRIMARY_KEY]];
                    if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
                    {
                        row=0;
                        while (sqlite3_step(statement) == SQLITE_ROW)
                        {
                            field=[NSMutableDictionary dictionary];
                            row=sqlite3_data_count(statement);
                            for(int i=0;i<row;i++)
                            {
                                [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                            }
                            [rpt addAttField:field];
                        }
                        sqlite3_finalize(statement);
                    }
                    sql= [NSString stringWithFormat:@"SELECT * FROM t_data_callreportdetail where callReportId='%@'",[rpt getString:PRIMARY_KEY]];
                    if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
                    {
                        row=0;
                        while (sqlite3_step(statement) == SQLITE_ROW)
                        {
                            field=[NSMutableDictionary dictionary];
                            row=sqlite3_data_count(statement);
                            for(int i=0;i<row;i++)
                            {
                                [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                            }
                            [rpt addDetailField:field];
                        }
                        sqlite3_finalize(statement);
                    }
                }
            }
            else
            {
                NSLog(@"%d", sqlite3_step(statement));
                NSLog(@"Error: %s", sqlite3_errmsg(mDB));
                NSLog(@"get data list failed!!!");
            }
            [self closeDB];
        }
        
        NSLog(@"clienttype------------%@",[rpt getString:@"clienttype"]);
        return rpt;
    }
}

-(D_Report*)submitMsg
{
    @synchronized(self)
    {
        D_Report* rpt =[[D_Report alloc]init:nil];
        NSString *sql= [NSString stringWithFormat:@"select serverid from t_message_detail  where issubmit=0 limit 1"];
        if(sql)
        {
            NSLog(@"%@",sql);
            NSMutableDictionary* field;
            sqlite3_stmt *statement;
            [self openDB];
            
            if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                int row=0;
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    field=[NSMutableDictionary dictionary];
                    row=sqlite3_data_count(statement);
                    for(int i=0;i<row;i++)
                    {
                        [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                    }
                    [rpt addDetailField:field];
                    [rpt putValue:@"Y" key:@"isSaved"];
                }
                sqlite3_finalize(statement);
            }
            else
            {
                NSLog(@"%d", sqlite3_step(statement));
                NSLog(@"Error: %s", sqlite3_errmsg(mDB));
                NSLog(@"get data list failed!!!");
            }
            [self closeDB];
        }
        
        return rpt;
    }
}

-(D_Report*)curRpt:(D_Template*)temp field:(NSMutableDictionary*)field
{
    @synchronized(self)
    {
        D_Report* rpt = [[D_Report alloc]init:temp];
        NSString *sql;
        if(temp.onlyType==9)
            sql= [NSString stringWithFormat:@"SELECT * FROM t_data_callreport where key_id=%@ order by key_id desc ",[field getString:@"key_id"]];
        else
            sql= [NSString stringWithFormat:@"SELECT * FROM t_data_callreport where onlytype='%d' and reportdate='%@' and clientId='%@' order by key_id desc ",temp.onlyType,today(),[field getString:@"serverid"]];
        
        if(sql)
        {
            NSLog(@"%@",sql);
            NSMutableDictionary* field;
            sqlite3_stmt *statement;
            [self openDB];
            if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                //            sqlite3_column_count(<#sqlite3_stmt *pStmt#>)//获取语句返回的总的列数
                int row=0;
                int rowCount=0;
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    row=sqlite3_data_count(statement);
                    for(int i=0;i<row;i++)
                    {
                        [rpt putValue:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                    }
                    rowCount++;
                }
                sqlite3_finalize(statement);
                
                if(rowCount>0)
                {
                    rpt.isSaved=YES;
                    sql= [NSString stringWithFormat:@"SELECT * FROM t_data_callreportphoto where callReportId='%@'",[rpt getString:PRIMARY_KEY]];
                    if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
                    {
                        row=0;
                        while (sqlite3_step(statement) == SQLITE_ROW)
                        {
                            field=[NSMutableDictionary dictionary];
                            row=sqlite3_data_count(statement);
                            for(int i=0;i<row;i++)
                            {
                                [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                            }
                            [rpt addAttField:field];
                        }
                        sqlite3_finalize(statement);
                    }
                }
                if ([temp productPanelCount]>0) {
                    NSString* rptId=@"";
                    if(rowCount>0)
                        rptId=[rpt getString:PRIMARY_KEY];
                    if([temp.type isEqualToString:@"2"]||[temp.type isEqualToString:@"5"]||[temp.type isEqualToString:@"6"])
                        sql= [NSString stringWithFormat: @"SELECT  d.productid as productid , d.callreportid as callreportid , d.remark as remark , d.int1 as int1 , d.int2 as int2 , d.int3 as int3 , d.int4 as int4 , d.int5 as int5 , d.int6 as int6 , d.int7 as int7 , d.int8 as int8 , d.int9 as int9 , d.int10 as int10 , d.str1 as str1 , d.str2 as str2 , d.str3 as str3 , d.str4 as str4 , d.str5 as str5 , d.str6 as str6 , d.str7 as str7 , d.str8 as str8 , d.str9 as str9 , d.str10 as str10 , d.decimal1 as decimal1 , d.decimal2 as decimal2 , d.decimal3 as decimal3 , d.decimal4 as decimal4 , d.decimal5 as decimal5 , d.decimal6 as decimal6 , d.decimal7 as decimal7 , d.decimal8 as decimal8 , d.decimal9 as decimal9 , d.decimal10 as decimal10 , p.serverid as serverid , p.productname as productname , p.shortname as shortname , p.aftertaxprice as aftertaxprice  FROM (select * from  T_Product  where iscompete=0 ) p left join (select * from t_data_callreportdetail where callReportId='%@') d  on p.serverid=d.productid order by p.productname ",rptId];
                    else  if([temp.type isEqualToString:@"3"])
                        sql= [NSString stringWithFormat: @"SELECT  d.productid as productid , d.callreportid as callreportid , d.remark as remark , d.int1 as int1 , d.int2 as int2 , d.int3 as int3 , d.int4 as int4 , d.int5 as int5 , d.int6 as int6 , d.int7 as int7 , d.int8 as int8 , d.int9 as int9 , d.int10 as int10 , d.str1 as str1 , d.str2 as str2 , d.str3 as str3 , d.str4 as str4 , d.str5 as str5 , d.str6 as str6 , d.str7 as str7 , d.str8 as str8 , d.str9 as str9 , d.str10 as str10 , d.decimal1 as decimal1 , d.decimal2 as decimal2 , d.decimal3 as decimal3 , d.decimal4 as decimal4 , d.decimal5 as decimal5 , d.decimal6 as decimal6 , d.decimal7 as decimal7 , d.decimal8 as decimal8 , d.decimal9 as decimal9 , d.decimal10 as decimal10 , p.standardprice as str1, p.serverid as serverid , p.productname as productname , p.shortname as shortname , p.aftertaxprice as aftertaxprice  FROM (select * from  T_Product  where iscompete=0 and isnew=1) p left join (select * from t_data_callreportdetail where callReportId='%@') d  on p.serverid=d.productid order by p.productname ",rptId];
//                    else  if([temp.type isEqualToString:@"4"])
//                        sql= [NSString stringWithFormat: @"SELECT '0' as have , d.productid as productid , d.callreportid as callreportid , d.remark as remark , d.int1 as int1 , d.int2 as int2 , d.int3 as int3 , d.int4 as int4 , d.int5 as int5 , d.int6 as int6 , d.int7 as int7 , d.int8 as int8 , d.int9 as int9 , d.int10 as int10 , d.str1 as str1 , d.str2 as str2 , d.str3 as str3 , d.str4 as str4 , d.str5 as str5 , d.str6 as str6 , d.str7 as str7 , d.str8 as str8 , d.str9 as str9 , d.str10 as str10 , d.decimal1 as decimal1 , d.decimal2 as decimal2 , d.decimal3 as decimal3 , d.decimal4 as decimal4 , d.decimal5 as decimal5 , d.decimal6 as decimal6 , d.decimal7 as decimal7 , d.decimal8 as decimal8 , d.decimal9 as decimal9 , d.decimal10 as decimal10 , p.dictclass as serverid , p.dictname as productname , p.remark as remark FROM (select * from  t_sys_dictionary where dicttype='301' ) p  left join (select * from t_data_callreportdetail where callReportId='%@') d on p.dictclass=d.productid  order by have desc, p.dictclass  ",rptId];
//                    else  if([temp.type isEqualToString:@"7"])
//                        sql= [NSString stringWithFormat: @"SELECT  d.productid as productid , d.callreportid as callreportid , d.remark as remark , d.int1 as int1 , d.int2 as int2 , d.int3 as int3 , d.int4 as int4 , d.int5 as int5 , d.int6 as int6 , d.int7 as int7 , d.int8 as int8 , d.int9 as int9 , d.int10 as int10 , d.str1 as str1 , d.str2 as str2 , d.str3 as str3 , d.str4 as str4 , d.str5 as str5 , d.str6 as str6 , d.str7 as str7 , d.str8 as str8 , d.str9 as str9 , d.str10 as str10 , d.decimal1 as decimal1 , d.decimal2 as decimal2 , d.decimal3 as decimal3 , d.decimal4 as decimal4 , d.decimal5 as decimal5 , d.decimal6 as decimal6 , d.decimal7 as decimal7 , d.decimal8 as decimal8 , d.decimal9 as decimal9 , d.decimal10 as decimal10 , p.standardprice as str1, p.serverid as serverid , p.productname as productname , p.shortname as shortname , p.aftertaxprice as aftertaxprice  FROM (select * from  T_Product  where iscompete=0 and isNew=1) p left join (select * from t_data_callreportdetail where callReportId='%@') d  on p.serverid=d.productid order by p.productname ",rptId];
//                    else  if([temp.type isEqualToString:@"8"])
//                        sql= [NSString stringWithFormat: @"SELECT  d.productid as productid , d.callreportid as callreportid , d.remark as remark , d.int1 as int1 , d.int2 as int2 , d.int3 as int3 , d.int4 as int4 , d.int5 as int5 , d.int6 as int6 , d.int7 as int7 , d.int8 as int8 , d.int9 as int9 , d.int10 as int10 , d.str1 as str1 , d.str2 as str2 , d.str3 as str3 , d.str4 as str4 , d.str5 as str5 , d.str6 as str6 , d.str7 as str7 , d.str8 as str8 , d.str9 as str9 , d.str10 as str10 , d.decimal1 as decimal1 , d.decimal2 as decimal2 , d.decimal3 as decimal3 , d.decimal4 as decimal4 , d.decimal5 as decimal5 , d.decimal6 as decimal6 , d.decimal7 as decimal7 , d.decimal8 as decimal8 , d.decimal9 as decimal9 , d.decimal10 as decimal10 ,  p.serverid as serverid , p.productname as productname , p.shortname as shortname , p.aftertaxprice as aftertaxprice  FROM (select * from  T_Product  where iscompete=1 ) p left join (select * from t_data_callreportdetail where callReportId='%@') d  on p.serverid=d.productid order by p.productname ",rptId];
//                    else
//                        sql= [NSString stringWithFormat: @"SELECT  p.dictclass as serverid , p.dictname as FullName ,p.remark as remark ,p.dictvalue as dictvalue  FROM (select * from  T_Sys_Dictionary where dicttype='120' ) p  left join (select * from t_data_callreportdetail where callReportId='%@' ) d on p.dictclass=d.productid  order by p.dictclass",rptId];
                    
                    NSLog(@"%@",sql);
                    if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
                    {
                        row=0;
                        while (sqlite3_step(statement) == SQLITE_ROW)
                        {
                            field=[NSMutableDictionary dictionary];
                            row=sqlite3_data_count(statement);
                            NSLog(@"数据条数------%d",row);
                            for(int i=0;i<row;i++)
                            {
                                
//                                NSLog(@"key------%@ value---------%@",[self columNameAt:i stmt:statement],[self valueAt:i stmt:statement]);
                                
                                [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                            }
                            [rpt addDetailField:field];
                        }
                        sqlite3_finalize(statement);
                    }
                }
                
            }
            else
            {
                NSLog(@"%d", sqlite3_step(statement));
                NSLog(@"Error: %s", sqlite3_errmsg(mDB));
                NSLog(@"get data list failed!!!");
            }
            [self closeDB];
        }
//        [NSString stringWithFormat:<#(NSString *), ...#> [rpt attSize] ];
//        [rpt putValue:[NSString stringWithFormat:@"%d" ,[rpt attSize] ] key:@"photoCount"];
        [rpt putValue:today() key:CALLDATE];
        [rpt putValue:temp.type key:TEMPLATEID];
        [rpt putValue:[NSString stringWithFormat:@"%d", temp.onlyType ] key:@"onlytype"];
       
        [rpt putValue:[field getString:@"outlettype"] key:@"ClientType"];
        
        if([temp.type isEqualToString:@"7"])
            [rpt putValue:[NSString stringWithFormat:@"%d",temp.onlyType-7*1000000] key:@"int1"];
        
        if(!rpt.isSaved)
        {
             [rpt putValue:[field getString:@"serverid"] key:@"clientid"];
            [rpt putValue:[field getString:@"key"] key:@"decimal10"];
        }
        
        return rpt;
    }
}

-(D_Report*)curDPRpt:(D_Template*)temp field:(NSMutableDictionary*)field
{
    @synchronized(self)
    {
        D_Report* rpt = [[D_Report alloc]init:temp];
        NSString *sql= [NSString stringWithFormat:@"SELECT * FROM T_Client_Rlt_ActivityPromoter where PromoterId='%@'",[field getString:@"promoterid"]];
        if(sql)
        {
            NSLog(@"%@",sql);
            NSMutableDictionary* field;
            sqlite3_stmt *statement;
            [self openDB];
            if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                //            sqlite3_column_count(<#sqlite3_stmt *pStmt#>)//获取语句返回的总的列数
                int row=0;
                int rowCount=0;
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    row=sqlite3_data_count(statement);
                    
                    for(int i=0;i<row;i++)
                    {
                        if ([[[self columNameAt:i stmt:statement] lowercaseString] isEqualToString:[@"ClientId" lowercaseString]]) {
                            [rpt putValue:[self valueAt:i stmt:statement] key:@"int1"];
                        }
                        else if ([[[self columNameAt:i stmt:statement] lowercaseString] isEqualToString:[@"PromoterId" lowercaseString]]) {
                            [rpt putValue:[self valueAt:i stmt:statement] key:@"str10"];
                        }
                        else if ([[[self columNameAt:i stmt:statement] lowercaseString] isEqualToString:[@"Mobile" lowercaseString]]) {
                            [rpt putValue:[self valueAt:i stmt:statement] key:@"str2"];
                        }
                        else if ([[[self columNameAt:i stmt:statement] lowercaseString] isEqualToString:[@"PromoterName" lowercaseString]]) {
                            [rpt putValue:[self valueAt:i stmt:statement] key:@"str1"];
                        }
                        else if ([[[self columNameAt:i stmt:statement] lowercaseString] isEqualToString:[@"WorkDay" lowercaseString]]) {
                            [rpt putValue:[self valueAt:i stmt:statement] key:@"int2"];
                        }
                        //                        else
                        //                            [rpt putValue:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                    }
                    rowCount++;
                }
                sqlite3_finalize(statement);
                
                if(rowCount>0)
                {
                    rpt.isSaved=YES;
                    sql= [NSString stringWithFormat:@"SELECT * FROM t_data_DPPhoto where callReportId='%@'",[rpt getString:PRIMARY_KEY]];
                    if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
                    {
                        row=0;
                        while (sqlite3_step(statement) == SQLITE_ROW)
                        {
                            field=[NSMutableDictionary dictionary];
                            row=sqlite3_data_count(statement);
                            for(int i=0;i<row;i++)
                            {
                                [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                            }
                            [rpt addAttField:field];
                        }
                        sqlite3_finalize(statement);
                    }
                }
                
            }
            else
            {
                NSLog(@"%d", sqlite3_step(statement));
                NSLog(@"Error: %s", sqlite3_errmsg(mDB));
                NSLog(@"get data list failed!!!");
            }
            [self closeDB];
        }
        
        [rpt putValue:today() key:CALLDATE];
        [rpt putValue:temp.type key:TEMPLATEID];
        [rpt putValue:[NSString stringWithFormat:@"%d", temp.onlyType ] key:@"onlytype"];
        [rpt putValue:@"-1" key:@"clientid"];
        
        return rpt;
    }
}


-(D_Report*)curSurveyRpt:(D_Template*)temp field:(NSMutableDictionary*)field
{
    @synchronized(self)
    {
        D_Report* rpt = [[D_Report alloc]init:temp];
        NSString *sql= [NSString stringWithFormat:@"select * from t_data_callreport where templateid=-100 and clientid='-1' and reportdate ='%@' and str1='%@'",today(),temp.version];
        if(sql)
        {
            NSLog(@"%@",sql);
            NSMutableDictionary* field;
            sqlite3_stmt *statement;
            [self openDB];
            if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                //            sqlite3_column_count(<#sqlite3_stmt *pStmt#>)//获取语句返回的总的列数
                int row=0;
                int rowCount=0;
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    row=sqlite3_data_count(statement);
                    for(int i=0;i<row;i++)
                    {
                        [rpt putValue:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                    }
                    rowCount++;
                }
                sqlite3_finalize(statement);
                
                if(rowCount>0)
                {
                    rpt.isSaved=YES;
                    sql= [NSString stringWithFormat:@"SELECT * FROM t_data_callreportphoto where callReportId='%@'",[rpt getString:PRIMARY_KEY]];
                    if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
                    {
                        row=0;
                        while (sqlite3_step(statement) == SQLITE_ROW)
                        {
                            field=[NSMutableDictionary dictionary];
                            row=sqlite3_data_count(statement);
                            for(int i=0;i<row;i++)
                            {
                                [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                            }
                            [rpt addAttField:field];
                        }
                        sqlite3_finalize(statement);
                    }
                    
                    NSString* rptId=[rpt getString:PRIMARY_KEY];
                    sql= [NSString stringWithFormat: @"select * from t_data_callReportDetail where callReportId='%@' ",rptId];
                    //                    sql= [NSString stringWithFormat:@"SELECT * FROM T_Product "];
                    
                    NSLog(@"%@",sql);
                    if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
                    {
                        row=0;
                        while (sqlite3_step(statement) == SQLITE_ROW)
                        {
                            field=[NSMutableDictionary dictionary];
                            row=sqlite3_data_count(statement);
                            NSLog(@"数据条数------%d",row);
                            for(int i=0;i<row;i++)
                            {
                                
                                NSLog(@"key------%@ value---------%@",[self columNameAt:i stmt:statement],[self valueAt:i stmt:statement]);
                                
                                [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                            }
                            [rpt addDetailField:field];
                        }
                        sqlite3_finalize(statement);
                    }
                    
                }
                else
                {
                    
                    for (D_Panel* panal in [temp panelList])
                    {
                        field=[NSMutableDictionary dictionary];
                        [field put:temp.version key:@"str1"];
                        [field put:panal.panelId key:@"str2"];
                        [field put:@"-1" key:@"str4"];
                        
                        [rpt addDetailField:field];
                    }
                    
                    [rpt putValue:today() key:CALLDATE];
                    [rpt putValue:temp.type key:TEMPLATEID];
                    [rpt putValue:[NSString stringWithFormat:@"%d", temp.onlyType ] key:@"onlytype"];
                    [rpt putValue:@"-1" key:@"clientid"];
                    [rpt putValue:@"0" key:@"ClientType"];
                    [rpt putValue:temp.version key:@"str1"];
                }
                
                
            }
            else
            {
                NSLog(@"%d", sqlite3_step(statement));
                NSLog(@"Error: %s", sqlite3_errmsg(mDB));
                NSLog(@"get data list failed!!!");
            }
            [self closeDB];
        }
        
        
        
        
        return rpt;
    }
}

//-(NSString*)detailSql:(NSString*)rptId category:(NSString)category
//{
//    D_Table* product=get_table(@"t_data_product");
//    D_Table* detail=get_table(@"t_data_callReportDetail");
//
//		if (product == nil || detail == nil)
//			return @"";
//		String reportDetialSql = "SELECT ";
//		for (DBDetailConfig detail : dc.getFieldList())
//		{
//			if (detail.isQuery())
//				reportDetialSql += " p." + Tool.toLowerCase(detail.getFieldName()) + " as  " + Tool.toLowerCase(detail.getFieldName()) + " ,";
//		}
//		for (DBDetailConfig detail : dc1.getFieldList())
//		{
//			if (detail.isQuery())
//				reportDetialSql += " d." + Tool.toLowerCase(detail.getFieldName()) + " as " + Tool.toLowerCase(detail.getFieldName()) + " ,";
//		}
//		reportDetialSql = Tool.getSubString(reportDetialSql) + "FROM (select * from  t_data_product where category in (select categorycode from  t_data_productcategory where  syscode like '"+category+"%' )) p  left join (select * from t_data_callreportdetail where callReportId='" + reportId + "') d on p.serverid=d.productid order by p.productname ";
//		return reportDetialSql;
//
//}


-(int)creatData:(D_Report*)rpt
{
    @synchronized(self)
    {
        
        int rowId=-1;
        [self openDB];
        [self beginTransaction];
        D_Table* table;
        if([rpt.type isEqualToString:@"20000"])
        {
            table=table_DPList();
        }
        
        //        NSMutableString* sql = [NSMutableString stringWithFormat:@"INSERT INTO %@ (",table.tableName];
        //
        //        for (D_TableField* field in table.fieldList)
        //        {
        //            [sql appendFormat:@" %@ ,", [field.fieldName lowercaseString]];
        //        }
        //        [sql appendFormat:@" issubmit ,updateTime,insertTime"];
        //        sql=[NSMutableString stringWithFormat:@" %@ ) VALUES (",sql];
        //        for (D_TableField* field in table.fieldList)
        //        {
        //            [sql appendFormat:@"'%@',", [rpt getString:field.fieldName]];
        //        }
        //        [sql appendFormat:@"'0','%@','%@');", now(),now()];
        //        //        sql=[NSMutableString stringWithFormat:@"%@ );",[sql substringToIndex:(sql.length-1)]];
        //
        
        NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO '%@' ('ClientId', 'PromoterId', 'Mobile','PromoterName','WorkDay','serverid','issubmit','str1') VALUES (?, ?, ?,?,?,?,?,?)",table.tableName];
        
        sqlite3_stmt *statement;
        
        
        if (sqlite3_prepare_v2(mDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [ [rpt getString:@"int1"] UTF8String], -1,NULL);
            sqlite3_bind_text(statement, 2, [ [rpt getString:@"serverid"] UTF8String], -1,NULL);
            sqlite3_bind_text(statement, 3, [ [rpt getString:@"str2"] UTF8String], -1,NULL);
            sqlite3_bind_text(statement, 4, [ [rpt getString:@"str1"] UTF8String], -1,NULL);
            sqlite3_bind_text(statement, 5, [ [rpt getString:@"int2"] UTF8String], -1,NULL);
            sqlite3_bind_text(statement, 6, [ [rpt getString:@"serverid"] UTF8String], -1,NULL);
            sqlite3_bind_text(statement, 7, [ [rpt getString:@"1"] UTF8String], -1,NULL);
            sqlite3_bind_text(statement, 8, [@"N" UTF8String], -1,NULL);
            rowId=(int)sqlite3_last_insert_rowid(mDB);
            [self creatDPPhoto:[rpt attList] rowId:rowId];
        }
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSAssert(0, @"插入数据失败！");
            
            sqlite3_finalize(statement);
        }
        
        
        //        NSLog(@"%@",sql);
        //        char *errorMsg;
        //        if (sqlite3_exec(mDB, [sql UTF8String], nil, nil, &errorMsg) == SQLITE_OK)
        //        {
        //            rowId=(int)sqlite3_last_insert_rowid(mDB);
        //            NSLog(@"报告id%d",rowId);
        //
        //            [self creatDPPhoto:[rpt attList] rowId:rowId];
        //        }
        
        [self commitTransaction];
        [self closeDB];
        return rowId;
    }
}

-(void)creatDPPhoto:(NSMutableArray*)list rowId:(int)rowId
{
    @synchronized(self)
    {
        NSMutableString* sql;
        char *errorMsg;
        if(list)
        {
            for(NSMutableDictionary* data in list)
            {
                sql = [NSMutableString stringWithFormat:@"INSERT INTO t_data_DPPhoto("];
                D_Table* table=table_CallPhoto();
                for (D_TableField* field in table.fieldList)
                {
                    [sql appendFormat:@" %@ ,", [field.fieldName lowercaseString]];
                }
                sql=[NSMutableString stringWithFormat:@" %@ ) VALUES (",[sql substringToIndex:(sql.length-1)]];
                for (D_TableField* field in table.fieldList)
                {
                    if ([field.fieldName isEqualToString:@"callReportId"])
                        [sql appendFormat:@"'%d',", rowId];
                    else if ([field.fieldName isEqualToString:@"updateTime"])
                        [sql appendFormat:@"'%@',", now()];
                    else if ([field.fieldName isEqualToString:@"insertTime"])
                        [sql appendFormat:@"'%@',", now()];
                    else
                        [sql appendFormat:@"'%@',", [data getString:field.fieldName]];
                }
                sql=[NSMutableString stringWithFormat:@"%@ );",[sql substringToIndex:(sql.length-1)]];
                
                NSLog(@"%@",sql);
                if (sqlite3_exec(mDB, [sql UTF8String], nil, nil, &errorMsg) != SQLITE_OK)
                {
                    //                alert_showErrMsg([NSString stringWithFormat:@"错误:%@",errorMsg ]);
                }
//                NSLog([NSString stringWithFormat:@"错误:%@",errorMsg]);
            }
        }
    }
}

-(int)creatRpt:(D_Report*)rpt
{
    @synchronized(self)
    {
        
        NSMutableArray* sqlList=[[NSMutableArray alloc]init];
        [sqlList addString:[NSString stringWithFormat:@"delete from t_data_callReportPhoto  where callReportId='%@'",[rpt getString:@"key_id"]]];
        [sqlList addString:[NSString stringWithFormat:@"delete from t_data_callReportDetail  where callReportId='%@'",[rpt getString:@"key_id"]]];
        [sqlList addString:[NSString stringWithFormat:@"delete from t_data_callReport  where key_id='%@'",[rpt getString:@"key_id"]]];
        [self execSqlList:sqlList];
        
        int rowId=-1;
        [self openDB];
        [self beginTransaction];
        
        NSMutableString* sql = [NSMutableString stringWithFormat:@"INSERT INTO t_data_callReport("];
        D_Table* table=table_CallReport();
        for (D_TableField* field in table.fieldList)
        {
            [sql appendFormat:@" %@ ,", [field.fieldName lowercaseString]];
        }
        [sql appendFormat:@" issubmit ,updateTime,insertTime"];
        sql=[NSMutableString stringWithFormat:@" %@ ) VALUES (",sql];
        for (D_TableField* field in table.fieldList)
        {
            [sql appendFormat:@"'%@',", [rpt getString:field.fieldName]];
        }
        [sql appendFormat:@"'0','%@','%@');", now(),now()];
        //        sql=[NSMutableString stringWithFormat:@"%@ );",[sql substringToIndex:(sql.length-1)]];
        
        NSLog(@"%@",sql);
        char *errorMsg;
        if (sqlite3_exec(mDB, [sql UTF8String], nil, nil, &errorMsg) == SQLITE_OK)
        {
            rowId=(int)sqlite3_last_insert_rowid(mDB);
            NSLog(@"报告id%d",rowId);
            [self creatRptDetail:[rpt detailList] rowId:rowId];
            [self creatRptPhoto:[rpt attList] rowId:rowId];
        }
        
        [self commitTransaction];
        [self closeDB];
        return rowId;
    }
}

-(void)creatRptDetail:(NSMutableArray*)list rowId:(int)rowId
{
    @synchronized(self)
    {
        NSMutableString* sql;
        char *errorMsg;
        if(list)
        {
            for(NSMutableDictionary* data in list)
            {
                sql = [NSMutableString stringWithFormat:@"INSERT INTO t_data_callReportDetail("];
                D_Table* table=table_CallDetail();
                for (D_TableField* field in table.fieldList)
                {
                    [sql appendFormat:@" %@ ,", [field.fieldName lowercaseString]];
                }
                sql=[NSMutableString stringWithFormat:@" %@ ) VALUES (",[sql substringToIndex:(sql.length-1)]];
                for (D_TableField* field in table.fieldList)
                {
                    if ([field.fieldName isEqualToString:@"callReportId"])
                        [sql appendFormat:@"'%d',", rowId];
                    else if ([field.fieldName isEqualToString:@"updateTime"])
                        [sql appendFormat:@"'%@',", now()];
                    else if ([field.fieldName isEqualToString:@"insertTime"])
                        [sql appendFormat:@"'%@',", now()];
                    
                    else if ([field.fieldName isEqualToString:@"ProductId"])
                        [sql appendFormat:@"'%@',", [data getString:@"serverid"]];
                    else if ([field.fieldName isEqualToString:@"serverid"])
                        [sql appendFormat:@"'',"];
                    else
                        [sql appendFormat:@"'%@',", [data getString:field.fieldName]];
                }
                sql=[NSMutableString stringWithFormat:@"%@ );",[sql substringToIndex:(sql.length-1)]];
                
                NSLog(@"%@",sql);
                sqlite3_exec(mDB, [sql UTF8String], nil, nil, &errorMsg);
            }
        }
    }
}

-(void)creatRptPhoto:(NSMutableArray*)list rowId:(int)rowId
{
    @synchronized(self)
    {
        NSMutableString* sql;
        char *errorMsg;
        if(list)
        {
            for(NSMutableDictionary* data in list)
            {
                sql = [NSMutableString stringWithFormat:@"INSERT INTO t_data_callReportPhoto("];
                D_Table* table=table_CallPhoto();
                for (D_TableField* field in table.fieldList)
                {
                    [sql appendFormat:@" %@ ,", [field.fieldName lowercaseString]];
                }
                sql=[NSMutableString stringWithFormat:@" %@ ) VALUES (",[sql substringToIndex:(sql.length-1)]];
                for (D_TableField* field in table.fieldList)
                {
                    if ([field.fieldName isEqualToString:@"callReportId"])
                        [sql appendFormat:@"'%d',", rowId];
                    else if ([field.fieldName isEqualToString:@"updateTime"])
                        [sql appendFormat:@"'%@',", now()];
                    else if ([field.fieldName isEqualToString:@"insertTime"])
                        [sql appendFormat:@"'%@',", now()];
                    else
                        [sql appendFormat:@"'%@',", [data getString:field.fieldName]];
                }
                sql=[NSMutableString stringWithFormat:@"%@ );",[sql substringToIndex:(sql.length-1)]];
                
                NSLog(@"%@",sql);
                if (sqlite3_exec(mDB, [sql UTF8String], nil, nil, &errorMsg) != SQLITE_OK)
                {
                    //                alert_showErrMsg([NSString stringWithFormat:@"错误:%@",errorMsg ]);
                }
//                NSLog([NSString stringWithFormat:@"错误:%@",errorMsg]);
            }
        }
    }
}


/**
 [""]	<#Description#>下载主数据
 [""]	@param result <#result description#>
 [""]	@returns <#return value description#>
 [""] */
-(BOOL) upsertData:(D_SyncResult*)result
{
    @synchronized(self)
    {
        if(!result)
            return NO;
        NSMutableArray* list=result.getFieldList;
        if([list count]==0)
            return YES;
        D_Table* table=get_table([result getString:RETURNTYPE]);
        if (!table)
            return NO;
        NSMutableArray* listSql=[[NSMutableArray alloc]init];
        //        NSMutableArray* listSql=[[NSMutableArray alloc]init];
        if ([[result getString:RETURNTYPE] isEqualToString:@"T_Message_Detail"]) {
            
            NSMutableArray* fieldList;//[self fieldListBy:[NSString stringWithFormat:@"select * from t_data_edoc where serverid ='%@'",]];
            
            for (NSMutableDictionary* data in list)
            {
                if (data)
                {
                    fieldList=[self fieldListBy:[NSMutableString stringWithFormat:@"select * from T_Message_Detail where serverid ='%@'",[data getString:@"serverid"]]];
                    
                    if ([fieldList count]==0)
                        [listSql addString:[self replaceSql:data table:table]];
                    
                }
            }
        }
        else
        {
            
            
            NSMutableDictionary* data;
            
            for (int i=0;i<[list count];i++)
            {
                data=[list dictAt:i];
                if (data)
                {
                    if ([[data getString:@"isDel"] isEqualToString:@"1"] )
                        [listSql addString:[self deleteSql:data table:[result getString:RETURNTYPE]]];
                    else
                        [listSql addString:[self replaceSql:data table:table]];
                    //                }
                }
            }
        }
        
        return [self execSqlList:listSql];
    }
}

-(NSString*)deleteSql:(NSMutableDictionary*)data table:(NSString*)tableName
{
    return [NSString stringWithFormat:@"DELETE FROM %@ where serverid ='%@'",tableName,[data getString:@"serverid"]];
}

/**
 [""]	<#Description#>单独执行数据
 [""]	@returns <#return value description#>
 [""] */
-(BOOL)execSql :(NSString*) sql
{
    @synchronized(self)
    {
        NSLog(@"sql%@",sql);
        [self openDB];
        char *errorMsg;
        if (sqlite3_exec(mDB, [sql UTF8String], nil, nil, &errorMsg) != SQLITE_OK) {
            
            [self closeDB];
            return false;
            NSAssert1(0,@"the error is %s", errorMsg);
            NSAssert1(0,@"create table %@ faild", sql);
        }
        [self closeDB];
        return true;
    }
}

/**
 [""]	<#Description#>批量执行数据
 [""]	@returns <#return value description#>
 [""] */
-(BOOL)execSqlList :(NSMutableArray*) list
{
    @synchronized(self)
    {
        [self openDB];
        [self beginTransaction];
        char *errorMsg;
        for (NSString* sql in list) {
            
            NSLog(@"%@",sql);
            if (sqlite3_exec(mDB, [sql UTF8String], nil, nil, &errorMsg) != SQLITE_OK) {
                
                NSAssert1(0,@"the error is %s", errorMsg);
                NSAssert1(0,@"create table %@ faild", sql);
                [self closeDB];
                return false;
                
            }
        }
        [self commitTransaction];
        [self closeDB];
        return true;
    }
}



/**
 [""]	<#Description#>获取生成表结构的sql语句
 [""]	@param table <#table description#>
 [""]	@returns <#return value description#>
 [""] */
- (NSString*)createTableSql:(D_Table *)table
{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY not null", [table.tableName lowercaseString],PRIMARY_KEY];
    D_TableField* field;
    for (int i = 0; i < [table.fieldList count]; i++)
    {
        field = [table.fieldList objectAtIndex:i];
        [sql appendFormat:@", %@", [field.fieldName lowercaseString]];
        switch (field.fieldType) {
            case INTEGER:
                [sql appendString:@" INTEGER"];
                break;
            case VACHAR:
                [sql appendString:@" TEXT"];
                break;
                
            case BLOB:
                [sql appendString:@" BLOB"];
                break;
            case TIMESTAMP:
                [sql appendString:@" TIMESTAMP"];
                break;
                
            default:
                break;
        }
        if(!field.isNULL)
            [sql appendString:@" not null"];
        if(field.isUnique)
            [sql appendString:@" UNIQUE"];
    }
    
    [sql appendString:@",issubmit INTEGER DEFAULT -1, isdel INTEGER DEFAULT 0, updatetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP, inserttime TIMESTAMP DEFAULT CURRENT_TIMESTAMP"];
    
    [sql appendString:@")"];
    
    NSLog(@"数据库创建%@",sql);
    return sql;
}




-(NSString*) valueAt:(int)index stmt:(sqlite3_stmt*)stmt
{
    NSLog(@"%d",index);
    if(sqlite3_column_text(stmt, index))
        return [[NSString alloc] initWithCString:(char *)sqlite3_column_text(stmt, index) encoding:NSUTF8StringEncoding];
    else
        return @"";
}

-(NSString*) columNameAt:(int)index stmt:(sqlite3_stmt*)stmt
{
    return [[NSString alloc] initWithCString:(char *)sqlite3_column_name(stmt, index) encoding:NSUTF8StringEncoding];
}

-(int)controlType:(NSString*)type
{
    if ([type isEqualToString:@"3"]) {
        return TEXT;
    }
    else if ([type isEqualToString:@"2"]) {
        return SINGLECHOICE;
    }
    else if ([type isEqualToString:@"1"]) {
        return MULTICHOICE;
    }
    return TEXT;
}

-(int)verifyType:(NSString*)type
{
    if ([type isEqualToString:@"number"]) {
        return NUMBER;
    }
    else if ([type isEqualToString:@"amount"]) {
        return AMOUNT;
    }
    else if ([type isEqualToString:@"text"]) {
        return DEFAULT;
    }
    return DEFAULT;
}

- (NSMutableArray*) dictList:(NSString*)dictId
{
    @synchronized(self)
    {
        //        NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT i.value,i.labelname,i.remark,d.dictcode,d.dictname from t_base_dict_item i left join t_base_dictionary d on i.dictid=d.serverid where d.dictcode='%@'  order by i.position",dictId];
        NSMutableString *sql;
        if([dictId isEqualToString:@"-100"])
            sql = [NSMutableString stringWithFormat:@"SELECT productname as labelname,serverid as value  FROM t_product where iscompete=1 "];
        else if([dictId isEqualToString:@"-101"])
            sql = [NSMutableString stringWithFormat:@"SELECT orgname as labelname ,serverid as value FROM t_organization where level=2"];
        else if([dictId isEqualToString:@"-102"])
            sql = [NSMutableString stringWithFormat:@"SELECT orgname as labelname ,serverid as value FROM t_organization where level=3  "];//and  parentid='"+ linkdictId + "'
        else if([dictId isEqualToString:@"-1001"])
            sql = [NSMutableString stringWithFormat:@"select brand as value ,brand as labelname from t_product group by brand"];
        else if([dictId isEqualToString:@"-1002"])
            sql = [NSMutableString stringWithFormat:@"select xilie as value ,xilie as labelname  from t_product  group by xilie"];//brand='"+ linkdictId + "'
        else
            sql = [NSMutableString stringWithFormat:@"SELECT dictclass as value, dictname as labelname,dictvalue FROM t_sys_dictionary where dictclass>0 and dicttype='%@' ",dictId];
        if(sql)
        {
            NSMutableArray* dictList=[self fieldListBy:sql];
//            if([dictId isEqualToString:@"100"]) {
//                NSMutableDictionary* data = [NSMutableDictionary dictionary];
//                [data put:@"其他" key:@"labelname"];
//                [data put:@"-1" key:@"value"];
//                [dictList addDict:data];
//        }
            
            return dictList;
        }
        else
            return nil;
    }
}

- (NSMutableArray*) dictList:(NSString*)dictId link:(NSString* )link
{
    @synchronized(self)
    {
        //        NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT i.value,i.labelname,i.remark,d.dictcode,d.dictname from t_base_dict_item i left join t_base_dictionary d on 1i.dictid=d.serverid where d.dictcode='%@'  order by i.position",dictId];
        NSMutableString *sql;
//        if([dictId isEqualToString:@"-100"])
//            sql = [NSMutableString stringWithFormat:@"SELECT serverid as value ,fullname as labelname FROM t_outlet_main where outlettype=1  order by  fullname"];
//        else if([dictId isEqualToString:@"-101"])
//            sql = [NSMutableString stringWithFormat:@"SELECT orgname as labelname ,serverid as value FROM t_organization where level=2"];
         if([dictId isEqualToString:@"-102"])
            sql = [NSMutableString stringWithFormat:@"SELECT orgname as labelname ,serverid as value FROM t_organization where level=3  and parentid='%@'",link];//and  parentid='"+ linkdictId + "'
//        else if([dictId isEqualToString:@"-1001"])
//            sql = [NSMutableString stringWithFormat:@"select brand as value ,brand as labelname from t_product group by brand"];
//        else if([dictId isEqualToString:@"-1002"])
//            sql = [NSMutableString stringWithFormat:@"select xilie as value ,xilie as labelname  from t_product  group by xilie"];//brand='"+ linkdictId + "'
//        else
//            sql = [NSMutableString stringWithFormat:@"SELECT dictclass as value, dictname as labelname,dictvalue FROM t_sys_dictionary where dictclass>0 and dicttype='%@' ",dictId];
        if(sql)
        {
            NSMutableArray* dictList=[self fieldListBy:sql];
//            if([dictId isEqualToString:@"-1000"]) {
//                NSMutableDictionary* data = [NSMutableDictionary dictionary];
//                [data put:@"其他护理师" key:@"labelname"];
//                [data put:@"-1" key:@"value"];
//                [dictList addDict:data];
//                data = [NSMutableDictionary dictionary];
//                [data put:@"其他护理师" key:@"labelname"];
//                [data put:@"-2" key:@"value"];
//                [dictList addDict:data];
//                data = [NSMutableDictionary dictionary];
//                [data put:@"其他护理师" key:@"labelname"];
//                [data put:@"-3" key:@"value"];
//                [dictList addDict:data];
//            }
            
            return dictList;
        }
        else
            return nil;
    }
}


- (NSMutableArray*) dictList:(NSString*)dictId clientId:(NSString* )clientId
{
    @synchronized(self)
    {
        //        NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT i.value,i.labelname,i.remark,d.dictcode,d.dictname from t_base_dict_item i left join t_base_dictionary d on i.dictid=d.serverid where d.dictcode='%@'  order by i.position",dictId];
        NSMutableString *sql;

         if([dictId isEqualToString:@"-1000"])
            sql = [NSMutableString stringWithFormat:@"SELECT serverid as value,empname as labelname FROM t_emp_ba where str1='%@' ",clientId];
       
        if(sql)
        {
            NSMutableArray* dictList=[self fieldListBy:sql];
            if([dictId isEqualToString:@"-1000"]) {
                NSMutableDictionary* data = [NSMutableDictionary dictionary];
                [data put:@"其他护理师" key:@"labelname"];
                [data put:@"-1" key:@"value"];
                [dictList addDict:data];
                data = [NSMutableDictionary dictionary];
                [data put:@"其他护理师" key:@"labelname"];
                [data put:@"-2" key:@"value"];
                [dictList addDict:data];
                data = [NSMutableDictionary dictionary];
                [data put:@"其他护理师" key:@"labelname"];
                [data put:@"-3" key:@"value"];
                [dictList addDict:data];
            }
            
            return dictList;
        }
        else
            return nil;
    }
}

- (NSString*) valueBy:(NSString*)sql key:(NSString*)key
{
    @synchronized(self)
    {
        NSLog(@"%@",sql);
        [self openDB];
        if(sql)
        {
            //            D_Field* field=[[D_Field alloc]newInstance];
            sqlite3_stmt *statement;
            
            if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                //            sqlite3_column_count(<#sqlite3_stmt *pStmt#>)//获取语句返回的总的列数
                int row=0;
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    //                    field=[[D_Field alloc]newInstance];
                    row=sqlite3_data_count(statement);
                    
                    for(int i=0;i<row;i++)
                    {
                        if([[self columNameAt:i stmt:statement] isEqualToString:key])
                            return [self valueAt:i stmt:statement];
                    }
                }
                sqlite3_finalize(statement);
            }
            else
            {
                NSLog(@"%d", sqlite3_step(statement));
                NSLog(@"Error: %s", sqlite3_errmsg(mDB));
                NSLog(@"get data list failed!!!");
            }
            [self closeDB];
            return @"";
        }
        else
            return nil;
    }
}


- (NSMutableArray*) fieldListBy1:(NSString*)sql
{
    @synchronized(self)
    {
        [self openDB];
        //        NSMutableString  *
        //        sql = [NSMutableString stringWithFormat:@"SELECT   i.value,i.labelname,i.remark,d.dictcode,d.dictname from t_base_dict_item i left join t_base_dictionary d on i.dictid=d.serverid where d.dictcode='%@'  order by i.position",today()];
        if(sql)
        {
            NSLog(@"查:%@",sql);
            NSMutableArray* clientList=[[NSMutableArray alloc]init];
            NSMutableDictionary* field;
            sqlite3_stmt *statement;
            
            if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                //            sqlite3_column_count(<#sqlite3_stmt *pStmt#>)//获取语句返回的总的列数
                int row=0;
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    field=[NSMutableDictionary dictionary];
                    row=sqlite3_data_count(statement);
                    
                    for(int i=0;i<row;i++)
                    {
                        [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                    }
                    [clientList addDict:field];
                }
                sqlite3_finalize(statement);
            }
            else
            {
                NSLog(@"%d", sqlite3_step(statement));
                NSLog(@"Error: %s", sqlite3_errmsg(mDB));
                NSLog(@"get data list failed!!!");
            }
            [self closeDB];
            return clientList;
        }
        else
            return nil;
    }
}

- (NSMutableArray*) fieldListBy:(NSMutableString*)sql
{
    @synchronized(self)
    {
        [self openDB];
        //        NSMutableString  *
        //        sql = [NSMutableString stringWithFormat:@"SELECT   i.value,i.labelname,i.remark,d.dictcode,d.dictname from t_base_dict_item i left join t_base_dictionary d on i.dictid=d.serverid where d.dictcode='%@'  order by i.position",today()];
        if(sql)
        {
            NSLog(@"查:%@",sql);
            NSMutableArray* clientList=[[NSMutableArray alloc]init];
            NSMutableDictionary* field;
            sqlite3_stmt *statement;
            
            if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                //            sqlite3_column_count(<#sqlite3_stmt *pStmt#>)//获取语句返回的总的列数
                int row=0;
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    field=[NSMutableDictionary dictionary];
                    row=sqlite3_data_count(statement);
                    
                    for(int i=0;i<row;i++)
                    {
                        [field put:[self valueAt:i stmt:statement] key:[self columNameAt:i stmt:statement]];
                    }
                    [clientList addDict:field];
                }
                sqlite3_finalize(statement);
            }
            else
            {
                NSLog(@"%d", sqlite3_step(statement));
                NSLog(@"Error: %s", sqlite3_errmsg(mDB));
                NSLog(@"get data list failed!!!");
            }
            [self closeDB];
            return clientList;
        }
        else
            return nil;
    }
}

- (NSMutableArray*) fieldList:(int)type
{
    @synchronized(self)
    {
        NSMutableString  *sql;
        switch (type) {
            case VISITPLAN:
                sql = [NSMutableString stringWithFormat:@"SELECT vd.issubmit as issubmit, vd.isevent as isevent,vd.eventtype as eventtype, case when  sum(c.issubmit is not null) is 0 then '-1' when sum(c.issubmit is 2)>0 then '2'  when sum(c.issubmit is 1)=sum(c.issubmit is not null) then '1' else '0' end as str2, case when  sum(c.issubmit is not null) is 0 then '未拜访' else  sum(c.issubmit is 1)||'/'||sum(c.issubmit is not null) end as str1,  o.serverid as serverid, o.terminalname as terminalname ,o.templategroupid as templategroupid ,vd.clienttype as clienttype ,vd.key_id as key_id FROM ( select * from   t_data_plan  where calldate ='%@' and clienttype=1 and isevent='N') vd left join (select * from t_data_callreport where calldate='%@' and clienttype=1 and isevent='N') c on c.teminalcode=vd.clientid left join t_data_terminal o on o.serverid=vd.clientid group by vd.clientid union SELECT vd.issubmit as issubmit, vd.isevent as isevent,vd.eventtype as eventtype, case when  sum(c.issubmit is not null) is 0 then '-1' when sum(c.issubmit is 2)>0 then '2' when sum(c.issubmit is 1)=sum(c.issubmit is not null) then '1' else '0' end as str2, case when  sum(c.issubmit is not null) is 0 then '未拜访' else  sum(c.issubmit is 1)||'/'||sum(c.issubmit is not null) end as str1,  o.serverid as serverid, o.chainstorename as terminalname,o.templategroupid as templategroupid ,vd.clienttype as clienttype ,vd.key_id as key_id FROM ( select * from   t_data_plan  where calldate ='%@' and clienttype=2 and isevent='N') vd left join (select * from t_data_callreport where calldate='%@' and clienttype=2 and isevent='N') c on c.teminalcode=vd.clientid left join t_data_chainstore o on o.serverid=vd.clientid group by vd.clientid union SELECT vd.issubmit as issubmit,vd.isevent as isevent,vd.eventtype as eventtype, case when  sum(c.issubmit is not null) is 0 then '-1' when sum(c.issubmit is 2)>0 then '2'  when sum(c.issubmit is 1)=sum(c.issubmit is not null) then '1' else '0' end as str2,case when  sum(c.issubmit is not null) is 0 then '未拜访' else  sum(c.issubmit is 1)||'/'||sum(c.issubmit is not null) end as str1,  o.serverid as serverid, o.distributename as terminalname,o.templategroupid as templategroupid,vd.clienttype as clienttype ,vd.key_id as key_id FROM ( select * from   t_data_plan  where calldate ='%@' and clienttype=3 and isevent='N') vd left join (select * from t_data_callreport where calldate='%@' and clienttype=3 and isevent='N') c on c.teminalcode=vd.clientid left join t_data_distribute o on o.serverid=vd.clientid group by vd.clientid union SELECT vd.issubmit as issubmit, vd.isevent as isevent,vd.eventtype as eventtype,case when  sum(c.issubmit is not null) is 0 then '-1' when sum(c.issubmit is 2)>0 then '2'  when sum(c.issubmit is 1)=sum(c.issubmit is not null) then '1' else '0' end as str2, case when  sum(c.issubmit is not null) is 0 then '未拜访' else  sum(c.issubmit is 1)||'/'||sum(c.issubmit is not null) end as str1,  '0' as serverid, vd.planname as terminalname ,o.templategroupid as templategroupid ,'0' as clienttype ,vd.key_id as key_id FROM (select * from   t_data_plan  where calldate ='%@' and isevent='Y') vd left join (select * from t_data_callreport where calldate='%@' and isevent='Y') c on c.planid=vd.key_id left join (select * from t_data_templategroup_distr where isevent='Y') o on o.eventtype=vd.eventtype group by c.planid order by str1 desc",today(),today(),today(),today(),today(),today(),today(),today()];
                break;
                
            case HOCPLAN:
                sql = [NSMutableString stringWithFormat:@"select 1 as plan, 'N' as isevent,serverid ,terminalname as terminalname ,1 as clienttype,templategroupid from t_data_terminal where serverid not in (select clientid from t_data_plan where calldate='%@' and clienttype=1) union select 1 as plan, 'N' as isevent,serverid ,chainstorename as terminalname ,2 as clienttype,templategroupid from t_data_chainstore where serverid not in (select clientid from t_data_plan where calldate='%@' and clienttype=2) union select 1 as plan, 'N' as isevent,serverid ,distributename as terminalname ,3 as clienttype,templategroupid from t_data_distribute where serverid not in (select clientid from t_data_plan where calldate='%@' and clienttype=3) order by clienttype ,terminalname limit 50",today(),today(),today()];
                break;
                
                
                
            default:
                break;
        }
        
        if(sql)
        {
            NSMutableArray* clientList=[self fieldListBy:sql];
            return clientList;
        }
        else
            return nil;
    }
}


- (NSMutableArray*) fieldListByData:(D_Field*)data type:(int)type
{
    @synchronized(self)
    {
        NSMutableString  *sql;
        
        switch (type) {
            case SEARCHCLIENT:
                sql = [NSMutableString stringWithFormat:@"select 1 as plan, serverid ,terminalname as terminalname ,1 as clienttype,templategroupid from t_data_terminal where terminalname like '%%%@%%' or terminalcode like '%%%@%%' and serverid not in (select clientid from t_data_plan where calldate='%@' and clienttype=1) union select 1 as plan, serverid ,chainstorename as terminalname ,2 as clienttype,templategroupid from t_data_chainstore where (chainstorename like '%%%@%%' or chainstorecode like '%%%@%%') and serverid not in (select clientid from t_data_plan where calldate='%@' and clienttype=2) union select 1 as plan, serverid ,distributename as terminalname ,3 as clienttype,templategroupid from t_data_distribute where (distributename like '%%%@%%' or distributecode like '%%%@%%') and serverid not in (select clientid from t_data_plan where calldate='%@' and clienttype=3) order by clienttype ,terminalname limit 20",[data getString:@"code"],[data getString:@"code"],today(),[data getString:@"code"],[data getString:@"code"],today(),[data getString:@"code"],[data getString:@"code"],today()];
                
                break;
                
            case COMPLETERPT:
            {
                sql =  [NSMutableString stringWithFormat:@" select onlytype from t_data_callreport where reportdate='%@' and ClientId='%@' and decimal10='%@'",today(),[data getString:@"clientid"] ,[data getString:@"key"] ];
                
            }
                
                break;
            default:
                break;
        }
        
        if(sql)
        {
            NSMutableArray* clientList=[self fieldListBy:sql];
            return clientList;
        }
        else
            return nil;
    }
}

/**
 [""]	<#Description#>获取具体步骤
 [""]	@param templateId <#templateId description#>
 [""]	@returns <#return value description#>
 [""] */
- (D_Template *) surveyTemplate:(NSString *)templateId

{
    @synchronized(self)
    {
        [self openDB];
        NSMutableString  *sql;
        sql = [NSMutableString stringWithFormat:@"select s.title as stitle, s.isphoto as isphoto, q.*  from (select * from t_psq_question where psqid='%@' ) q left join t_psq s where q.psqid=s.serverid", templateId];
        
        NSLog(@"templateSql:%@",sql);
        
        D_Template* temp=[[D_Template alloc]init];
        temp.templateId=@"-100";
        temp.type=@"-100";
        temp.onlyType=-100;
        
        NSMutableDictionary* button=[NSMutableDictionary dictionary];
        [button put:@"基本信息" key:@"name"];
        [button putInt:1 key:@"buttonId"];
        [temp addButtonList:button];
        
        button=[NSMutableDictionary dictionary];
        [button put:@"照片" key:@"name"];
        [button putInt:3 key:@"buttonId"];
        [temp addButtonList:button];
        
        D_Panel* panel;
        
        D_UIItem* item;
        sqlite3_stmt *statement;
        
        if (sqlite3_prepare_v2(mDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                temp.version=[self valueAt:5 stmt:statement];
                temp.name=[self valueAt:0 stmt:statement];
                if([[self valueAt:1 stmt:statement] isEqualToString:@"1"])
                    temp.isMustPhoto=YES;
                
                panel=[[D_Panel alloc]init];
                panel.type=PANEL_PANEL;
                panel.name=[self valueAt:6 stmt:statement];
                panel.panelId=[self valueAt:3 stmt:statement];
                [temp addPanel:panel];
                
                item=[[D_UIItem alloc]init];
                item.caption=[self valueAt:6 stmt:statement];
                //                item.itemlId=[self valueAt:3 stmt:statement];
                item.lableWidth=50;
                item.controlType=[self controlType:[self valueAt:7 stmt:statement]];
                item.dataKey=@"str3";
                item.isShowCaption=NO;
                
                item.isSurverItem=YES;
                item.maxLenth=200;
                item.dicId=[self valueAt:3 stmt:statement];
                [panel addItem:item];
                
            }
            sqlite3_finalize(statement);
        }
        else
        {
            NSLog(@"%d", sqlite3_step(statement));
            NSLog(@"Error: %s", sqlite3_errmsg(mDB));
            NSLog(@"get data list failed!!!");
        }
        
        [self closeDB];
        panel=nil;
        item=nil;
        return temp;
    }
}
@end

