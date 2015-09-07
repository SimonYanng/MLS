//
//  F_File.h
//  SFA
//
//  Created by Ren Yong on 13-11-13.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isFileExist(NSString* path);
void creatPath(NSString* path);
NSString* dbPath();
NSString* filePath();