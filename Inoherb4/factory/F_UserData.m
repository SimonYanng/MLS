//
//  F_UserData.m
//  SFA
//
//  Created by Ren Yong on 13-10-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "F_UserData.h"

NSUserDefaults* userDefaults;
//static NSString* USER_NAME=@"user_name";
//static NSString* USER_PWD=@"user_pwd";

#define USER_NAME @"user_name"
#define USER_NAME1 @"user_name1"
#define USER_PWD @"user_pwd"
#define USER_SAVEPWD @"user_savepwd"
#define FIRST_USE @"first_use"
#define USER_ID @"user_id"
#define LOGIN_DATE @"login_date"
#define UPLOAD_DATETIME @"upload_datetime"

#define USER_CITY @"city"

#define SALES @"sales"

#define CLIENTCODE @"clientcode"

#define STARTWORKTIME @"startworktime"
#define ENDWORKTIME @"endworktime"

#define NEWDB @"isnewdb"

#define CLIENTCODE1 @"clientcode1"//排班门店code

//static NSString* USER_SAVEPWD=@"user_savepwd";
//static NSString* FIRST_USE=@"first_use";
//static NSString* USER_ID=@"user_id";
//static NSString* LOGIN_DATE=@"login_date";
//static NSString* UPLOAD_DATETIME=@"upload_datetime";

void getUserDefaults()
{
    if(userDefaults==nil)
        userDefaults=[NSUserDefaults standardUserDefaults];
}

//void setObject(NSString* key, id value)
//{
//    
//    getUserDefaults();
//    if([value isKindOfClass:[NSString class]])
//        [userDefaults setObject:value forKey:key];
//    else if([value is:[NSInteger class]])
//        [userDefaults setInteger:value forKey:key];
//    [userDefaults synchronize];
//}

/**
 <#Description#> 保存String
 @param key <#key description#>
 @param value <#value description#>
 */

