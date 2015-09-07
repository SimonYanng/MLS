//
//  F_Phone.h
//  SFA
//
//  Created by Ren Yong on 13-11-13.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isConnecting();
int statusBarHeight();
void setScreenW(int w);
int screenW();

void setScreenH(int h);
int screenH();
void callNumber(NSString*number, UIView* view);

double availableMemory();