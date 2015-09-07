//
//  C_GradientButton.h
//  Inoherb
//
//  Created by Bruce on 15/3/26.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
@interface C_GradientButton : UIButton
{
    // These two arrays define the gradient that will be used
    // when the button is in UIControlStateNormal
    NSArray  *normalGradientColors;     // Colors
    NSArray  *normalGradientLocations;  // Relative locations
    
    // These two arrays define the gradient that will be used
    // when the button is in UIControlStateHighlighted
    NSArray  *highlightGradientColors;     // Colors
    NSArray  *highlightGradientLocations;  // Relative locations
    
    // This defines the corner radius of the button
    CGFloat         cornerRadius;
    
    // This defines the size and color of the stroke
    CGFloat         strokeWeight;
    UIColor         *strokeColor;
    
@private
    CGGradientRef   normalGradient;
    CGGradientRef   highlightGradient;
}
@property (nonatomic, retain) NSArray *normalGradientColors;
@property (nonatomic, retain) NSArray *normalGradientLocations;
@property (nonatomic, retain) NSArray *highlightGradientColors;
@property (nonatomic, retain) NSArray *highlightGradientLocations;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat strokeWeight;
@property (nonatomic, retain) UIColor *strokeColor;
- (void)useAlertStyle;
- (void)useRedDeleteStyle;
- (void)useWhiteStyle;
- (void)useLoginStyle;
- (void)useWhiteActionSheetStyle;
- (void)useBlackActionSheetStyle;
- (void)useSimpleOrangeStyle;
- (void)useGreenConfirmStyle;
- (void)useAddHocStyle;
- (void)useAddCancelStyle;
- (void)useItemStyle;
- (void)useClearStyle;
- (void)usePlanStyle;
- (void)useCheckStyle;
- (void)useImgStyle;

- (void)useGPSStyle;
- (void)useLeftImgStyle;
- (void)useTopImgStyle;
-(void)addBackImg:(UIImage*)img;
- (void)useToStyle;
//- (id)initWithFrame:(CGRect)frame text:(NSString*)text;
- (id)initWithFrame:(CGRect)frame buttonId:(int)buttonId;

@end
