//
//  C_ViewButtonList.h
//  Inoherb
//
//  Created by Bruce on 15/3/31.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol buttonDelegate <NSObject>
- (void)delegate_buttonClick:(int)buttonId;
@end

@interface C_ViewButtonList : UIView

- (void)showInView:(UIView *) view;
- (id)initWithFrame:(CGRect)frame buttonList:(NSMutableArray*)buttonList title:(NSString*)title;
@property (weak) id<buttonDelegate> delegate;

- (void)cancelPicker;
@end
