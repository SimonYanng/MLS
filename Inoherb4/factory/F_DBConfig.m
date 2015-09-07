//
//  F_DBConfig.m
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "F_DBConfig.h"
#import "D_TableField.h"
#import "NSMutableArray+Tool.h"

NSMutableArray* tableList;

/**
 <#Description#>产品表
 @returns <#return value description#>
 */
D_Table* table_Product()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Product";
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"ServerId";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ProductCode";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"productname";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"shortName";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"FullNameEn";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ShortNameEn";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Package";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Unit";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ChannelId";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"IsCompete";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"IsEnd";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"StandardPrice";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"WholesalePrice";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"AfterTaxPrice";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"BeforeTaxPrice";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"isgroup";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"LevelId";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"brand";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"xilie";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"nodeid";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"isSensitive";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"isNew";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"remark";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}

/**
 <#Description#> 客户表
 @returns <#return value description#>
 */
D_Table* table_Terrminal()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Outlet_Main";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"OutletId";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"OutletCode";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"OutletType";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"FullName";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ShortName";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ChannelId";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"OrgId";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"RegionId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ChainStoreId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"facialdiscount";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"facediscount";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"milkdiscount";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"newdiscount";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"demiwarecount";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Address";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"LogesticAddress";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ZIP";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Tel";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Fax";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DelDate";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"IsEnd";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"OutletLevel";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Attribute";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"lon";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"lat";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"remark";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"INT2";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"INT1";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"ParentId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number1";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number2";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number3";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number4";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number5";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number6";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number7";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number8";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number9";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"number10";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str11";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str12";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str13";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str14";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str15";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str16";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str17";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str18";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str19";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str20";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str21";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str22";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str23";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str24";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str25";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str26";
    field.fieldType=VACHAR;
    [table addField:field];
    
    return table;
}

/**
 <#Description#>计划表
 @returns <#return value description#>
 */
D_Table* table_Plan()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Visit_Plan_Detail";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverId";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"PlanId";
    field.fieldType=VACHAR;
    //    field.isNULL=NO;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientType";
    field.fieldType=VACHAR;
    //    field.isNULL=NO;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"VisitTime";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"IsApproval";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Remark";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Analysis";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Edate";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"Sdate";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"Type";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}

/**
 <#Description#> 主报告
 @returns <#return value description#>
 */
D_Table* table_CallReport()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"t_data_callReport";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    //    field.isNULL=NO;
    //    field.isUnique=YES;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=MOBILE_KEY;
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"onlyType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"TemplateId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"errmsg";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientId";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ReportDate";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"remark";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int1";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int11";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int12";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int13";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int14";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int15";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int16";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int17";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int18";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int19";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int20";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    return table;
}


/**
 <#Description#> 明细报告
 @returns <#return value description#>
 */
D_Table* table_CallDetail()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"t_data_callReportDetail";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    //    field.isNULL=NO;
    //    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ProductId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"callReportId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"remark";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int1";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"int10";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"decimal10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    return table;
}


/**
 <#Description#> 报告照片
 @returns <#return value description#>
 */
D_Table* table_CallPhoto()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"t_data_callReportPhoto";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    //    field.isNULL=NO;
    //    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ShotTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"lShotTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"QuestionnaireId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"loginmobileTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"mobileTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"loginTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"PhotoType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ProductId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"callReportId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"photo";
    field.fieldType= VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DisplayObject";
    field.fieldType= VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DisplayType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"remark";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    
    
    return table;
}

/**
 <#Description#> 字典表
 @returns <#return value description#>
 */
D_Table* table_Dictionary()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Sys_Dictionary";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DictId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DictType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DictClass";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DictName";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"Remark";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"DictValue";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"OrderNo";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"IsLock";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    
    
    return table;
}


/**
 <#Description#> 消息
 @returns <#return value description#>
 */
D_Table* table_Message()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Message_Detail";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Title";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"errmsg";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Content";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Stime";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"Sender";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"status";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    return table;
}

/**
 <#Description#> DP列表
 @returns <#return value description#>
 */
D_Table* table_DPList()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Client_Rlt_ActivityPromoter";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"PromoterId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Mobile";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"PromoterName";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"WorkDay";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    return table;
}

/**
 <#Description#> DP照片
 @returns <#return value description#>
 */
D_Table* table_DPPhoto()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"t_data_DPPhoto";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    //    field.isNULL=NO;
    //    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ShotTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"lShotTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"QuestionnaireId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"loginmobileTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"mobileTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"loginTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"PhotoType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ProductId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"callReportId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"photo";
    field.fieldType= VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DisplayObject";
    field.fieldType= VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DisplayType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"remark";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}


