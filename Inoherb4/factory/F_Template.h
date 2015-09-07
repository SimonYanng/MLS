//
//  F_Template.h
//  SFA
//
//  Created by Ren Yong on 13-10-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D_Template.h"
#import "Constants.h"
int labelW();

D_Template* temp_Login();

D_Template* temp_ById(NSString* tempId,NSString* name);

//D_Template* temp_XLSB();


D_Template* temp_Pbjh();

D_Template* temp_QJ();

D_Template* temp_Task();
D_Template* temp_Message();

NSMutableArray* tempGroup_sales();
NSMutableArray* tempGroup_task();

D_Template* temp_CheckIn();
D_Template* temp_CheckOut();

D_Template* temp_JGYC();

D_Template* temp_EditPwd();

D_Template* temp_StartWork();
D_Template* temp_StopWork();

D_Template* temp_ZCLTemplate();

D_Template* temp_SYXCLTemplate();
D_Template* temp_CXCLTemplate();

D_Template* temp_HDZXTemplate();
D_Template* temp_D2CLYC();
D_Template* temp_RYJCTemplate();
D_Template* temp_XLYBTemplate();

D_Template* temp_JP();
D_Template* temp_XP();
