//
//  C_CheckBox.m
//  SFA
//
//  Created by Ren Yong on 13-10-15.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_CheckBox.h"
#import "F_Color.h"
#import "C_Label.h"
#import "F_Font.h"
#import "F_Image.h"
#import "NSMutableDictionary+Tool.h"

@implementation C_CheckBox
{
    BOOL callBackWithData;
}

@synthesize delegate,icon,lable;


- (id)initWithFrameNoLabel:(CGRect)frame item:(D_UIItem*)uiItem data:(NSMutableDictionary*)userData Size:(int)size callBackWithData:(BOOL)isCall
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        int top=(frame.size.height-size)/2;
        
        icon =[[UIImageView alloc] initWithFrame: CGRectMake (0, top, size, size)];
        [self addSubview: icon];
        
        [self addTarget:self action:@selector(clicked) forControlEvents: UIControlEventTouchUpInside];
    }
    
    data=userData;
    
    item=uiItem;
    
    callBackWithData = isCall;
    
    [self setChecked:[userData getBool:item.dataKey]];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)uiItem data:(NSMutableDictionary*)userData
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        int top=(frame.size.height-20)/2;
        icon =[[UIImageView alloc] initWithFrame: CGRectMake (0, top, 20, 20)];
        [self addSubview: icon];
        
        lable =[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width + 7, 0,
                                                         frame.size.width - icon.frame.size.width - 10,
                                                         frame.size.height) ];
        lable.backgroundColor =col_ClearColor();
        lable.font = font_CheckBox();
        lable.textColor = col_CheckBox();
        lable.text = uiItem.caption;
        [self addSubview:lable];
        
        [self addTarget:self action:@selector(clicked) forControlEvents: UIControlEventTouchUpInside];
       
        
    }
    data=userData;
    
    item=uiItem;
    
    callBackWithData = NO;

    [self setChecked:[userData getBool:item.dataKey]];
    
    return self;
}

-(BOOL)isChecked {
    return checked;
}

-(void)setChecked: (BOOL)flag {
    checked = flag;
    if (checked)
    {
        [icon setImage: img_Checked()];
    }
    else
    {
        [icon setImage: img_UnChecked()];
    }
}


-(void)clicked {
    [self setChecked: !checked];
    [self setData];
    
    if(delegate){
        [delegate delegate_Checked:checked];
        if(YES == callBackWithData){
            [delegate delegate_clickButton:item data:data];
        }
    }
}


-(void)setData
{
    [data putBool:checked key:item.dataKey];
}

-(void)dealloc {
    delegate = nil;
    //    [super dealloc];
}



@end
