//
//  Frm_InputListDetail.h
//  ManonYw
//
//  Created by Bruce on 15/8/8.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
#import "C_Bottom.h"
#import "D_Panel.h"
#import "C_InputView.h"
#import "C_PickView.h"
@interface Frm_InputListDetail : UIViewController<delegateView,pickerDelegate>
-(id)initWith:(NSMutableDictionary*)productInfo panel:(D_Panel*)panel;
@end
