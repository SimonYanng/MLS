//
//  D_UIItem.m
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "D_UIItem.h"
#import "F_Color.h"

@implementation D_UIItem

@synthesize caption,dataKey,dicId,controlType,maxLenth,isSecureTextEntry,
verifyType,isShowCaption,superViewColor,lableWidth,placeholder,containerId,textAlignment,isMustInput,maxValue,minValue,maxDate,minDate,operationList,orientation,itemlId,isSurverItem;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.isShowCaption=YES;
        self.verifyType=DEFAULT;
        self.isSecureTextEntry=NO;
        
        self.lableWidth=30;
        self.placeholder=@"";
        self.textAlignment=NSTextAlignmentRight;
        self.isMustInput=NO;
        self.maxValue=99999999;
        self.maxLenth=255;
        self.minValue=0;
        self.orientation=HORIZONTAL;
        self.itemlId=@"";
        self.isSurverItem=NO;
        self.isEnable=YES;
    }
    return self;
}

-(void)addMethod:(D_Operation*)operation
{
    if(!operationList)
       self.operationList=[[NSMutableArray alloc] init];
    [self.operationList addObject:operation];
}

-(D_Operation*) operationAt:(int) index
{
    if (self.operationList!=nil&&index<[self operationSize])
        return [self.operationList objectAtIndex:index];
    return nil;
}

-(int) operationSize
{
    return self.operationList==nil?0:(int)self.operationList.count;
}

@end
