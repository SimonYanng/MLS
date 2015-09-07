//
//  C_FootView.h
//  Shequ
//
//  Created by Ren Yong on 14-1-12.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_SyncResult.h"
#import "C_Label.h"
@interface C_FootView : UIView
{

    C_Label* _shuliang;//显示内容
    C_Label* _zhongliang;//显示内容
    C_Label* _jieyue;//显示内容
    D_SyncResult* _data;

}

- (id)initWithFrame:(CGRect)frame data:(D_SyncResult*) data;
@end
