//
//  F_Request.h
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "D_Report.h"

NSString* soapRequest(RequestType type, NSMutableDictionary* field);

NSString* soapUpload(RequestType type, D_Report* report);
