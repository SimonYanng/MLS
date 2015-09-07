//
//  F_Tool.h
//  SFA
//
//  Created by Ren Yong on 13-11-13.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isEmpty(NSString* value);
NSString* encodeBase64Data(NSData *data);
UIImage *scaleToSize(UIImage *img ,CGSize size);

NSString* myUUID();