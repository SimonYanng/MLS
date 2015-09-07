//
//  C_TextField.h
//  SFA
//
//  Created by Ren Yong on 13-10-21.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_UIItem.h"
#import "F_Delegate.h"
@interface C_TextField : UITextField

//D_Field* _data;
//D_UIItem* _item;
@property(nonatomic, retain) D_UIItem* uiItem;
@property(nonatomic, retain) NSMutableDictionary* field;

- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data;

-(void)setData:(NSString*) result;
@end