void saveString(NSString* key,NSString* value)
{
    getUserDefaults();
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

/**
 <#Description#> 保存Bool
 @param key <#key description#>
 @param value <#value description#>
 */
void saveBool(NSString* key,BOOL value)
{
    getUserDefaults();
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

/**
 <#Description#>保存Integer
 @param key <#key description#>
 @param value <#value description#>
 */
void saveInteger(NSString* key,int value)
{
    getUserDefaults();
    [userDefaults setInteger:value forKey:key];
    [userDefaults synchronize];
}

/**
 <#Description#>保存Float
 @param key <#key description#>
 @param value <#value description#>
 */
void saveFloat(NSString* key,float value)
{
    getUserDefaults();
    [userDefaults setFloat:value forKey:key];
    [userDefaults synchronize];
}


/**
 <#Description#> 保存Double
 @param key <#key description#>
 @param value <#value description#>
 */
void saveDouble(NSString* key,double value)
{
    getUserDefaults();
    [userDefaults setDouble:value forKey:key];
    [userDefaults synchronize];
}


/**
 <#Description#> 保存Date
 @param key <#key description#>
 @param value <#value description#>
 */
void saveDate(NSString* key,NSDate* value)
{
    getUserDefaults();
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}


/**
 <#Description#> 保存Array
 @param key <#key description#>
 @param value <#value description#>
 */
void saveArray(NSString* key,NSArray* value)
{
    getUserDefaults();
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}


/**
 <#Description#> 保存Dictionary
 @param key <#key description#>
 @param value <#value description#>
 */
void saveDictionary(NSString* key,NSDictionary* value)
{
    getUserDefaults();
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

/**
 <#Description#> 获取String
 @param key <#key description#>
 @returns <#return value description#>
 */
NSString* getString(NSString* key)
{
    getUserDefaults();
    NSString* value=[userDefaults stringForKey:key];
    return value==nil?@"":value;
}

/**
 <#Description#>获取bool
 @param key <#key description#>
 @returns <#return value description#>
 */
bool getBool(NSString* key)
{
    getUserDefaults();
    return [userDefaults boolForKey:key];
}


/**
 <#Description#> 获取Integer
 @param key <#key description#>
 @returns <#return value description#>
 */
int getInteger(NSString* key)
{
    getUserDefaults();
    return (int)[userDefaults integerForKey:key];
}


/**
 <#Description#> 获取Float
 @param key <#key description#>
 @returns <#return value description#>
 */
float getFloat(NSString* key)
{
    getUserDefaults();
    return [userDefaults floatForKey:key];
}


/**
 <#Description#> 获取Double
 @param key <#key description#>
 @returns <#return value description#>
 */
double getDouble(NSString* key)
{
    getUserDefaults();
    return [userDefaults doubleForKey:key];
}

/**
 <#Description#> 获取Array
 @param key <#key description#>
 @returns <#return value description#>
 */
NSArray* getArray(NSString* key)
{
    getUserDefaults();
    return [userDefaults arrayForKey:key];
}

/**
 <#Description#> 获取Dictionary
 @param key <#key description#>
 @returns <#return value description#>
 */
NSDictionary* getDictionary(NSString* key)
{
    getUserDefaults();
    return [userDefaults dictionaryForKey:key];
}



/**
 Description:保存用户名
 @param userName userName description
 */
void save_UserName(NSString* userName)
{
    saveString(USER_NAME,userName);
}

/**
 <#Description#> 获取用户名
 @returns <#return value description#>
 */
NSString* user_Name()
{
    return getString(USER_NAME);
}


/**
 Description:保存用户名
 @param userName userName description
 */
void save_UserName1(NSString* userName)
{
    saveString(USER_NAME1,userName);
}

/**
 <#Description#> 获取用户名
 @returns <#return value description#>
 */
NSString* user_Name1()
{
    return getString(USER_NAME1);
}

/**
 <#Description#>保存密码
 @param userpwd <#userpwd description#>
 */
void save_UserPwd(NSString* userpwd)
{
    saveString(USER_PWD,userpwd);
}

/**
 <#Description#>获取密码
 @returns <#return value description#>
 */
NSString* user_Pwd()
{
    return getString(USER_PWD);
}

/**
 <#Description#>保存密码
 @param userpwd <#userpwd description#>
 */
void save_UserSavePwd(BOOL userpwd)
{
    saveBool(USER_SAVEPWD,userpwd);
}

/**
 <#Description#>获取是否保存密码
 @returns <#return value description#>
 */
bool is_SavePwd()
{
    return getBool(USER_SAVEPWD);
}


/**
 <#Description#>保存UserId
 @param userpwd <#userpwd description#>
 */

void save_UserId(NSString* userid)
{
    saveString(USER_ID,userid);
}

/**
 <#Description#>获取密码
 @returns <#return value description#>
 */
NSString* user_Id()
{
    return getString(USER_ID);
}

/**
 <#Description#>保存登录日期
 @param userpwd <#userpwd description#>
 */

void save_LoginDate(NSString* loginDate)
{
    saveString(LOGIN_DATE,loginDate);
}

/**
 <#Description#>获取登录日期
 @returns <#return value description#>
 */
NSString* login_date()
{
    return getString(LOGIN_DATE);
}

/**
 <#Description#>保存登录时间
 @param userpwd <#userpwd description#>
 */

void save_UpdateTime(NSString* updateTime)
{
    saveString(UPLOAD_DATETIME,updateTime);
}

/**
 <#Description#>获取登录日期
 @returns <#return value description#>
 */
NSString* update_time()
{
    return getString(UPLOAD_DATETIME);
}


/**
 <#Description#>保存首次使用
 @param userpwd <#userpwd description#>
 */
void save_Used(BOOL firstUse)
{
    saveBool(FIRST_USE,firstUse);
}

/**
 <#Description#>获取首次使用
 @returns <#return value description#>
 */
bool is_Used()
{
    return getBool(FIRST_USE);
}

/**
 <#Description#>保存首次使用
 @param userpwd <#userpwd description#>
 */
void save_NewDB(NSString* newDB)
{
    saveString(NEWDB,newDB);
}

/**
 <#Description#>获取首次使用
 @returns <#return value description#>
 */
NSString* is_NewDB()
{
    return getString(NEWDB);
}

/**
 <#Description#>保存城市
 @param userpwd <#userpwd description#>
 */

void save_City(NSString* city)
{
    saveString(USER_CITY,city);
}

/**
 <#Description#>获取城市
 @returns <#return value description#>
 */
NSString* user_City()
{
    return getString(USER_CITY);
}


void save_Sales(NSString* sales)
{
    saveString(SALES,sales);
}


NSString* user_Sales()
{
    return getString(SALES);
}


void save_ClientCode(NSString* clientCode)
{
    saveString(CLIENTCODE,clientCode);
}


NSString* clientCode()
{
    return getString(CLIENTCODE);
}

void save_StartWorkTime(NSString* worktime)
{
    saveString(STARTWORKTIME,worktime);
}


NSString* startWorkTime()
{
    return getString(STARTWORKTIME);
}

void save_EndWorkTime(NSString* worktime)
{
    saveString(ENDWORKTIME,worktime);
}


NSString* endWorkTime()
{
    return getString(ENDWORKTIME);
}

void save_ClientCode1(NSString* cliencode)
{
    saveString(CLIENTCODE1,cliencode);
}


NSString* clientCode1()
{
    return getString(CLIENTCODE1);
}

