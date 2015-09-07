//
//  D_ArrayList.h
//  SFA
//
//  Created by Ren Yong on 13-10-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "D_Field.h"
#import "D_Table.h"
#import "D_UIItem.h"
//#import "D_TempGroup.h"

@interface D_ArrayList : NSObject
@property(nonatomic,retain)NSMutableArray* list;


//-(D_ArrayList*) newInstance;
-(id)init;
-(int)size;
-(NSObject*) objectAt:(int) index;
-(D_Table*) tableAt:(int) index;
-(D_Field*) fieldAt:(int) index;
-(D_UIItem*) uiItemAt:(int) index;

-(void) add:(NSObject*) object;
//-(void) addField:(D_Field*) object;

//-(D_TempGroup*) tempGroupAt:(int) index;


@end
