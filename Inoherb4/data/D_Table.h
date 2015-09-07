//
//  D_Table.h
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D_TableField.h"

@interface D_Table : NSObject

@property(nonatomic,copy)NSString* tableName;
@property(nonatomic,retain)NSMutableArray* fieldList;

-(id)init;
-(void)addField:(D_TableField *)field;
@end
