//
//  F_Date.h
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>


NSString* today();
NSString* now();
NSString* nowToWeb();

NSDate* string2Date(NSString* date);

NSString* thisMohth();
NSMutableArray* weekBeginAndEnd(NSString* date);
NSString* lastAndnextWeek(NSString* date,int type);
NSString* diffDate(NSString* date,int dateDiff);
NSDate* string2Time(NSString* date);

NSDate* string2DateTime(NSString* date);


NSString* diffDateTime(NSString* date,int dateDiff);