//
//  Frm_PlanList.h
//  SFA1
//
//  Created by Ren Yong on 14-4-10.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
#import "C_PickView.h"
#import "C_Filter.h"
@interface Frm_PlanList : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,delegateView,pickerDelegate,delegate_filter>
-(id)initWithDate:(NSString*)callDate;
@end
