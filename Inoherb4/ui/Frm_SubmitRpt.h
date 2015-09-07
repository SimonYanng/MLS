//
//  Frm_SubmitRpt.h
//  Inoherb
//
//  Created by Bruce on 15/4/1.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
#import "C_Bottom.h"
#import "C_ProductTableView.h"
#import "D_Report.h"
#import "C_TempView.h"
#import "C_PickView.h"

@interface Frm_SubmitRpt : UIViewController<delegatebottom,UIImagePickerControllerDelegate,UINavigationControllerDelegate,delegateRequest,delegateView,pickerDelegate>

-(id)init:(NSMutableDictionary*)data;
@end
