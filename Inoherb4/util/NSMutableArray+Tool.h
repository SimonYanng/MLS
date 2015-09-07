//
//  NSMutableArray+Tool.h
//  SFA1
//
//  Created by Ren Yong on 14-4-9.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D_UIItem.h"
#import "D_Table.h"
#import "D_TempGroup.h"
#import "D_Panel.h"
#import "D_Template.h"
#import "C_Button.h"
@interface NSMutableArray (Tool)

-(void) addDict:(NSMutableDictionary*) dict;
-(NSMutableDictionary*) dictAt:(NSUInteger)index;

-(BOOL)isEmpty;

-(void) addUIItem:(D_UIItem*)item;
-(D_UIItem*) uiItemAt:(NSUInteger)index;

-(NSUInteger)count;

-(D_Table*) tableAt:(NSUInteger)index;
-(void) addTable:(D_Table*)table;
-(void) addTempGroup:(D_TempGroup*)tempGroup;
-(D_TempGroup*) tempGroupAt:(NSUInteger)index;

-(D_Panel*) panelAt:(NSUInteger)index;
-(void) addPanel:(D_Panel*)panel;

-(D_Template*) templateAt:(NSUInteger)index;
-(void) addTemplate:(D_Template*)panel;

-(void) addButton:(C_Button*)button;
-(C_Button*) buttonAt:(NSUInteger)index;

-(void) addString:(NSString*)string;
-(NSString*) stringAt:(NSUInteger)index;

-(void) addArray:(NSMutableArray*) array;
-(NSMutableArray*)  arrayAt:(NSUInteger)index;

@end
