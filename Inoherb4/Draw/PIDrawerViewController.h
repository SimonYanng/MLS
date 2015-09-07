//
//  PIDrawerViewController.h
//  PIImageDoodler
//
//  Created by Pavan Itagi on 07/03/14.
//  Copyright (c) 2014 Pavan Itagi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIImageMergeControllerDelegate;

@interface PIDrawerViewController : UIViewController

@property (strong, nonatomic) UIImage *oriImage;
@property(nonatomic,assign) id <UIImageMergeControllerDelegate> delegate;


@end


@protocol UIImageMergeControllerDelegate<NSObject>
@optional

- (void)mergeMarkController:(PIDrawerViewController*)mergeVC didFinishWithImg:(UIImage*)mergedImg;

@end