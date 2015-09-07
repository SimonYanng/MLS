//
//  C_CheckPhoto.h
//  SFA
//
//  Created by Ren Yong on 13-11-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Frm_Menu.h"
#import "F_Delegate.h"
#import "C_GradientButton.h"

//@protocol delegatebottom <NSObject>
//- (void)delegate_buttonClick:(int)buttonId;
//@end

//@protocol delegateCheckPhoto<NSObject>
//- (void)delegate_SavePhoto;
//@end

@class Frm_Menu;
@interface C_CheckPhoto : UIView <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
//{
//    UIImageView * _imgView;
//    C_GradientButton* _takePhoto;
//    PhotoType _type;
//    NSMutableDictionary* _clientInfo;
//    BOOL _isShot;
//}

@property(nonatomic, retain) Frm_Menu* form;
@property(nonatomic, weak) NSObject<delegateView>* delegate;

- (id)initWithFrame:(CGRect)frame type:(PhotoType)type clientInfo:(NSMutableDictionary*)clientInfo;

@end
