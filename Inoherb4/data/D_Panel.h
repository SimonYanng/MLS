//
//  D_Panel.h
//  SFA
//
//  Created by Ren Yong on 13-11-13.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D_UIItem.h"

@interface D_Panel : NSObject
@property(nonatomic,retain)NSMutableArray* itemList;
@property(nonatomic,copy)NSString* type;
@property(nonatomic,copy)NSString* panelId;
@property(nonatomic,copy)NSString* name;

@property(nonatomic,assign)BOOL showTitle;

@property(nonatomic,assign)BOOL isOperation;

@property(nonatomic,assign)int  intputType;
//-(D_Panel*) newInstance;

-(id)init;

-(void) addItem:(D_UIItem*)item;

-(int)itemCount;
-(D_UIItem*)itemAt:(int)index;
@end
