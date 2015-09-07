//
//  NSMutableArray+Tool.m
//  SFA1
//
//  Created by Ren Yong on 14-4-9.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "NSMutableArray+Tool.h"

@implementation NSMutableArray (Tool)

-(BOOL)isEmpty
{
    if(!self||[self isKindOfClass:[NSNull class]]||[self count]<=0)
        return YES;
    return NO;
}

-(NSUInteger)count
{
    if([self isEmpty])
        return 0;
    return [self count];
}

-(void) addDict:(NSMutableDictionary*) dict
{
    [self addObject:dict];
}

-(NSMutableDictionary*) dictAt:(NSUInteger)index
{
    if ([[self objectAtIndex:index] isKindOfClass:[NSMutableDictionary class]])
        return (NSMutableDictionary*)[self objectAtIndex:index];
    else
        return nil;
}

-(void) addArray:(NSMutableArray*) array
{
    [self addObject:array];
}

-(NSMutableArray*)  arrayAt:(NSUInteger)index
{
    if ([[self objectAtIndex:index] isKindOfClass:[NSMutableArray class]])
        return (NSMutableArray*)[self objectAtIndex:index];
    else
        return nil;
}

-(void) addUIItem:(D_UIItem*)item
{
    [self addObject:item];
}

-(D_UIItem*) uiItemAt:(NSUInteger)index
{
    if ([[self objectAtIndex:index] isKindOfClass:[D_UIItem class]])
        return (D_UIItem*)[self objectAtIndex:index];
    else
        return nil;
}

-(void) addTable:(D_Table*)table
{
    [self addObject:table];
}

-(D_Table*) tableAt:(NSUInteger)index
{
    if ([[self objectAtIndex:index] isKindOfClass:[D_Table class]])
        return (D_Table*)[self objectAtIndex:index];
    else
        return nil;
}


-(void) addButton:(C_Button*)button
{
        [self addObject:button];
}

-(C_Button*) buttonAt:(NSUInteger)index
{
    if ([[self objectAtIndex:index] isKindOfClass:[C_Button class]])
        return (C_Button*)[self objectAtIndex:index];
    else
        return nil;
}

-(void) addTempGroup:(D_TempGroup*)tempGroup
{
    [self addObject:tempGroup];
}

-(D_TempGroup*) tempGroupAt:(NSUInteger)index
{
    if ([[self objectAtIndex:index] isKindOfClass:[D_TempGroup class]])
        return (D_TempGroup*)[self objectAtIndex:index];
    else
        return nil;
}


-(void) addPanel:(D_Panel*)panel
{
    [self addObject:panel];
}

-(D_Panel*) panelAt:(NSUInteger)index
{
    if ([[self objectAtIndex:index] isKindOfClass:[D_Panel class]])
        return (D_Panel*)[self objectAtIndex:index];
    else
        return nil;
}


-(void) addTemplate:(D_Template*)panel
{
    [self addObject:panel];
}

-(D_Template*) templateAt:(NSUInteger)index
{
    if ([[self objectAtIndex:index] isKindOfClass:[D_Template class]])
        return (D_Template*)[self objectAtIndex:index];
    else
        return nil;
}

-(void) addString:(NSString*)string
{
    [self addObject:string];
}

-(NSString*) stringAt:(NSUInteger)index
{
    if ([[self objectAtIndex:index] isKindOfClass:[NSString class]])
        return (NSString*)[self objectAtIndex:index];
    else
        return nil;
}


@end
