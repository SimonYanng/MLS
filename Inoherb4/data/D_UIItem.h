//
//  D_UIItem.h
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "D_Operation.h"

@interface D_UIItem : NSObject

@property(nonatomic,copy)NSString* caption;
@property(nonatomic,copy)NSString* dataKey;
@property(nonatomic,copy)NSString* dicId;
@property(nonatomic,assign)int controlType;

@property(nonatomic,assign)int verifyType;

@property(nonatomic,assign)int maxLenth;
@property(nonatomic,assign)int maxValue;
@property(nonatomic,assign)int minValue;

@property(nonatomic,copy)NSString* maxDate;
@property(nonatomic,copy)NSString* minDate;

@property(nonatomic,assign)BOOL isSecureTextEntry;
@property(nonatomic,assign)BOOL isShowCaption;

@property(nonatomic,copy)UIColor* superViewColor;
@property(nonatomic,copy)UIFont* captionFont;

@property(nonatomic,assign)int lableWidth;//标题宽度百分比

@property(nonatomic,copy)NSString* placeholder;
@property(nonatomic,copy)NSString* containerId;
@property(nonatomic,assign)int textAlignment;

@property(nonatomic,assign)BOOL isMustInput;

@property(nonatomic,assign)int orientation;
@property(nonatomic,copy)NSString* itemlId;

@property(nonatomic,retain)NSMutableArray* operationList;//计算数据

@property(nonatomic,assign)BOOL isSurverItem;

@property(nonatomic,assign)BOOL isEnable;

- (id)init;
-(void)addMethod:(D_Operation*)operation;
-(D_Operation*) operationAt:(int) index;
-(int) operationSize;
@end


