//
//  C_ViewHocList.h
//  Inoherb
//
//  Created by Bruce on 15/3/26.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_UIItem.h"
#import "C_Filter.h"
@protocol hocDelegate <NSObject>
- (void)delegate_selected:(NSMutableDictionary*)data;
@end
@interface C_ViewHocList : UIView<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,delegate_filter>
- (void)showInView:(UIView *) view;
- (id)initWithFrame:(CGRect)frame;
@property (weak) id<hocDelegate> delegate;
@end
