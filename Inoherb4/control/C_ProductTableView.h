//
//  C_ProductTableView.h
//  Inoherb4
//
//  Created by Ren Yong on 14-2-17.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_Panel.h"
#import "F_Delegate.h"
#import "D_Report.h"

@protocol delegateProductView
/**
 [""]	<#Description#>点击填写产品
 [""]	@param success <#success description#>
 [""]	@returns <#return value description#>
 [""] */
- (void)delegate_productClick:(NSMutableDictionary*)product panel:(D_Panel*)panel;
@end

@interface C_ProductTableView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
        NSObject<delegateView>* _delegate;
    D_Report* _report;
        UIScrollView*_scrollView;
}

@property(nonatomic, retain) NSMutableArray* productList;
@property(nonatomic, retain) D_Panel* productPanel;
@property(nonatomic, assign) BOOL keyboardShow;

- (id)init:(CGRect)frame panel:(D_Panel *)panel productList:(NSMutableArray*)list delegate:(NSObject<delegateView> *) delegate report:(D_Report*)report;
//- (id)init:(CGRect)frame panel:(D_Panel *)panel productList:(D_ArrayList*)productList delegate:(NSObject<delegateView> *) delegate;
-(void)refreshData:(NSMutableArray*)list;
-(void)dismiss;
-(void)reloadData;
-(NSMutableArray*)haveValueList;
@property(nonatomic, weak) NSObject<delegateProductView>* delegateProduct;
@end
