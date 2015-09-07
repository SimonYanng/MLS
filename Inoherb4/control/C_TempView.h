//
//  C_TempView.h
//  SFA
//
//  Created by Ren Yong on 13-11-21.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_Delegate.h"
#import "D_Report.h"

@interface C_TempView : UIView <UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, retain) NSMutableArray* list;
@property(nonatomic, retain) NSMutableDictionary* field;
@property(nonatomic, assign) BOOL keyboardShow;

- (id)init:(CGRect)frame panelList:(NSMutableArray *)panelList data:(NSMutableDictionary*)data delegate:(NSObject<delegateView> *) delegate;
- (id)init:(CGRect)frame panelList:(NSMutableArray *)panelList rpt:(D_Report*)rpt delegate:(NSObject<delegateView> *) delegate;
-(void)dismiss;

-(void)reloadData;
@end
