//
//  D_TableItem.m
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "D_TableField.h"

@interface D_TableField ()
{
    
}
@end

@implementation D_TableField
@synthesize fieldName,fieldType,isDownLoad,isNULL,isUnique,isUpload;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.isNULL=YES;
        self.isDownLoad=YES;
        self.isUnique=NO;
        self.isUpload=NO;
    }
    return self;
}
@end


