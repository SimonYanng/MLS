//
//  F_Alert.m
//  SFA
//
//  Created by Ren Yong on 13-10-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "F_Alert.h"
#import "C_Progress.h"
#import "F_Phone.h"
#import "C_Toast.h"
UIAlertView* alertView;
C_Progress* progress;

void stop()
{
    if(alertView)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:NO];
        alertView=nil;
    }
}

void alert_showErrMsg(NSString* msg)
{
    stop();
    alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

void alert_showInfoMsg(NSString* msg)
{
    stop();
    alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}


void stopProgress()
{
    if (progress)
    {
        [progress removeFromSuperview];
        progress = nil;
    }
}

void pro_showInfoMsg(NSString* msg)
{
    stopProgress();
    progress = [[C_Progress alloc] initWithFrame:CGRectMake(0, 0, screenW(), screenH()) msg:msg];
    [progress show];
}


void toast_showInfoMsg(NSString* msg,CGFloat bottomOffset)
{
    [C_Toast showWithText:msg
             bottomOffset:bottomOffset];
}

