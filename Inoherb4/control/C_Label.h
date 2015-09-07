//
//  C_Label.h
//  SFA
//
//  Created by Ren Yong on 13-10-21.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_UIItem.h"
#import "NSMutableDictionary+Tool.h"

@interface C_Label : UILabel


@property (nonatomic,retain)NSMutableAttributedString *attString;
@property (nonatomic,assign)BOOL isStrike;

@property (nonatomic,retain)NSMutableDictionary *dataField;
@property (nonatomic,retain)D_UIItem *uiItem;

- (id)initWithFrame:(CGRect)frame label:(NSString*)label;
- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data;

- (id)initWithFrame:(CGRect)frame data:(NSMutableDictionary*)data item:(D_UIItem*)item;

//- (id)initWithFrame:(CGRect)frame label:(NSString*)label isStrike:(BOOL)isStrike;

//- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length;
//- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length;
@end
