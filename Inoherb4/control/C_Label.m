//
//  C_Label.m
//  SFA
//
//  Created by Ren Yong on 13-10-21.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_Label.h"
#import "F_Color.h"
#import "F_Font.h"
#import "F_Alert.h"
#import "F_Image.h"

@implementation C_Label
@synthesize isStrike=_isStrike;
@synthesize attString = _attString;

@synthesize dataField,uiItem;

- (id)initWithFrame:(CGRect)frame label:(NSString*)label isStrike:(BOOL)isStrike
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = col_ClearColor();
        self.font = font_Text();
        self.textColor = col_DarkText();
        self.text = label;
        _isStrike=isStrike;
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame label:(NSString*)label
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = col_ClearColor();
        self.textColor = col_DarkText();
        self.font = fontBysize(13);
        self.textAlignment =NSTextAlignmentCenter;
        self.text =label;// [NSString stringWithFormat:@"  %@",label];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = col_ClearColor();
        self.textColor = col_DarkText();
        self.font = fontBysize(15);
        self.textAlignment =NSTextAlignmentLeft;
        self.text = [item.caption stringByAppendingString:@":"];
        [self setAdjustsFontSizeToFitWidth:YES];
//        [self setMinimumScaleFactor:5.0f];
    }
    return self;
}




- (id)initWithFrame:(CGRect)frame data:(NSMutableDictionary*)data item:(D_UIItem*)item
{
    dataField=data;
    uiItem=item;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = col_ClearColor();
        self.textColor = col_DarkText();
        self.font = fontBysize(14);
        self.textAlignment =NSTextAlignmentLeft;
        self.text =[NSString stringWithFormat:@"  %@",[dataField getString:uiItem.dataKey]];
       
        if([item.caption isEqualToString:@"照片"]&&[[data getString:item.dataKey] isEqualToString:@""])
        {
            UIImage* img=img_Photo();
            int w=frame.size.height-16;
            UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-w)/2,8, w, w)]; //] initWithImage:img_MustInput()];
            [imgv setContentMode:UIViewContentModeScaleToFill];
            imgv.image=img;
            [self addSubview:imgv];
        }
        else if([item.caption isEqualToString:@"填写状态"])
        {
            UIImage* img;
            if([[data getString:item.dataKey] isEqualToString:@"0"])
                img=img_UnChecked();
            else
                img=img_Checked();
            int w=frame.size.height-30;
            UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-w)/2,15, w, w)]; //] initWithImage:img_MustInput()];
            [imgv setContentMode:UIViewContentModeScaleToFill];
            imgv.image=img;
            [self addSubview:imgv];
        }
        
    }
    return self;
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint points = [touch locationInView:self];
//    if (points.x >= self.frame.origin.x && points.y >= self.frame.origin.x && points.x <= self.frame.size.width && points.y <= self.frame.size.height)
//    {
//        toast_showInfoMsg(self.text, 100);
//    }
//}

//- (void)drawTextInRect:(CGRect)rect
//{
//    [super drawTextInRect:rect];
//    
//    CGSize textSize = [[self text] sizeWithFont:[self font]];
//    CGFloat strikeWidth = textSize.width;
//    CGRect lineRect;
//    float height=0.6f;
//    
//    if ([self textAlignment] == NSTextAlignmentRight) {
//        lineRect = CGRectMake(rect.size.width - strikeWidth, rect.size.height/2, strikeWidth, height);
//    } else if ([self textAlignment] == NSTextAlignmentCenter) {
//        lineRect = CGRectMake(rect.size.width/2 - strikeWidth/2, rect.size.height/2, strikeWidth, height);
//    } else {
//        lineRect = CGRectMake(0, rect.size.height/2, strikeWidth, height);
//    }
//    
//    if (_isStrike) {
////        CGFloat black[4]={0.0f,0.0f,0.0f,1.0f};
//        CGContextRef context = UIGraphicsGetCurrentContext();
////        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//        CGContextFillRect(context, lineRect);
//    }
//}

// 设置某段字的颜色
//- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length
//{
//    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
//        return;
//    }
//    [_attString addAttribute:(NSString *)NSForegroundColorAttributeName
//                       value:(id)[[UIColor redColor] CGColor]
//                       range:NSMakeRange(location, length)];
//}

//- (void)drawRect:(CGRect)rect{
//    
//    if (_isStrike) {
//        [self drawTextInRect:rect];
////        CGContextRef context = UIGraphicsGetCurrentContext();
//////        CGFloat black[4]={0.0f,0.0f,0.0f,1.0f};
////        CGRect lineRect;
////        CGSize textSize = [[self text] sizeWithFont:[self font]];
////        CGFloat strikeWidth = textSize.width;
////        lineRect = CGRectMake(rect.size.width/2 - strikeWidth/2, rect.size.height/2, strikeWidth, 0.5);
////        CGContextFillRect(context, lineRect);
//    }
//    else{
//        CATextLayer *textLayer = [CATextLayer layer];
//        textLayer.string = _attString;
//        textLayer.contentsScale=2;
//        //    textLayer.font=font_Label();
//        //    textLayer.textAlignment =NSTextAlignmentLeft;
//        textLayer.frame =self.frame;// CGRectMake(0, 8, self.frame.size.width, self.frame.size.height);
//        [self.layer addSublayer:textLayer];
//    }
//}

 //设置某段字的字体
//- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length
//{
//    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
//        return;
//    }
//    [_attString addAttribute:(NSString *)NSFontAttributeName
//                       value:(id)[UIFont fontWithName:@"Menlo" size:16]
//                       range:NSMakeRange(location, length)];
//}

@end
