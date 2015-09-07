//
//  Frm_LoginViewController.h
//  SFA
//
//  Created by Ren Yong on 13-10-14.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "F_Delegate.h"
//#import "C_CheckBox.h"
//#import "C_Picker.h"

@interface Frm_Login : UIViewController <delegateView, delegateRequest,UIAlertViewDelegate>


//@property(nonatomic,retain)NSMutableDictionary* userData;
@property(nonatomic,retain)NSMutableDictionary* queryData;
@property(nonatomic,retain)NSMutableArray* msgList;

@property(nonatomic,assign)int index;
@property(nonatomic,assign)int requestType;

-(id)init;
@end
