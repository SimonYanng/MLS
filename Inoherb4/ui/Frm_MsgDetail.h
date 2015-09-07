//
//  Frm_MsgDetail.h
//  Inoherb4
//
//  Created by Ren Yong on 14-6-10.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_Template.h"

@interface Frm_MsgDetail : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _msgDetailTableView;
    NSMutableDictionary* _msgDetail;
    D_Template* _template;
//    D_Panel* _panel;
}

-(id)init:(NSMutableDictionary*)data;
@end
