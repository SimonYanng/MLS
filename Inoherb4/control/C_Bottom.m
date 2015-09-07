//
//  C_Bottom.m
//  SFA
//
//  Created by Ren Yong on 13-12-17.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_Bottom.h"
#import "C_Button.h"
#import "F_Color.h"
#import "F_Image.h"
#import "F_Font.h"
#import "NSMutableArray+Tool.h"
#import "NSMutableDictionary+Tool.h"
#import "FBShimmeringView.h"

@interface C_Bottom()
{
    //    NSMutableArray* _buttonList;
}
@end
@implementation C_Bottom
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame buttonList:(NSMutableArray*)list
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blackColor];
        [self initButton:frame buttonList:list];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame buttonList:(NSMutableArray*)list buttonList1:(NSMutableArray*)list1
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blackColor ];
        [self initButton:frame buttonList:list buttonList1:list1];
    }
    return self;
}

- (id)initWithFrameNoImg:(CGRect)frame buttonList:(NSMutableArray*)list
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=col_Bottom();
        [self initButtonNoImg:frame buttonList:list];
    }
    return self;
}

-(void)initButton:(CGRect)frame buttonList:(NSMutableArray*)list
{
    int buttonCount=[list count];
    int buttonW=frame.size.width/buttonCount;
    //    _buttonList= [[NSMutableArray alloc] init];
    C_Button* button;
    NSMutableDictionary* buttonField;
    for (int i=0;i<buttonCount;i++) {
        buttonField=[list dictAt:i];
        button=[[C_Button alloc] initWithFrame:CGRectMake(i*buttonW,0, buttonW, frame.size.height) text:[buttonField getString:@"name"] type:RPTBUTTON buttonId:[buttonField getInt:@"buttonId"]];
        if(i==0)
            button.backgroundColor=[UIColor darkGrayColor];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //        [_buttonList addButton:button];
        
        [self addSubview:button];
    }
}

-(void)initButton:(CGRect)frame buttonList:(NSMutableArray*)list buttonList1:(NSMutableArray*)list1
{
    int buttonCount=0;
    int buttonW=0;
    C_Button* button;
    NSMutableDictionary* buttonField;
    if(list)
    {
        buttonCount=[list count];
        buttonW=frame.size.width/buttonCount;
        //        _buttonList= [[NSMutableArray alloc] init];
//        FBShimmeringView *shimmeringView;
        
        for (int i=0;i<buttonCount;i++) {
            
            buttonField=[list dictAt:i];
            button=[[C_Button alloc] initWithFrame:CGRectMake(i*buttonW,0, buttonW, BOTTOMHEIGHT) text:[buttonField getString:@"name"] type:NAVBUTTON buttonId:[buttonField getInt:@"buttonId"]];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            //            [_buttonList addButton:button];
            [self addSubview:button];
            
//            if([buttonField getInt:@"buttonId"]==12||[buttonField getInt:@"buttonId"]==13)
//            {
//                shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(i*buttonW,0, buttonW, BOTTOMHEIGHT)];
//                [self addSubview:shimmeringView];
//                shimmeringView.contentView = button;
////                shimmeringView.shimmeringSpeed=.5;
//                shimmeringView.shimmering = YES;
//            }
        }
    }
    if(list1)
    {
//        buttonCount=[list1 count];
        buttonW=frame.size.width/buttonCount;
        for (int i=0;i<[list1 count];i++) {
            buttonField=[list1 dictAt:i];
            button=[[C_Button alloc] initWithFrame:CGRectMake(i*buttonW,BOTTOMHEIGHT, buttonW, BOTTOMHEIGHT) text:[buttonField getString:@"name"] type:NAVBUTTON buttonId:[buttonField getInt:@"buttonId"]];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            //            [_buttonList addButton:button];
            [self addSubview:button];
        }
    }
}

-(void)initButtonNoImg:(CGRect)frame buttonList:(NSMutableArray*)list
{
    int buttonCount=[list count];
    int buttonW=frame.size.width/buttonCount;
    
    UIButton* button;
    NSMutableDictionary* buttonField;
    for (int i=0;i<buttonCount;i++) {
        buttonField=[list dictAt:i];
        //        NSLog(@"名称%@,bId%d",[buttonField getString:@"name"],[buttonField getInt:@"buttonId"]);
        button=[[UIButton alloc] initWithFrame:CGRectMake(i*buttonW,1, buttonW, frame.size.height-1)];
        button.tag=i;
        [button setTitle:[buttonField getString:@"name"] forState:UIControlStateNormal];
        [button.titleLabel setFont:fontBysize(13)];
        [button setTitleColor:col_DarkText() forState:UIControlStateNormal];
        if(i==0)
            [button setBackgroundColor:col_White()];
        //        [button titleLabel];
        //        [button setBackgroundImage:img_Pin() forState:UIControlStateSelected];
        //        button.tag=[buttonField getInt:@"buttonId"];
        [button addTarget:self action:@selector(uibuttonClicked:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:button];
    }
}


- (void)buttonClicked:(id)sender
{
    C_Button* button=(C_Button*)sender;
    int count=[[self subviews] count];
    C_Button* allButton;
    for (int i=0; i<count; i++) {
        allButton=(C_Button*)[[self subviews] objectAtIndex:i];
        
        //        NSLog(@"按钮-----%d 按钮2------%d NAME----%@",allButton.tag,button.tag,[allButton titleLabel]);
        if(allButton.tag==button.tag)
            allButton.backgroundColor=[UIColor darkGrayColor];
        else
            allButton.backgroundColor=[UIColor clearColor];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(delegate_buttonClick:)])
    {
        [self.delegate delegate_buttonClick:button.tag];
    }
}

- (void)uibuttonClicked:(id)sender
{
    UIButton* button=(UIButton*)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(delegate_buttonClick:)])
    {
        [self.delegate delegate_buttonClick:button.tag];
    }
}

@end
