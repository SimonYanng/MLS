//
//  Request.h
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Constants.h"
#import "D_Report.h"

@interface Request : NSObject

- (NSString *)requestSoapString:(RequestType)type field:(NSMutableDictionary *)field;
- (NSString *)uploadSoapString:(RequestType)type report:(D_Report *)report;
- (NSString *)uploadMsgSoapString:(D_Report *)report;
@end
