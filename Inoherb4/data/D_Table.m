//
//  D_Table.m
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "D_Table.h"


@implementation D_Table

//D_Table* mInstance;

@synthesize tableName,fieldList;

-(void)addField:(D_TableField *)field
{
    if (fieldList==nil) {
        self.fieldList=[[NSMutableArray alloc] init];
    }
    [self.fieldList addObject:field];
}

- (id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

@end
