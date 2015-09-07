//
//  C_DropView.h
//  SFA
//
//  Created by Ren Yong on 13-11-22.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "F_Delegate.h"


@interface C_DropView : UIView<UIGestureRecognizerDelegate>


@property(nonatomic,weak)NSObject<delegateView>* delegate_DropView;

-(id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data;
@end
