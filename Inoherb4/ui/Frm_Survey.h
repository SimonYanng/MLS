//
//  Frm_Survey.h
//  Inoherb
//
//  Created by Bruce on 15/4/10.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
#import "C_Bottom.h"
#import "C_ProductTableView.h"
#import "D_Report.h"
#import "C_TempView.h"
#import "C_PickView.h"
#import "C_ViewButtonList.h"
@interface Frm_Survey : UIViewController<delegatebottom,UIImagePickerControllerDelegate,UINavigationControllerDelegate,delegateRequest,delegateView,pickerDelegate,buttonDelegate,UIAlertViewDelegate>
-(id)init:(NSMutableDictionary*)data;
@end
