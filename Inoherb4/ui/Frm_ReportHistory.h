//
//  Frm_ReportHistory.h
//  JahwaS
//
//  Created by Bruce on 15/7/9.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
#import "C_Filter.h"
@interface Frm_ReportHistory : UIViewController<UITableViewDataSource,UITableViewDelegate,delegateRequest,delegate_filter>
-(id)init;
@end