/**
 <#Description#> DP照片
 @returns <#return value description#>
 */
D_Table* table_Activity()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Activity_Main";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ActivitiesCode";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DisplayType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"DisplayArea";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Cost";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Payment";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"STime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ETime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientCode";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientAmountId";
    field.fieldType= VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"EmpId";
    field.fieldType= VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"EmpCode";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Remark";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}


/**
 <#Description#> 问卷头
 @returns <#return value description#>
 */
D_Table* table_SurveyHead()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_PSQ";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"PsqId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"title";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"empid";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"isPhoto";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"explain";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}

/**
 <#Description#> 问卷
 @returns <#return value description#>
 */
D_Table* table_SurveyQuestion()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_PSQ_Question";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"QuestionId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"PSQId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"title";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"type";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"typeName";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}

/**
 <#Description#> 问卷
 @returns <#return value description#>
 */
D_Table* table_SurveyQuestionOption()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_PSQ_Options";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"OptionId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"QuestionId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"value";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}

/**
 <#Description#> 问卷
 @returns <#return value description#>
 */
D_Table* table_SurveyRltClient()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_PSQ_Payout";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"PayoutId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"PSQId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Clientid";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientType";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"StartTime";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"EndTime";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"Explain";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}


/**
 <#Description#> 问卷
 @returns <#return value description#>
 */
D_Table* table_Eoc()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Train_List";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"TrainId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"AttachmentName";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"AttachmentType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"AttachmentURL";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"AtrType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}

D_Table* table_VisitQuestion()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Visit_Question";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ClientId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"FullName";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ReportDate";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"EmpId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"EmpName";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"QuestionId";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"QuestionName";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"DealName";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"IsDeal";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}

D_Table* table_Organization()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Organization";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"OrgId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"OrgCode";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"OrgName";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"ParentId";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"Level";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"OrgType";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str4";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str5";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str6";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str7";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str8";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str9";
    field.fieldType=VACHAR;
    
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"str10";
    field.fieldType=VACHAR;
    
    [table addField:field];
    return table;
}


D_Table* table_EmpBA()
{
    D_Table* table=[[D_Table alloc]init];
    table.tableName=@"T_Emp_BA";
    //    table.setKey("serverid");
    
    D_TableField* field=[[D_TableField alloc] init];
    field.fieldName=@"serverid";
    field.fieldType=VACHAR;
    field.isNULL=NO;
    field.isUnique=YES;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"EmpId";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"EmpCode";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"EmpName";
    field.fieldType=VACHAR;
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"JobName";
    field.fieldType=VACHAR;
    [table addField:field];
    field=[[D_TableField alloc] init];
    field.fieldName=@"IsTeam";
    field.fieldType=VACHAR;
    [table addField:field];
    
    
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str1";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str2";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    field=[[D_TableField alloc] init];
    field.fieldName=@"str3";
    field.fieldType=VACHAR;
    
    [table addField:field];
    
    
    return table;
}


NSMutableArray* table_List()
{
    if(!tableList)
    {
        tableList=[[NSMutableArray alloc]init];
        [tableList addTable:table_Product()];
        [tableList addTable:table_Terrminal()];
        [tableList addTable:table_Dictionary()];
        [tableList addTable:table_Plan()];
        
        [tableList addTable:table_CallReport()];
        [tableList addTable:table_CallDetail()];
        [tableList addTable:table_CallPhoto()];
        [tableList addTable:table_Message()];
        [tableList addTable:table_DPList()];
        [tableList addTable:table_DPPhoto()];
        [tableList addTable:table_Activity()];
        
        [tableList addTable:table_Eoc()];
        [tableList addTable:table_EmpBA()];
         [tableList addTable:table_Organization()];
        
        [tableList addTable:table_VisitQuestion()];
        
        [tableList addTable:table_SurveyHead()];
        [tableList addTable:table_SurveyQuestion()];
        [tableList addTable:table_SurveyQuestionOption()];
        [tableList addTable:table_SurveyRltClient()];
        
    }
    
    return tableList;
}

D_Table* get_table(NSString* name)
{
    D_Table* table;
    if(!tableList)
        table_List();
    for (int i=0;i<[tableList count];i++)
    {
        table=[tableList tableAt:i];
        if ([[table.tableName lowercaseString] isEqualToString:[name lowercaseString]])
            return table;
    }
    return nil;
}