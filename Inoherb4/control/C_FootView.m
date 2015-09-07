//
//  C_FootView.m
//  Shequ
//
//  Created by Ren Yong on 14-1-12.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_FootView.h"
#import "F_Color.h"
#import "F_Image.h"
#import "Constants.h"
#import "F_Font.h"
#import "C_Label.h"

@implementation C_FootView

- (id)initWithFrame:(CGRect)frame data:(D_SyncResult*) data
{
    _data=data;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.backgroundColor=col_Background();
        
//        self.autoresizesSubviews = YES;
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        self.userInteractionEnabled = YES;
//        
//        self.hidden = NO;
//        self.multipleTouchEnabled = NO;
//        self.opaque = NO;
//        self.contentMode = UIViewContentModeScaleToFill;
        [self initShuliang];
        [self initZhongliang];
        [self initJieyue];
    }
    return self;
}
-(void)initShuliang
{
    _shuliang = [[C_Label alloc] initWithFrame:CGRectMake(10, 5, 100, 20) label:[NSString stringWithFormat:@"数量%@件",[_data getString:@"totalcount"]]];
    _shuliang.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_shuliang];
//    [_shuliang setColor:[UIColor redColor] fromIndex:2 length:(_shuliang.text.length-3)];
}

-(void)initZhongliang
{
    _zhongliang = [[C_Label alloc] initWithFrame:CGRectMake(110, 5, 100, 20) label:[NSString stringWithFormat:@"重量%@KG",[_data getString:@"zhongliang"]]];
    _zhongliang.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_zhongliang];
//    [_zhongliang setColor:[UIColor redColor] fromIndex:2 length:(_zhongliang.text.length-4)];
}

-(void)initJieyue
{
    _jieyue = [[C_Label alloc] initWithFrame:CGRectMake(210, 5, 100, 20) label:[NSString stringWithFormat:@"共节省%@",[_data getString:@"jieyue"]]];
    _jieyue.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_jieyue];
//    [_jieyue setColor:[UIColor redColor] fromIndex:3 length:(_jieyue.text.length-3)];
}


@end
