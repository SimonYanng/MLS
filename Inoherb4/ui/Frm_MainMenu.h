//
//  Frm_MainMenu.h
//  Inoherb
//
//  Created by Bruce on 15/3/26.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_Bottom.h"

#import "F_Delegate.h"
#import "C_ViewHDClientList.h"
#import "C_ViewHocList.h"
#import "C_ClientInfo.h"
@interface Frm_MainMenu : UIViewController<UITableViewDataSource,UITableViewDelegate,delegatebottom,delegateRequest,UIGestureRecognizerDelegate,delegate_clientInfo>

@end
