//
//  F_Alert.h
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

void alert_showErrMsg(NSString* msg);
void alert_showInfoMsg(NSString* msg);

void pro_showInfoMsg(NSString* msg);
void stopProgress();
void toast_showInfoMsg(NSString* msg,CGFloat bottomOffset);