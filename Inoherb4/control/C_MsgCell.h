//
//  C_MsgCell.h
//  Inoherb4
//
//  Created by Ren Yong on 14-6-10.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface C_MsgCell : UITableViewCell
{
    UILabel* _caption;//显示内容
    UILabel* _time;//显示内容
    UILabel* _status;//显示内容
    NSMutableDictionary* _data;
}
- (id)init:(NSMutableDictionary*) data;
@end
