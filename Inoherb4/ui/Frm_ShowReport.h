//
//  Frm_ShowReport.h
//  JahwaS
//
//  Created by Bruce on 15/7/10.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
#import "C_Bottom.h"
#import "C_ProductTableView.h"
#import "D_Report.h"
#import "C_TempView.h"
#import "C_PickView.h"
@interface Frm_ShowReport : UIViewController<delegatebottom,UIImagePickerControllerDelegate,UINavigationControllerDelegate,delegateRequest>

-(id)init:(NSMutableDictionary*)data;

@end
