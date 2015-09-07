//
//  com_ryAppDelegate.h
//  Shequ
//
//  Created by Ren Yong on 14-1-7.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (AppDelegate *)shareAppDelegate;
@property (strong, nonatomic) UIWindow *window;

@end
