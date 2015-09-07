//
//  C_Button.m
//  SFA
//
//  Created by Ren Yong on 13-11-15.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_Button.h"
#import "F_Color.h"
#import "F_Font.h"
#import "Constants.h"
#import "F_Image.h"
#import "C_ImageView.h"

@interface C_Button ()
{
    C_ImageView* imgView_icon;
}
@end

@implementation C_Button

- (id)initWithFrame:(CGRect)frame text:(NSString*)text type:(int)type buttonId:(int)buttonId
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        [self setFrame:frame];//设置大小
        self.tag=buttonId;
        
        NSLog(@"按钮-----%d",self.tag);
        switch (type) {
                
            case RPTBUTTON:
            {
                [self setBackgroundColor:col_ClearColor()];
                [self.titleLabel setFont:font_RptButton()];//设置显示字体
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [self setTitle:text forState:UIControlStateNormal];//设置显示内容
                [self setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];//设置文字的对其方式
                UIImage* img=imgbyId(buttonId);
                UIImageView* icon =[[UIImageView alloc] initWithFrame: CGRectMake ((frame.size.width-img.size.width)/2, 5, img.size.width, img.size.height)];
                [icon setImage: img];
                [self addSubview:icon];
            }
                break;
                
            case NAVBUTTON:
            {
                [self setBackgroundColor:col_ClearColor()];
                [self.titleLabel setFont:font_RptButton()];//设置显示字体
                [self setTitleColor:col_White() forState:UIControlStateNormal];
                [self setTitle:text forState:UIControlStateNormal];//设置显示内容
                [self setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];//设置文字的对其方式
                UIImage* img=imgbyId(buttonId);
                imgView_icon =[[C_ImageView alloc] initWithFrame: CGRectMake ((frame.size.width-26)/2, 5, 26, 26) image:img];
//                [imgView_icon set];
//                [imgView_icon setImage: img];
                [self addSubview:imgView_icon];
            }
                break;
                
            default:
                [self setBackgroundColor:col_LightText()];
                [self.titleLabel setFont:font_LoginButton()];//设置显示字体
                [self setTitleColor:col_White() forState:UIControlStateNormal];
                [self setTitle:text forState:UIControlStateNormal];//设置显示内容
                [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];//设置文字的对其方式
                break;
        }
    }
    return self;
}

-(void)resetImg:(BOOL)isSelect
{
    if(isSelect)
    {
    UIImage* img=imgSelectbyId(self.tag);
    [imgView_icon setImage: img];
    }
    else
    {
        UIImage* img=imgbyId(self.tag);
        [imgView_icon setImage: img];
    }
}
@end
