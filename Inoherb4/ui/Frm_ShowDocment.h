//
//  Frm_ShowDocment.h
//  SFA1
//
//  Created by Ren Yong on 14-4-15.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TCBlobDownload.h"
#import "TCBlobDownloadManager.h"

@interface Frm_ShowDocment : UIViewController<UITableViewDataSource,UITableViewDelegate,TCBlobDownloadDelegate,UIDocumentInteractionControllerDelegate>

@property (nonatomic , unsafe_unretained) TCBlobDownloadManager *sharedDownloadManager;

@end
