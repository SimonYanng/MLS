//
//  PIDrawerView.m
//  PIImageDoodler
//
//  Created by Pavan Itagi on 07/03/14.
//  Copyright (c) 2014 Pavan Itagi. All rights reserved.
//

#import "PIDrawerView.h"
#import "F_Tool.h"

@interface PIDrawerView ()
{
    CGPoint previousPoint;
    CGPoint currentPoint;
}
@property (nonatomic, strong) UIImage * viewImage;
@end

@implementation PIDrawerView

- (void)awakeFromNib
{
    [self initialize];
}

- (void)drawRect:(CGRect)rect
{
    [self.viewImage drawInRect:self.bounds];
}

#pragma mark - setter methods
- (void)setDrawingMode:(DrawingMode)drawingMode
{
    _drawingMode = drawingMode;
}

#pragma mark - Private methods
- (void)initialize
{
    currentPoint = CGPointMake(0, 0);
    previousPoint = currentPoint;
    
    _drawingMode = DrawingModePaint;
    
    _selectedColor = [UIColor blackColor];

}

- (void)eraseLine
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.viewImage drawInRect:self.bounds];
    
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), previousPoint.x, previousPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    previousPoint = currentPoint;
    
    [self setNeedsDisplay];
}


- (void)drawLineNew
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.viewImage drawInRect:self.bounds];
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.selectedColor.CGColor);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), previousPoint.x, previousPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    previousPoint = currentPoint;
    
    [self setNeedsDisplay];
}

- (void)clear
{
    self.viewImage = nil;
    [self setNeedsDisplay];
}

-(UIImage*)mergeImage:(UIImage*)oriImg;
{
    UIImage *oriImage = oriImg;
    
    //这种情况下我们需要最终合成的图片大小是和person一致的，让我们获得我们需要的最终图片的大小：
    CGSize finalSize = [oriImage size];
    
    UIImage *markerImage = scaleToSize(self.viewImage, finalSize);
    
    //然后再搞到hat的大小，可能比person要小得多：
    CGSize hatSize = [markerImage size];
    
    //现在我们需要创建一个graphics context来画我们的东西：
    UIGraphicsBeginImageContext(finalSize);
    
    //graphics context就像一张能让我们画上任何东西的纸。我们要做的第一件事就是把person画上去：
    [oriImage drawInRect:CGRectMake(0, 0, finalSize.width, finalSize.height)];
    
    //然后再把hat画在合适的位置：
    [markerImage drawInRect:CGRectMake(0, 0, hatSize.width, hatSize.height)];
    
    //接着通过下面的语句创建新的UIImage:
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //最后，我们必须得清理并关闭这个我们再也不需要的context：    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)handleTouches
{
    if (self.drawingMode == DrawingModeNone) {
        // do nothing
        NSLog(@"----do nothing");
        
    }
    else if (self.drawingMode == DrawingModePaint) {
        NSLog(@"----drawLineNew");
        [self drawLineNew];
    }
    else
    {
        NSLog(@"----eraseLine");
        [self eraseLine];
    }
}

#pragma mark - Touches methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"----touchesBegan");
    CGPoint p = [[touches anyObject] locationInView:self];
    previousPoint = p;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"----touchesMoved");
    currentPoint = [[touches anyObject] locationInView:self];
    
    [self handleTouches];
    NSLog(@"----touchesMoved 1");
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"----touchesEnded");
    currentPoint = [[touches anyObject] locationInView:self];
    
    [self handleTouches];
    NSLog(@"----touchesEnded 1");
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"----touchesCancelled");
}


@end
