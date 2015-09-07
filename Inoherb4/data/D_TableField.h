//
//  D_TableItem.h
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface D_TableField : NSObject

@property(nonatomic,copy)NSString* fieldName;
@property(nonatomic,assign)int fieldType;

@property(nonatomic,assign)BOOL isNULL;
@property(nonatomic,assign)BOOL isDownLoad;
@property(nonatomic,assign)BOOL isUnique;
@property(nonatomic,assign)BOOL isUpload;

-(id)init;
@end
