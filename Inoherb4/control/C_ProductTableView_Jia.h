//
//  C_ProductTableView_Jia.h
//  JahwaS
//
//  Created by westtalkzzz on 15/7/22.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_Panel.h"
#import "F_Delegate.h"

@interface C_ProductTableView_Jia : UIView<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSObject<delegateView>* _delegate;
}

@property(nonatomic, retain) NSMutableArray* productList;
@property(nonatomic, retain) D_Panel* productPanel;
@property(nonatomic, assign) BOOL keyboardShow;

-(id)init:(CGRect)frame panel:(D_Panel *)panel productList:(NSMutableArray*)list delegate:(NSObject<delegateView> *) delegate;
-(void)refreshData:(NSMutableArray*)list;
-(void)dismiss;
-(void)reloadData;
-(NSMutableArray*)haveValueList;

@end
