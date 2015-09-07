//
//  C_Progress.m
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_Progress.h"
#import "AppDelegate.h"
#import "F_Color.h"
#import "Constants.h"


//@interface C_Progress()
//{
//
//}
//@end

@implementation C_Progress

@synthesize label,background,activity;
//C_Progress* mInstance;
//
//-(C_Progress*) newInstance:(CGRect)frame msg:(NSString*)msg
//{
//    mInstance =[[ C_Progress alloc] initWithFrame: frame  msg:msg];
//
//    return mInstance;
//}

//- (id)init
//{
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    return [self initWithFrame:CGRectMake(40, (rect.size.height + 60) / 2, 240, 60)];
//}

- (id)initWithFrame:(CGRect)frame msg:(NSString*)msg
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initBackground];
        [self initLabel:msg];
        [self initActivity];
    }
    return self;
}

-(void) initLabel:(NSString*)msg
{
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, self.frame.size.height/2-30, self.frame.size.width - 40, 60)];
    label.backgroundColor = col_DarkText();
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentLeft;
    label.layer.masksToBounds=YES;
    label.layer.cornerRadius = CORNERRADIUS;
    label.text =[NSMutableString stringWithFormat:@"           %@",msg] ;
    [self addSubview:label];
}

-(void) initActivity
{
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.center = CGPointMake(50 , self.frame.size.height/2);
    [self addSubview:activity];
}

-(void) initBackground
{
    background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    background.backgroundColor = col_DarkText();
    background.alpha = 0.3;
    [self addSubview:background];
}

- (void)show
{
    [activity startAnimating];
    [[AppDelegate shareAppDelegate].window addSubview:self];
}

- (void)dismissAfterDelay:(NSTimeInterval)timeInterval
{
    [activity stopAnimating];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:timeInterval];
}

@end
