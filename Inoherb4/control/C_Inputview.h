//
//  C_HocView.h
//  SFA
//
//  Created by Ren Yong on 13-12-3.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "D_ArrayList.h"
#import "D_Panel.h"
#import "F_Delegate.h"

@interface C_InputView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property(nonatomic, retain) D_Panel* panel;
@property(nonatomic, retain) NSMutableDictionary* field;
@property(nonatomic, assign) BOOL keyboardShow;

@property(nonatomic,weak)NSObject<delegateView>* delegate_View;

- (id)initWithFrame:(CGRect)frame panel:(D_Panel*)panel field:(NSMutableDictionary*)field;

-(void)reloadData;
-(void)dismiss;
@end
