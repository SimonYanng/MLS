//
//  D_Panel.m
//  SFA
//
//  Created by Ren Yong on 13-11-13.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "D_Panel.h"
#import "NSMutableArray+Tool.h"

@implementation D_Panel

@synthesize itemList, panelId,type,name,showTitle,isOperation,intputType;

-(id)init
{
    self=[super init];
    if(self)
    {
        self.itemList=[[NSMutableArray alloc]init];
        self.isOperation=NO;
        self.showTitle=YES;
        self.intputType=0;
    }
    return self;
}

//-(void)initItemList
//{
//    if(!self.itemList)
//        self.itemList=[[D_ArrayList alloc]init];
//}

-(void) addItem:(D_UIItem*)item
{
//    [self initItemList];
    [self.itemList addUIItem:item];
}

-(D_UIItem*)itemAt:(int)index
{
    return [itemList uiItemAt:index];
}

-(int)itemCount
{
    return [itemList count];
}

@end
