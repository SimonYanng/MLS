//
//  Frm_Menu.h
//  Inoherb
//
//  Created by Bruce on 15/3/27.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_Bottom.h"
#import "C_CheckPhoto.h"
#import "F_Delegate.h"
#import "C_ViewButtonList.h"
@interface Frm_Menu : UIViewController<UITableViewDataSource,UITableViewDelegate,delegatebottom,UIGestureRecognizerDelegate,delegateView,buttonDelegate>

-(id)init:(NSMutableDictionary*)data;
@end
