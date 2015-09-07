//
//  F_Request.m
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "F_Request.h"
#import "Request.h"


NSString* soapRequest(RequestType type, NSMutableDictionary* field)
{
    return [[[Request alloc]init]requestSoapString:type field:field];
}

NSString* soapUpload(RequestType type, D_Report* report)
{
    if(type==UPLOAD_MSG)
        return [[[Request alloc]init]uploadMsgSoapString:report];
    else
        return [[[Request alloc]init]uploadSoapString:type report:report];
}

