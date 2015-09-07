//
//  C_SkuViewCell.h
//  Shequ
//
//  Created by Ren Yong on 14-1-12.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_Label.h"
#import "D_Report.h"

@interface C_SkuViewCell : UITableViewCell
{
    UILabel* _caption;//显示内容
    UILabel* _price;//显示内容
    C_Label* _oldPrice;//显示内容
    UIImageView* _mainImg;
    UIImageView* _accessImg;
    
    UIButton* _addSku;
    NSMutableDictionary* _data;
    D_Report* _photo;
}

- (id)init:(NSMutableDictionary*) data;
-(void)refresh;
@end
