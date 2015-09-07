//
//  Frm_ShowDataList.h
//  UzroBA
//
//  Created by Bruce on 15/3/25.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_Panel.h"
#import "F_Delegate.h"
#import "C_ViewButtonList.h"
@interface Frm_ShowDataList : UIViewController<UITableViewDataSource,UITableViewDelegate,delegateRequest,buttonDelegate>
{
    UITableView *_tableView;
    NSMutableDictionary* queryData;
    RequestType syncType;
   
}


@property(nonatomic, retain) NSMutableArray* dataList;
@property(nonatomic, retain) D_Panel* dataPanel;
@property(nonatomic, assign) int  showType;

- (id)initWithFrame:(CGRect)frame type:(int)type;
- (id)initWithFrame:(CGRect)frame type:(int)type data:(NSMutableDictionary *)data;
@end
