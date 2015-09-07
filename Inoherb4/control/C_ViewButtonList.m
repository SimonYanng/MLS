//
//  C_ViewButtonList.m
//  Inoherb
//
//  Created by Bruce on 15/3/31.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "C_ViewButtonList.h"
#import "F_Color.h"
#import "DB.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "F_Font.h"
#import "C_GradientButton.h"
#import "C_Label.h"
@interface C_ViewButtonList()
{
    UIView* viewButton;
    NSMutableArray* _buttonList;
}
@end
@implementation C_ViewButtonList
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame buttonList:(NSMutableArray*)buttonList title:(NSString*)title
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor=col_Black1();
        
        [self setUserInteractionEnabled:YES];
//        [self add];
        
        _buttonList=buttonList;
        viewButton=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 210)];
        viewButton.backgroundColor=col_Background();
        [self addSubview:viewButton];
        [self initTitle:title];
        [self initButton];
        
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint points = [touch locationInView:self];
    if (points.x >= self.frame.origin.x && points.y >= self.frame.origin.x && points.x <= self.frame.size.width && points.y <= self.frame.size.height)
    {
        [self cancelPicker];
    }
}

-(void)initTitle:(NSString*)title
{
    C_Label* lableTitle=[[C_Label alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width-40, 40) label:title];
    [viewButton addSubview:lableTitle];
}

-(void)initButton
{
    
    int startH=40;
    C_GradientButton* btn;
    for (NSMutableDictionary* button in _buttonList) {
        btn=[[C_GradientButton alloc] initWithFrame:CGRectMake(20, startH, self.frame.size.width-40, 45)];
        btn.tag=[button getInt:@"buttonId"];
        [btn setTitle:[button getString:@"name"] forState:UIControlStateNormal];
        [btn useLoginStyle];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewButton addSubview:btn];
        startH+=50;
    }
    
    startH+=5;
    btn=[[C_GradientButton alloc] initWithFrame:CGRectMake(20, startH, self.frame.size.width-40, 45)];
    
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.tag=0;
    [btn useAddCancelStyle];
    [btn addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewButton addSubview:btn];
    
}

- (void)buttonClick:(id)sender
{
    C_GradientButton* btn=(C_GradientButton*)sender;
    if (_delegate) {
        [_delegate delegate_buttonClick:btn.tag];
    }
}

- (void)backClicked:(id)sender
{
    [self cancelPicker];
}



- (void)showInView:(UIView *) view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        
        viewButton.frame=CGRectMake(0, self.frame.size.height-210, self.frame.size.width, 210);
    }];
}


- (void)cancelPicker
{
    [UIView animateWithDuration:0.5
                     animations:^
     {
         viewButton.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 210);
     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

-(void)cancelClicked:(id)sender
{
    [self cancelPicker];
}



@end
