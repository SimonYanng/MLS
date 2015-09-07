//
//  Frm_ReportHistoryDetail.h
//  JahwaS
//
//  Created by Bruce on 15/7/9.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
@interface Frm_ReportHistoryDetail : UIViewController<UITableViewDataSource,UITableViewDelegate,delegateRequest>

-(id)init:(NSMutableDictionary*)data;
@end
