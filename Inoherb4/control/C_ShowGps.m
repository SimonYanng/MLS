//
//  C_ShowGps.m
//  Inoherb
//
//  Created by Bruce on 15/6/2.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "C_ShowGps.h"
#import "C_NavigationBar.h"
#import "C_GradientButton.h"
#import "Constants.h"
#import "NSMutableDictionary+Tool.h"
#import "GTMBase64.h"
#import "F_Font.h"
@interface C_ShowGps()
{
    NSMutableDictionary* _dicData;
}
@end

@implementation C_ShowGps



- (id)initWithFrame:(CGRect)frame data:(NSMutableDictionary*)data
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _dicData=data;
        [self setBackgroundColor:[UIColor whiteColor]];
//        [self addNavigationBar];
        [self initImgView:frame];
    }
    return self;
}

-(void)initImgView:(CGRect)frame
{
    UILabel* lable=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, 20)];
    [lable setText:[_dicData getString:@"fullname"]];
    [self addSubview:lable];
    
    lable=[[UILabel alloc] initWithFrame:CGRectMake(5, 30, self.frame.size.width-10, 20)];
    [lable setText:[_dicData getString:@"address"]];
    [lable setFont:fontBysize(13)];
    [lable setTextColor:[UIColor lightGrayColor]];
    [self addSubview:lable];
    
    C_GradientButton* btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(10, self.frame.size.height-40, self.frame.size.width/2-15, 30)];
    [btn_Hoc setTitle:@"路线" forState:UIControlStateNormal];
    [btn_Hoc useGPSStyle];
    [btn_Hoc addTarget:self action:@selector(addHoc:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn_Hoc];
    
     btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2+5, self.frame.size.height-40, self.frame.size.width/2-15, 30)];
    [btn_Hoc setTitle:@"导航" forState:UIControlStateNormal];
    [btn_Hoc useGPSStyle];
    [btn_Hoc addTarget:self action:@selector(addHoc:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn_Hoc];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)showInView:(UIView*)view
{
    self.alpha=1;
    [view addSubview:self];
    
    [UIView animateWithDuration:0.5
                     animations:^
     {
         [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:view cache:YES];
     }
                     completion:^(BOOL finished){
                     }];
}

-(void)dismiss:(BOOL)animal
{
    
    if (animal) {
        
        self.alpha=0;
        [UIView animateWithDuration:0.5
                         animations:^
         {
             [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:[self superview] cache:YES];
         }
                         completion:^(BOOL finished){
                             [self removeFromSuperview];
                         }];
    }
    else
    [self removeFromSuperview];
}

@end
