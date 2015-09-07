//
//  D_Operation.h
//  Inoherb4
//
//  Created by Ren Yong on 14-2-14.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface D_Operation : NSObject

@property(nonatomic,assign)NSString* dataKey;
@property(nonatomic,assign)int method;
@property(nonatomic,assign)NSString* resultDatakey;

@property(nonatomic,assign)int multiple;

- (id)init;
@end
