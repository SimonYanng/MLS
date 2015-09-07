//
//  Frm_Menu1.h
//  SFA1
//
//  Created by Ren Yong on 14-4-9.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
//#import <TCBlobDownload/TCBlobDownloadManager.h>
#import "TCBlobDownload.h"
#import "TCBlobDownloadManager.h"
#import "C_MenuCell.h"

@interface Frm_Menu1 : UIViewController<UITableViewDelegate,UITableViewDataSource,delegateRequest,TCBlobDownloadDelegate,menuButtonDelegate,UIAlertViewDelegate>

@property (nonatomic , unsafe_unretained) TCBlobDownloadManager *sharedDownloadManager;

@end
