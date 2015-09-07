//
//  Frm_SetPlan.h
//  SFA1
//
//  Created by Ren Yong on 14-4-10.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
#import "C_PickView.h"
@interface Frm_SetPlan : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,delegateView,pickerDelegate,delegateRequest>
-(id)init;
@end
