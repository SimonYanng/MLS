//
//  Frm_Rpt.h
//  SFA
//
//  Created by Ren Yong on 13-11-13.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
#import "C_Bottom.h"

#import "C_ProductTableView.h"
//#import "C_ProductTableView_Jia.h"


#import "D_Report.h"
#import "C_TempView.h"
#import "C_PickView.h"
#import "C_ViewButtonList.h"
#import "PIDrawerViewController.h"
#import "C_Filter.h"
@interface Frm_Rpt : UIViewController <delegatebottom,UIImagePickerControllerDelegate,UINavigationControllerDelegate,delegateRequest,delegateView,pickerDelegate,buttonDelegate,UIAlertViewDelegate,UIImageMergeControllerDelegate,delegate_filter,delegateProductView>

-(id)init:(NSMutableDictionary*)data;

@end
