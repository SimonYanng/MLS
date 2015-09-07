//
//  F_DBConfig.h
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D_Table.h"


#import "Constants.h"



NSMutableArray* table_List();

D_Table* get_table(NSString* name);
//D_Table* table_Product();
//D_Table* table_Template();
//D_Table* table_GroupDistr();

D_Table* table_CallReport();
D_Table* table_CallDetail();
D_Table* table_CallPhoto();

D_Table* table_DPList();