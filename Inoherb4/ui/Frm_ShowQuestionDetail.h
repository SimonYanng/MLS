//
//  Frm_ShowQuestionDetail.h
//  JahwaS
//
//  Created by Bruce on 15/7/10.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_ViewButtonList.h"
#import "F_Delegate.h"
#import "C_Filter.h"
@interface Frm_ShowQuestionDetail : UIViewController<UITableViewDataSource,UITableViewDelegate,buttonDelegate,delegateRequest,delegate_filter>

-(id)init:(NSMutableDictionary*)data;

@end
