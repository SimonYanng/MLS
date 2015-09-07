//
//  C_NavigationBar.m
//  SFA
//
//  Created by Ren Yong on 13-11-15.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_NavigationBar.h"
#import "F_Color.h"
#import "F_Phone.h"
#import "Constants.h"
#import "F_Font.h"
#import "F_Phone.h"


#define LABELHEIGHT 24

@interface C_NavigationBar()
{
    UILabel* label ;
}
@end

@implementation C_NavigationBar

C_NavigationBar* mInstance;

-(C_NavigationBar*) newInstance:(NSString*)title
{
    mInstance =[[ C_NavigationBar alloc] initWithFrame: CGRectMake(0, 0, screenW(), SYSTITLEHEIGHT) title:title];
    return mInstance;
}

-(C_NavigationBar*) newInstanceBy:(NSString*)title
{
    mInstance =[[ C_NavigationBar alloc] initWithTitle:title];
    return mInstance;
}

- (id)initWithTitle:(NSString*)title
{
    self = [super initWithFrame:CGRectMake(0, 0, screenW(), 44)];
    if (self) {
        // Initialization code
        
        self.backgroundColor = col_Gray();
        
        UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW(), 44)];
        background.backgroundColor = col_Title();
        //        background.layer.cornerRadius=CORNERRADIUS;
        [self addSubview:background];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenW(), 44)];
        label.backgroundColor = col_Gray();
        label.textColor = col_SysTitle();
        label.font = font_NavLabel();
        label.textAlignment = NSTextAlignmentLeft;
        label.text=[NSString stringWithFormat:@" %@",title];
        [self addSubview:label];
        
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame title:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        int originy=(SYSTITLEHEIGHT-LABELHEIGHT)/2+statusBarHeight()/2;
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        UIColor *startColor =col_byIntColor(0x6DCAE9);//[UIColor   redColor];
        UIColor *endColor =col_byIntColor(0x6DCAE9);//[UIColor   redColor];
        gradient.colors = [NSArray arrayWithObjects:(id)[startColor CGColor],
                           (id)[endColor CGColor],nil];
//        [gradient setCornerRadius:CORNERRADIUS];
        [self.layer insertSublayer:gradient atIndex:0];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(65, originy, frame.size.width-130, LABELHEIGHT)];
        label.backgroundColor = col_ClearColor();
        label.textColor = col_SysTitle();
        label.font = fontByBoldsize(18);
        label.textAlignment = NSTextAlignmentCenter;
        label.text=title;
        label.adjustsFontSizeToFitWidth=YES;
        [self addSubview:label];
        
//        UIView* line=[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.4, frame.size.width, 0.4)];
//        [line setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
//          [self addSubview:line];
        
    }
    return self;
}

- (void)addGestureRecognizer:(UIGestureRecognizer *)singleTap
{
     [label addGestureRecognizer:singleTap];
}

-(void)resetTitle:(NSString*)title
{
     label.text=title;
}

//- (void)drawRect:(CGRect)rect
//{
//    CGRect imageBounds = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
//    CGFloat alignStroke;
//    CGFloat resolution;
//    CGMutablePathRef path;
//    CGRect drawRect;
//    CGGradientRef gradient;
//    NSMutableArray *colors;
//    UIColor *color;
//    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGPoint point;
//    CGPoint point2;
//    CGFloat locations[2];
//    resolution = 0.5 * (self.bounds.size.width / imageBounds.size.width + self.bounds.size.height / imageBounds.size.height);
//    
//    alignStroke = 0.0;
//    path = CGPathCreateMutable();
//    drawRect = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
//    drawRect.origin.x = (round(resolution * drawRect.origin.x + alignStroke) - alignStroke) / resolution;
//    drawRect.origin.y = (round(resolution * drawRect.origin.y + alignStroke) - alignStroke) / resolution;
//    drawRect.size.width = round(resolution * drawRect.size.width) / resolution;
//    drawRect.size.height = round(resolution * drawRect.size.height) / resolution;
//    CGPathAddRect(path, NULL, drawRect);
//    colors = [NSMutableArray arrayWithCapacity:2];
//    color =UIColorFromRGB(0x08a2cc);
//    [colors addObject:(id)[color CGColor]];
//    locations[0] = 0.0;
//    color = UIColorFromRGB(0x74C4DF);
//    [colors addObject:(id)[color CGColor]];
//    locations[1] = 1.0;
//    gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
//    CGContextAddPath(context, path);
//    CGContextSaveGState(context);
//    CGContextEOClip(context);
//    point = CGPointMake(100.0, self.bounds.size.height);
//    point2 = CGPointMake(100.0, 0.0);
//    CGContextDrawLinearGradient(context, gradient, point, point2, (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
//    CGContextRestoreGState(context);
//    CGGradientRelease(gradient);
//    CGPathRelease(path);
//    CGColorSpaceRelease(space);
//}


- (void)addLeftButton:(UIButton *)leftButton
{
    CGRect rect = leftButton.frame;
    rect.origin.x = 5;
    rect.origin.y = (SYSTITLEHEIGHT-rect.size.height)/2+statusBarHeight()/2;
    leftButton.frame = rect;
    [self addSubview:leftButton];
}

- (void)addRightButton:(UIButton *)rightButton
{
    CGRect rect = rightButton.frame;
    rect.origin.x = self.frame.size.width - rect.size.width - 5;
    rect.origin.y = (SYSTITLEHEIGHT-rect.size.height)/2+statusBarHeight()/2;
    rightButton.frame = rect;
    [self addSubview:rightButton];
}

- (void)addRightButton1:(UIButton *)rightButton
{
    CGRect rect = rightButton.frame;
    rect.origin.x = self.frame.size.width - (rect.size.width - 5)*2;
    rect.origin.y = (SYSTITLEHEIGHT-rect.size.height)/2+statusBarHeight()/2;
    rightButton.frame = rect;
    [self addSubview:rightButton];
}

- (void)addRightButtonNormal:(UIButton *)rightButton
{
    CGRect rect = rightButton.frame;
    rightButton.frame = CGRectMake(self.frame.size.width - rect.size.width - 10, (self.frame.size.height - rect.size.height) / 2+2, rect.size.width, rect.size.height);
    [self addSubview:rightButton];
}

@end
