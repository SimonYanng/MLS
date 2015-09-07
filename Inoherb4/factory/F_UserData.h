//
//  F_UserData.h
//  SFA
//
//  Created by Ren Yong on 13-10-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>


void save_UserName(NSString* userName);

void save_UserName1(NSString* userName);
void save_UserPwd(NSString* userPwd);
void save_UserSavePwd(BOOL userSavePwd);
void save_UserId(NSString* userid);

void save_LoginDate(NSString* loginDate);
void save_Used(BOOL firstUse);
void save_UpdateTime(NSString* updateTime);
//void save_UserName(NSString* userName);

void save_ClientCode(NSString* clientCode);

void save_NewDB(NSString* newDB);
void save_City(NSString* city);

void save_Sales(NSString* sales);

void save_StartWorkTime(NSString* worktime);
void save_EndWorkTime(NSString* worktime);

void save_ClientCode1(NSString* cliencode);

NSString* user_Name();
NSString* user_Name1();
NSString* user_Pwd();
bool is_SavePwd();
NSString* user_Id();
NSString* login_date();
bool is_Used();
NSString* is_NewDB();
NSString* update_time();

NSString* user_City();
NSString* user_Sales();
NSString* clientCode();

NSString* startWorkTime();
NSString* endWorkTime();
NSString* clientCode1();



