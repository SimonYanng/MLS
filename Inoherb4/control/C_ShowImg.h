//
//  C_ShowImg.h
//  Inoherb
//
//  Created by Bruce on 15/4/2.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C_ShowImg : UIView

- (id)initWithFrame:(CGRect)frame data:(NSMutableDictionary*)data;
-(void)showInView:(UIView*)view;
-(void)dismiss:(BOOL)animal;
@end
