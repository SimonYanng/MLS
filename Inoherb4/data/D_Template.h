//
//  D_Template.h
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "D_Panel.h"

#define PANEL_PANEL @"panel"
#define PANEL_TABLE @"table"

@interface D_Template : NSObject

@property(nonatomic,copy)NSString* type;
@property(nonatomic,assign)int onlyType;

@property(nonatomic,copy)NSString* version;
@property(nonatomic,copy)NSString* name;

@property(nonatomic,copy)NSString* templateId;
@property(nonatomic,copy)NSString* groupId;

@property(nonatomic,retain)NSMutableArray* panelList;

@property(nonatomic,retain)NSMutableArray* buttonList;

@property(nonatomic,assign)BOOL isMustPhoto;
@property(nonatomic,assign)BOOL isMustComplete;

@property(nonatomic,assign)int inputType;

//@property(nonatomic,retain)NSMutableArray* fieldList;

//-(D_Template*) newInstance;

-(id)init;
-(void)addPanel:(D_Panel*)panel;
-(void)addItem:(D_UIItem *)item;
-(int)panelCount;
-(D_Panel*)panelAt:(int)index;
-(D_Panel*)product_PanelAt:(int)index;
-(NSMutableArray*)panelList;//类型为panel列表
-(NSMutableArray*)productList;//类型为table列表
-(D_Panel*)panel_PanelAt:(int)index;
-(int)allPanelCount;
-(int)productPanelCount;

-(void)addButtonList:(NSMutableDictionary *)button;
-(NSMutableDictionary*)buttonAt:(int)index;
-(NSMutableArray*)buttonList;
@end
