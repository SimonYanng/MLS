//
//  Frm_RootView.h
//  SFA
//
//  Created by Ren Yong on 13-11-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Frm_RootView : UINavigationController

//@property (nonatomic,assign) BOOL canDragBack;

//-(Frm_RootView*) newInstance :(UIViewController*)login canDragBack:(BOOL)canDragBack;
-(id)init:(UIViewController*)login canDragBack:(BOOL)canDragBack;


@property (nonatomic,assign) BOOL dragBack;
@property (nonatomic,assign) CGPoint startTouch;
@property (nonatomic,retain) UIImageView* lastScreenShotView;
@property (nonatomic,retain) UIView* blackMask;

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;
@property (nonatomic,assign) BOOL isMoving;


//@interface Frm_RootView ()
//{
//    CGPoint startTouch;
//    
//    UIImageView *lastScreenShotView;
//    UIView *blackMask;
////    BOOL dragBack;
//}
@end
