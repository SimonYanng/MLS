//
//  C_SkuViewCell.m
//  Shequ
//
//  Created by Ren Yong on 14-1-12.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_SkuViewCell.h"
#import "F_Image.h"
#import "F_Font.h"
#import "F_Color.h"
#import "Constants.h"
#import "DB.h"
#import "F_Template.h"
#import "GTMBase64.h"
#import "F_Date.h"
#import "NSMutableDictionary+Tool.h"
@implementation C_SkuViewCell

- (id)init:(NSMutableDictionary*) data
{
    _data=data;
    NSMutableDictionary* field=[NSMutableDictionary dictionary];
    [field put:today() key:@"date"];
    _photo=[[DB instance] curRpt:temp_ById([_data getString:@"TemplateId"],@"") field:field];
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor=col_White();
//        [self initCaption];
        [self initPrice];
//        [self initOldPrice];
        [self initImage];
//        [self initAccessoryImage];
//        [self initAddButton];
    }
    return self;
}

-(void)refresh
{
    NSMutableDictionary* field=[NSMutableDictionary dictionary];
    [field put:today() key:@"date"];
    _photo=[[DB instance] curRpt:temp_ById([_data getString:@"TemplateId"],@"") field:field];
    NSString* title=[_data getString:@"title"];
    
    if ([[_data getString:@"TemplateId"] isEqualToString:@"3"]) {
        if(_photo.isSaved)
            title=[NSString stringWithFormat:@"%@:\r%@-%@",[_data getString:@"title"],[_photo getString:@"str4"],[_photo getString:@"str5"] ];
        _price.text=title;
    }
    else
    {
    if([_photo attSize]>0)
    {
        title=[NSString stringWithFormat:@"%@:\r%@",[_data getString:@"title"],[[[_photo attFieldAt:0] getString:@"shottime"] substringFromIndex:11]];
        _price.text=title;
        
        NSString *testString = [[_photo attFieldAt:0] getString:@"photo"];
        NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
        
        testData = [GTMBase64 decodeData:testData];
        
        _mainImg.image = [UIImage imageWithData: testData];
        _mainImg.contentMode=UIViewContentModeScaleToFill;
    }
    
    else
    {
        _price.text=[_data getString:@"title"];
        _mainImg.image=[UIImage imageNamed:@"photo.png"];
        _mainImg.contentMode=UIViewContentModeCenter;
        
    }
    }
}

//-(void)initCaption
//{
//    CGSize labelSize = [[_data getString:@"title"] sizeWithFont:font_NavButton()
//                       constrainedToSize:CGSizeMake(200, 40)
//                           lineBreakMode:NSLineBreakByCharWrapping];
//    
//    _caption = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, labelSize.width, labelSize.height)];
//    _caption.backgroundColor = col_ClearColor();
//    _caption.numberOfLines=0;
//    _caption.lineBreakMode = NSLineBreakByCharWrapping;
//    _caption.font = font_NavButton();
//    _caption.textColor = col_DarkText();
//    _caption.text=[_data getString:@"title"];
//    _caption.textAlignment=NSTextAlignmentLeft;
//    [self addSubview:_caption];
//}


//-(void)initCaption
//{
//    _caption = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 180, 140)];
//    _caption.backgroundColor = col_buttonColor();
////    _caption.layer.cornerRadius=CORNERRADIUS;
//    [self addSubview:_caption];
//}

-(void)initPrice
{
    NSString* title=[_data getString:@"title"];
    
    if ([[_data getString:@"TemplateId"] isEqualToString:@"3"]) {
        if(_photo.isSaved)
                title=[NSString stringWithFormat:@"%@:\r%@-%@",[_data getString:@"title"],[_photo getString:@"str4"],[_photo getString:@"str5"] ];
        _price.text=title;
    }
    else
    {
    if([_photo attSize]>0)
        title=[NSString stringWithFormat:@"%@:\r%@",[_data getString:@"title"],[[[_photo attFieldAt:0] getString:@"shottime"] substringFromIndex:11]];
    }
    
    _price = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 180, 180)];
    _price.layer.borderColor=col_Button().CGColor;
    _price.layer.borderWidth=0.5;
    _price.backgroundColor = col_White();
    _price.font = fontBysize(18);
    _price.textAlignment=NSTextAlignmentCenter;
//    _price.textColor = [UIColor blackColor];
    
    _price.numberOfLines=0;
    _price.lineBreakMode = NSLineBreakByCharWrapping;
    _price.text=title;
    
    
//    _price.layer.cornerRadius=CORNERRADIUS;
    [self addSubview:_price];
}



-(void)initImage
{
    _mainImg =[[UIImageView alloc]initWithFrame:CGRectMake(180, 10, 120, 180)];
    _mainImg.backgroundColor=col_buttonColor();
    
    if([_photo attSize]>0)
    {
        NSString *testString = [[_photo attFieldAt:0] getString:@"photo"];
        NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
        
        testData = [GTMBase64 decodeData:testData];
        
        _mainImg.image = [UIImage imageWithData: testData];
        _mainImg.contentMode=UIViewContentModeScaleToFill;
    }
    else
    {
        _mainImg.image=[UIImage imageNamed:@"photo.png"];
        _mainImg.contentMode=UIViewContentModeCenter;
    }
    
//    _mainImg.layer.cornerRadius=CORNERRADIUS;
    [self addSubview:_mainImg];
}

//-(void)initAccessoryImage
//{
//    _accessImg =[[UIImageView alloc]initWithFrame:CGRectMake(100, 40, 20, 20)];
//    _accessImg.image=img_Pin();
//    [self addSubview:_accessImg];
//    
//    _accessImg =[[UIImageView alloc]initWithFrame:CGRectMake(125, 40, 20, 20)];
//    _accessImg.image=img_Pin();
//    [self addSubview:_accessImg];
//}

//-(void)initAddButton
//{
//    _addSku =[[UIButton alloc]initWithFrame:CGRectMake(270, 45, 30, 30)];
//    UIImageView* icon =[[UIImageView alloc] initWithFrame: CGRectMake (0,0,30,30)];
//    icon.image= img_Add();
//    [_addSku addSubview:icon];
//    [self addSubview:_addSku];
//    
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
