//
//  C_MenuCell.h
//  SFA1
//
//  Created by Ren Yong on 14-4-9.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "D_Field.h"

@protocol menuButtonDelegate <NSObject>
- (void)delegate_menuButtonClick:(int)buttonId;
@end

@interface C_MenuCell : UIView

- (id)init:(CGRect)frame data:(NSMutableArray*) data;
@property (weak) id<menuButtonDelegate> delegate;
@end
