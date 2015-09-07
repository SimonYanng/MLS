//
//  C_Question.m
//  JahwaS
//
//  Created by Bruce on 15/6/8.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "C_Question.h"
#import "F_Color.h"
#import "C_Label.h"
#import "C_TextField.h"
#import "F_Phone.h"
#import "F_Color.h"
@implementation C_Question

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
    
    if([panel.type isEqualToString:@"1"])
    {
        D_UIItem*item= [panel itemAt:2];
       C_Label* lable=[[C_Label alloc] initWithFrame: CGRectMake(5, 0, 60, self.frame.size.height)  label:[NSString stringWithFormat:@"%@", [field getString:item.dataKey]]];
        lable.textAlignment =NSTextAlignmentLeft;
        lable.textColor = fontBlue;
        //lable.backgroundColor = [UIColor grayColor];
        [self addSubview:lable];
        
        item= [panel itemAt:3];
        lable=[[C_Label alloc] initWithFrame: CGRectMake(80,0, 120, self.frame.size.height)  label:[NSString stringWithFormat:@"%@",[field getString:item.dataKey] ]];
        lable.textAlignment =NSTextAlignmentLeft;
        lable.textColor = fontBlue;
        //lable.backgroundColor = [UIColor orangeColor];
        [self addSubview:lable];
        
        item= [panel itemAt:4];
        lable=[[C_Label alloc] initWithFrame: CGRectMake(self.frame.size.width-80, 0, 80, self.frame.size.height)  label:[NSString stringWithFormat:@"%@",[field getString:item.dataKey] ]];
        lable.textAlignment =NSTextAlignmentLeft;
        lable.textColor = fontBlue;
        //lable.backgroundColor = [UIColor yellowColor];
        [self addSubview:lable];
    }
    else
    {
    D_UIItem* item= [panel itemAt:0];
    C_Label* lable=[[C_Label alloc] initWithFrame: CGRectMake(5, 0, self.frame.size.width, label_height)  label:[NSString stringWithFormat:@"%@",[field getString:item.dataKey] ]];
    lable.textAlignment =NSTextAlignmentLeft;
    //lable.backgroundColor = [UIColor redColor];
    [self addSubview:lable];
    
    //--------
    item= [panel itemAt:1];
    lable=[[C_Label alloc] initWithFrame: CGRectMake(5, label_height, self.frame.size.width, label_height)  label:[NSString stringWithFormat:@"%@",[field getString:item.dataKey] ]];
    lable.textAlignment =NSTextAlignmentLeft;
    lable.textColor = fontBlue;
    //lable.backgroundColor = [UIColor greenColor];
    [self addSubview:lable];
    
    //--------
    item= [panel itemAt:2];
    lable=[[C_Label alloc] initWithFrame: CGRectMake(5, label_height*2, 60, label_height)  label:[NSString stringWithFormat:@"%@", [field getString:item.dataKey]]];
    lable.textAlignment =NSTextAlignmentLeft;
    lable.textColor = fontBlue;
    //lable.backgroundColor = [UIColor grayColor];
    [self addSubview:lable];
    
    item= [panel itemAt:3];
    lable=[[C_Label alloc] initWithFrame: CGRectMake(80, label_height*2, 120, label_height)  label:[NSString stringWithFormat:@"%@",[field getString:item.dataKey] ]];
    lable.textAlignment =NSTextAlignmentLeft;
    lable.textColor = fontBlue;
    //lable.backgroundColor = [UIColor orangeColor];
    [self addSubview:lable];
    
    item= [panel itemAt:4];
    lable=[[C_Label alloc] initWithFrame: CGRectMake(200, label_height*2, self.frame.size.width-200, label_height)  label:[NSString stringWithFormat:@"%@",[field getString:item.dataKey] ]];
    lable.textAlignment =NSTextAlignmentLeft;
    lable.textColor = fontBlue;
    //lable.backgroundColor = [UIColor yellowColor];
    [self addSubview:lable];
    }
}

//-(void)addItem:(D_Panel*)panel field:(NSMutableDictionary*)field
//{
//    D_UIItem* item= [panel itemAt:0];
//    C_Label* lable=[[C_Label alloc] initWithFrame: CGRectMake(5, 0, self.frame.size.width, 40)  label:[NSString stringWithFormat:@"问题:%@",[field getString:item.dataKey] ]];
//      lable.textAlignment =NSTextAlignmentLeft;
//    [self addSubview:lable];
//    
//    item= [panel itemAt:2];
//    lable=[[C_Label alloc] initWithFrame: CGRectMake(5, 35, self.frame.size.width, 20)  label:[NSString stringWithFormat:@"日期:%@",[field getString:item.dataKey] ]];
//    lable.textAlignment =NSTextAlignmentLeft;
//    [self addSubview:lable];
//    
//    item= [panel itemAt:1];
//    lable=[[C_Label alloc] initWithFrame: CGRectMake(110, 35, self.frame.size.width, 20)  label:[NSString stringWithFormat:@"门店:%@",[field getString:item.dataKey] ]];
//    lable.textAlignment =NSTextAlignmentLeft;
//    [self addSubview:lable];
//}

@end
