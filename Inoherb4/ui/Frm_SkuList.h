//
//  Frm_SkuList.h
//  Shequ
//
//  Created by Ren Yong on 14-1-12.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_SyncResult.h"

@interface Frm_SkuList : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _skuView;
    BOOL isFirst;
    NSMutableArray* arr_kaoqin;
}

//@property(nonatomic, retain) UITableView* skuView;
//@property(nonatomic, retain) D_SyncResult* skuResult;
//@property(nonatomic, retain) D_SyncResult* otherResult;
@end
