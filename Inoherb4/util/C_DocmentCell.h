//
//  C_DocmentCell.h
//  SFA1
//
//  Created by Ren Yong on 14-4-15.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C_DocmentCell : UITableViewCell

@property UIButton *actionBt;

- (id)init:(NSMutableDictionary*) data;
-(void)refreshCaption:(NSMutableDictionary*) data;

@end
