//
//  C_Button.h
//  SFA
//
//  Created by Ren Yong on 13-11-15.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C_Button : UIButton


- (id)initWithFrame:(CGRect)frame text:(NSString*)text type:(int)type buttonId:(int)buttonId;

-(void)resetImg:(BOOL)isSelect;
@end
