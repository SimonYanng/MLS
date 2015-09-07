//
//  C_DropView.m
//  SFA
//
//  Created by Ren Yong on 13-11-22.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_DropView.h"
#import "F_Color.h"
#import "DB.h"
#import "F_Font.h"
#import "F_Phone.h"
#import "NSMutableDictionary+Tool.h"
#import "F_Image.h"
#import "C_GradientButton.h"
@interface C_DropView()
{
    NSMutableDictionary* _field;
    D_UIItem* _item;
    C_GradientButton* _btnDropView;//显示内容
    UIImageView* _imgView;
}
@end

@implementation C_DropView
@synthesize delegate_DropView;

-(id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:col_ClearColor()];
        
        UIImage* img=img_Triangle();
        _btnDropView=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 5, frame.size.width,frame.size.height-10)];
        [_btnDropView useItemStyle];
        [_btnDropView.titleLabel setFont:fontBysize(14)];//设置显示字体
        
        _btnDropView.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, img.size.width+5);
        
        [_btnDropView  setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        
        NSString* txt;
        if(item.controlType==MULTICHOICE)
            txt=[self name1:data item:item];
        else
            txt=[self name:data item:item];
        
        [_btnDropView setTitle:txt forState:UIControlStateNormal];//设置显示内容
        if(item.isEnable)
            [_btnDropView addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_btnDropView.layer setCornerRadius:CORNERRADIUS];
        [self addSubview:_btnDropView];
        
        
        UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(_btnDropView.frame.size.width-img.size.width-5, (_btnDropView.frame.size.height-img.size.height)/2, img.size.width, img.size.height)]; //] initWithImage:img_MustInput()];
        imgv.image=img;
        [_btnDropView addSubview:imgv];
        _field=data;
        _item=item;
    }
    return self;
}



-(NSString*)result:(NSMutableDictionary*)data item:(D_UIItem*)item
{
    return [data getString:item.dataKey];//[ isEqualToString:@""]?@"请选择":[data getString:item.dataKey];
}

-(NSString*)name:(NSMutableDictionary*)data item:(D_UIItem*)item
{
    
    //    NSLog(@"asdsad",[data getString:item.dataKey]);
    NSString* value=[data getString:item.dataKey];
    if(![value isEqualToString:@""])
    {
        NSMutableArray* list;
        if(item.isSurverItem)
            list = [[DB instance] fieldListBy:[NSMutableString stringWithFormat:@"SELECT serverid as value,value as labelname  FROM t_psq_options where questionid='%@'",item.dicId]];
        else if([item.caption isEqualToString:@"分数"])
            list = [[DB instance] dictList:[data getString:@"dictvalue"]];
        else if([item.dataKey isEqualToString:@"IsDeal"])
        {
            if([[data getString:@"chanceid"] isEqualToString:@"3"])
                item.dicId=@"202";
            else
                item.dicId=@"191";
             list=[[DB instance] dictList:item.dicId];
        }
        else
            list=[[DB instance] dictList:item.dicId];
        for(NSMutableDictionary* data1 in list)
        {
            NSLog(@"字典值%@",[data1 getString:DICTVALUE]);
            
            NSLog(@"获取值%@",[data getString:item.dataKey]);
            if([[data1 getString:DICTVALUE] isEqualToString:[data getString:item.dataKey]])
                return [data1 getString:DICTITEMNAME];
        }
    }
    return @"";//[ isEqualToString:@""]?@"请选择":[data getString:item.dataKey];
}

-(NSString*)name1:(NSMutableDictionary*)data item:(D_UIItem*)item
{
    NSString* value=[data getString:item.dataKey];
    if(![value isEqualToString:@""])
    {
        NSMutableString *name = [NSMutableString stringWithFormat:@""];
        NSRange range;
        NSMutableArray* list;
        if(item.isSurverItem)
            list = [[DB instance] fieldListBy:[NSMutableString stringWithFormat:@"SELECT serverid as value,value as labelname  FROM t_psq_options where questionid='%@'",item.dicId]];
        else
            list=[[DB instance] dictList:item.dicId];
        for(NSMutableDictionary* data1 in list)
        {
            range=[[data getString:item.dataKey] rangeOfString:[NSString stringWithFormat:@"%@,",[data1 getString:DICTVALUE]]];
            if (range.length>0)
            {
                [name appendString:[data1 getString:DICTITEMNAME]];
                [name appendString:@","];
            }
        }
        //    NSLog(name);
        if (![name isEqualToString:@""])
            return name;
    }
    return @"";//[ isEqualToString:@""]?@"请选择":[data getString:item.dataKey];
}

- (void)buttonClicked:(id)sender
{
    if(delegate_DropView)
        [delegate_DropView delegate_clickButton:_item data:_field];
}

@end
