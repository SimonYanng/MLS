//
//  D_Template.m
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "D_Template.h"
#import "NSMutableArray+Tool.h"
#import "NSMutableDictionary+Tool.h"

@interface D_Template ()
{
    NSMutableArray* mPanelList;
    NSMutableArray* mTableList;
}
@end

@implementation D_Template

@synthesize panelList,type,version,name,templateId,groupId,buttonList,isMustPhoto,onlyType,inputType,isMustComplete;

-(id)init
{
    self=[super init];
    if(self)
    {
        self.isMustPhoto=NO;
        self.inputType=0;
    }
    return self;
}

-(void)addButtonList:(NSMutableDictionary *)button
{
    if (buttonList==nil) {
        self.buttonList=[[NSMutableArray alloc] init];
    }
    [buttonList addDict:button];
}

-(NSMutableDictionary*)buttonAt:(int)index
{
    return [buttonList dictAt:index];
}


-(NSMutableArray*)buttonList
{
    return buttonList;
}


-(void)addPanel:(D_Panel *)panel
{
    if (panelList==nil) {
        self.panelList=[[NSMutableArray alloc] init];
    }
    [panelList addPanel:panel];
}

-(void)addItem:(D_UIItem *)item
{
    D_Panel* panel;
    for (int i=0;i<[self allPanelCount];i++) {
        panel=[self panelAt:i];
        if ([panel.panelId isEqualToString:item.containerId]) {
            [panel addItem:item];
            break;
        }
    }
}

-(D_Panel*)panelAt:(int)index
{
    return [panelList panelAt:index];
}

-(NSMutableArray*)panelList
{
    if(!mPanelList)
    {
        mPanelList=[[NSMutableArray alloc] init];
        if(panelList)
        {
            D_Panel* panel;
            for (int i=0;i<[self allPanelCount];i++) {
                panel=[self panelAt:i];
                if ([panel.type isEqualToString:PANEL_PANEL])
                {
                    [mPanelList addPanel:panel];
                }
            }
        }
    }
    return mPanelList;
}

-(NSMutableArray*)productList
{
    if(!mTableList)
    {
        mTableList=[[NSMutableArray alloc] init];
        if(mTableList)
        {
            D_Panel* panel;
            for (int i=0;i<[self allPanelCount];i++) {
                panel=[self panelAt:i];
                NSLog(@"类型----------------%@",panel.type );
                if ([panel.type isEqualToString:PANEL_TABLE])
                {
                     NSLog(@"类型-------%@",panel.type );
                    [mTableList addPanel:panel];
                }
            }
        }
    }
    return mTableList;
}


-(D_Panel*)panel_PanelAt:(int)index
{
    if([self panelCount]==0)
        return nil;
    return [mPanelList panelAt:index];
}

-(D_Panel*)product_PanelAt:(int)index
{
    if([self productPanelCount]==0)
        return nil;
    return [mTableList panelAt:index];
}

-(int)panelCount
{
    [self panelList];
    return mPanelList==nil?0:[mPanelList count];
}

-(int)productPanelCount
{
    [self productList];
    return mTableList==nil?0:[mTableList count];
}

-(int)allPanelCount
{
    return panelList==nil?0:[panelList count];
}

@end
