//
//  F_Delegate.h
//  SFA
//
//  Created by Ren Yong on 13-10-24.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D_SyncResult.h"
#import "D_UIItem.h"
//#import "C_Picker.h"
#import "C_GradientButton.h"

@protocol delegateRequest

/**
 [""]	<#Description#>数据查询成功
 [""]	@param success <#success description#>
 [""]	@returns <#return value description#>
 [""] */
- (void)delegate_requestDidSuccess:(D_SyncResult*)success;

/**
 [""]	<#Description#>数据查询失败
 [""]	@param success <#success description#>
 [""]	@returns <#return value description#>
 [""] */
- (void)delegate_requestDidFail:(id)err;

///**
// [""]	<#Description#>数据查询超时
// [""]	@param success <#success description#>
// [""]	@returns <#return value description#>
// [""] */
//- (void)delegate_requestDidTimeout:(id)timeout;
//
///**
// [""]	<#Description#>数据查询取消
// [""]	@param success <#success description#>
// [""]	@returns <#return value description#>
// [""] */
//- (void)delegate_requestDidCancel:(id)cancel;
//
///**
// [""]	<#Description#>数据查询等待
// [""]	@param success <#success description#>
// [""]	@returns <#return value description#>
// [""] */
//- (void)delegate_requestWaiting:(id)waiting;


@end


//@class C_DropView;
@protocol delegateView
/**
 [""]	<#Description#>点击cell事件
 [""]	@param success <#success description#>
 [""]	@returns <#return value description#>
 [""] */
- (void)delegate_clickButton:(D_UIItem*)item data:(NSMutableDictionary*)data name:(NSString*)name;

- (void)delegate_Checked:(BOOL)value;

- (void)delegate_SavePhoto;
/**
 [""]	<#Description#>点击cell事件
 [""]	@param success <#success description#>
 [""]	@returns <#return value description#>
 [""] */
- (void)delegate_clickCell:(NSMutableDictionary*)data;

/**
 [""]	<#Description#>点击cell事件
 [""]	@param success <#success description#>
 [""]	@returns <#return value description#>
 [""] */
//- (void)delegate_scollView;

- (void)delegate_clickButton:(D_UIItem*)item data:(NSMutableDictionary*)data;

- (void)delegate_dateChanged;

- (void)delegate_takePhoto:(C_GradientButton*)button;

- (void)delegate_selectProduct:(NSString*)name;

- (void)delegate_shotPhoto:(NSMutableDictionary*)product button:(C_GradientButton*)button;
@end



