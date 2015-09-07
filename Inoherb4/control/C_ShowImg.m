//
//  C_ShowImg.m
//  Inoherb
//
//  Created by Bruce on 15/4/2.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "C_ShowImg.h"
#import "C_NavigationBar.h"
#import "C_GradientButton.h"
#import "Constants.h"
#import "NSMutableDictionary+Tool.h"
#import "GTMBase64.h"
@interface C_ShowImg()
{
    NSMutableDictionary* _dicData;
}
@end

@implementation C_ShowImg


- (id)initWithFrame:(CGRect)frame data:(NSMutableDictionary*)data
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _dicData=data;
        [self addNavigationBar];
        [self initImgView:frame];
    }
    return self;
}

-(void)addNavigationBar
{
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SYSTITLEHEIGHT) title:[_dicData getString:@"dictname"]];
    [self addSubview:bar];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    [btn_Back setTitle:@"取消" forState:UIControlStateNormal];
    [btn_Back useAddHocStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
}

- (void)backClicked:(id)sender
{
    [self dismiss:YES];
}

-(void)initImgView:(CGRect)frame
{
    UIImageView* view=[[UIImageView alloc] initWithFrame:CGRectMake(0, SYSTITLEHEIGHT, frame.size.width, frame.size.height-SYSTITLEHEIGHT)];
    NSString *testString = [_dicData getString:@"photo"];
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    testData = [GTMBase64 decodeData:testData];
    view.image= [UIImage imageWithData: testData];
    view.contentMode =  UIViewContentModeScaleToFill;
    
     [self addSubview:view];
}


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
