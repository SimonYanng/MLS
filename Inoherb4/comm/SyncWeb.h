//
//  SyncWeb.h
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "F_Delegate.h"
#import "D_Report.h"

@interface SyncWeb : NSObject <NSXMLParserDelegate>

+(SyncWeb*) instance;
- (void)syncWeb:(RequestType)type field:(NSMutableDictionary*)field delegate:(NSObject<delegateRequest>*) delegate;
- (void)syncWeb:(RequestType)type report:(D_Report*)report delegate:(NSObject<delegateRequest>*) delegate;
@end
