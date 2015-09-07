//
//  C_Visit.m
//  JahwaS
//
//  Created by westtalkzzz on 15/7/9.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "C_Visit.h"
#import "F_Color.h"
#import "C_Label.h"
#import "C_TextField.h"
#import "F_Phone.h"
#import "F_Color.h"

@implementation C_Visit

- (id)initWithFrame:(CGRect)frame field:(NSMutableDictionary*)field panel:(D_Panel*)panel
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addItem:panel field:field];
    }
    return self;
}

-(void)addItem:(D_Panel*)panel field:(NSMutableDictionary*)field
{
    int label_height = 20;
    UIColor *fontBlue = [UIColor colorWithRed:104.0/255 green:154.0/255 blue:184.0/255 alpha:1.0f];
    
    D_UIItem* item;
    C_Label* lable;
    
    //--------
    item= [panel itemAt:0];
    lable=[[C_Label alloc] initWithFrame: CGRectMake(5, 0, 120, label_height)  label:[NSString stringWithFormat:@"%@",[field getString:item.dataKey] ]];
    lable.textAlignment =NSTextAlignmentLeft;
    lable.textColor = fontBlue;
    //lable.backgroundColor = [UIColor orangeColor];
    [self addSubview:lable];
    
    item= [panel itemAt:1];
    lable=[[C_Label alloc] initWithFrame: CGRectMake(130, 0, self.frame.size.width - 130, label_height)  label:[NSString stringWithFormat:@"%@", [field getString:item.dataKey]  ]];
    lable.textAlignment =NSTextAlignmentLeft;
    //lable.backgroundColor = [UIColor orangeColor];
    [self addSubview:lable];
    
    //--------
    item= [panel itemAt:2];
    lable=[[C_Label alloc] initWithFrame: CGRectMake(5, label_height, self.frame.size.width, label_height)  label:[NSString stringWithFormat:@"%@",[field getString:item.dataKey] ]];
    lable.textAlignment =NSTextAlignmentLeft;
    //lable.backgroundColor = [UIColor redColor];
    [self addSubview:lable];
    
    //--------
    item= [panel itemAt:3];
    lable=[[C_Label alloc] initWithFrame: CGRectMake(5, label_height*2, 60, label_height)  label:[NSString stringWithFormat:@"%@", [field getString:item.dataKey] ]];
    lable.textAlignment =NSTextAlignmentLeft;
    lable.textColor = fontBlue;
    //lable.backgroundColor = [UIColor grayColor];
    [self addSubview:lable];
    
    item= [panel itemAt:4];
    lable=[[C_Label alloc] initWithFrame: CGRectMake(80, label_height*2, 40, label_height)  label:[NSString stringWithFormat:@"%@", [field getString:item.dataKey]  ]];
    lable.textAlignment =NSTextAlignmentLeft;
    lable.textColor = fontBlue;
    //lable.backgroundColor = [UIColor orangeColor];
    [self addSubview:lable];
    
    item= [panel itemAt:5];
    lable=[[C_Label alloc] initWithFrame: CGRectMake(120, label_height*2, 40, label_height)  label:[NSString stringWithFormat:@"%@", @"上海" ]];
    lable.textAlignment =NSTextAlignmentLeft;
    lable.textColor = fontBlue;
    //lable.backgroundColor = [UIColor yellowColor];
    [self addSubview:lable];
    
}

@end

