//
//  C_CellRpt.h
//  Inoherb
//
//  Created by Bruce on 15/3/30.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_Template.h"

@interface C_CellRpt : UIView

- (id)initWithFrame:(CGRect)frame template:(D_Template*)template;

-(void)refresh:(NSMutableArray*)listTempStatus;

@end
