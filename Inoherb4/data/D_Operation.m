//
//  D_Operation.m
//  Inoherb4
//
//  Created by Ren Yong on 14-2-14.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "D_Operation.h"

@implementation D_Operation
@synthesize dataKey,method,resultDatakey,multiple;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.multiple=1;
    }
    return self;
}
@end;
