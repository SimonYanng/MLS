//
//  C_MenuCell.m
//  SFA1
//
//  Created by Ren Yong on 14-4-9.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_MenuCell.h"
#import "F_Color.h"
#import "F_Font.h"
#import "F_Image.h"
#import "NSMutableDictionary+Tool.h"
#import "C_GradientButton.h"
@interface C_MenuCell ()
{
    NSMutableArray* _data;
}
@end

@implementation C_MenuCell

@synthesize delegate=_delegate;

- (id)init:(CGRect)frame data:(NSMutableArray*) data
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _data=data;
        self.backgroundColor=[UIColor clearColor];
        [self initButton];
    }
    return self;
}

-(void)initButton
{
    C_GradientButton* btn_Back;
    int index=0;
    int totalW=self.frame.size.width-10;
    int buttonW=totalW/2;
    for(NSMutableDictionary* data in _data)
    {
        if(index==0)
            btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(10, 0, buttonW-10, buttonW)];
       else  if(index==1)
            btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(buttonW+10, 0, buttonW-10, buttonW)];
//        else
//            btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(buttonW*2+10, 0, buttonW-10, buttonW)];
        btn_Back.tag=[data  getInt:@"value"];
        [btn_Back setTitle:[data getString:@"title"] forState:UIControlStateNormal];
        [btn_Back useTopImgStyle];
        [btn_Back addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
         [self addSubview:btn_Back];
        
        UIView * title=[[UIView alloc] initWithFrame:CGRectMake(10, 0, buttonW-10,5)];
        if(index==1)
            title=[[UIView alloc] initWithFrame:CGRectMake(buttonW+10, 0, buttonW-10,5)];
        [title setBackgroundColor:[UIColor redColor]];
        [self addSubview:title];
        index++;
    }
    
}

- (void)buttonClicked:(id)sender
{
    C_GradientButton* button=  (C_GradientButton*)sender;
    if(_delegate)
        [_delegate delegate_menuButtonClick:button.tag];
}


@end
