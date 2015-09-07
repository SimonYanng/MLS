//
//  C_DocmentCell.m
//  SFA1
//
//  Created by Ren Yong on 14-4-15.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_DocmentCell.h"
#import "F_Font.h"
#import "F_Color.h"
#import "NSMutableDictionary+Tool.h"
#import "Constants.h"
#import "NSMutableArray+Tool.h"
@interface C_DocmentCell ()
{
    UILabel* _caption;//显示内容
    UILabel* _description;//显示内容
    UILabel* _filesize;//显示内容
    UIImageView* _mainImg;
}
@end


@implementation C_DocmentCell

- (id)init:(NSMutableDictionary*) data
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
//        self.backgroundColor=col_White();
        [self initCaption:data];
//        [self initImage:data];
//        [self initDescription:data];
//        [self initFileSize:data];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}


-(void)initCaption:(NSMutableDictionary*) data
{
    _caption = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 220, 30)];
    _caption.backgroundColor = col_White();
    _caption.font = fontBysize(14);
    _caption.textAlignment=NSTextAlignmentLeft;
    _caption.numberOfLines=0;
    _caption.lineBreakMode = NSLineBreakByWordWrapping;
    _caption.text=[NSString stringWithFormat:@"%@%@(%@)",[data getString:@"attachmentname"],[data getString:@"attachmenttype"], [data getString:@"status"] ];
    
    [self addSubview:_caption];
}


-(void)refreshCaption:(NSMutableDictionary*) data
{
    _caption.text=[NSString stringWithFormat:@"%@%@(%@)",[data getString:@"attachmentname"],[data getString:@"attachmenttype"], [data getString:@"status"] ];
}

//-(void)initFileSize:(NSMutableDictionary*) data
//{
//    _filesize = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 220, 15)];
//    _filesize.backgroundColor = col_White();
//    _filesize.font = fontBysize(10);
//    _filesize.textAlignment=NSTextAlignmentLeft;
//    _filesize.textColor=col_LightGray();
//    _filesize.text=[NSString stringWithFormat:@"大小:%.1fK",[[data getString:@"filesize"] floatValue]/1024];
//    [self addSubview:_filesize];
//}

//-(void)initDescription:(NSMutableDictionary*) data
//{
//    _description = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, 220, 15)];
//    _description.backgroundColor = col_White();
//    _description.font = fontBysize(11);
//    _description.textAlignment=NSTextAlignmentLeft;
//    _description.numberOfLines=0;
//    _description.lineBreakMode = NSLineBreakByWordWrapping;
//    _description.text=[data getString:@"originalDocName"];
//    _description.textColor=col_LightGray();
//    [self addSubview:_description];
//}

//-(void)initImage:(NSMutableDictionary*) data
//{
//    _mainImg =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
//    NSString*logoUrl=[data getString:@"frontCoverPhotoPath"];
//    NSArray *arry=[logoUrl componentsSeparatedByString:@"/"];
//    NSString* logo=[arry objectAtIndex:[arry count]-1];
//    NSString* urlString=[NSString stringWithFormat:@"%@%@",[NSString stringWithString:NSTemporaryDirectory()],logo];
//    _mainImg.image=[UIImage imageWithContentsOfFile:urlString];
//    _mainImg.contentMode=UIViewContentModeScaleToFill;
////    _mainImg.layer.cornerRadius=CORNERRADIUS;
////    _mainImg.layer.borderColor=col_Button().CGColor;
////    _mainImg.layer.borderWidth=1;
//    [self addSubview:_mainImg];
//}


@end
