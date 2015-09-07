//
//  C_Bottom.h
//  SFA
//
//  Created by Ren Yong on 13-12-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol delegatebottom <NSObject>
- (void)delegate_buttonClick:(int)buttonId;
@end

@interface C_Bottom : UIView


@property (weak) id<delegatebottom> delegate;

- (id)initWithFrame:(CGRect)frame buttonList:(NSMutableArray*)list;

- (id)initWithFrameNoImg:(CGRect)frame buttonList:(NSMutableArray*)list;
- (id)initWithFrame:(CGRect)frame buttonList:(NSMutableArray*)list buttonList1:(NSMutableArray*)list1;
@end
