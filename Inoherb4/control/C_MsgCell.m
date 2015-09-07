//
//  C_MsgCell.m
//  Inoherb4
//
//  Created by Ren Yong on 14-6-10.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_MsgCell.h"
#import "F_Image.h"
#import "F_Font.h"
#import "F_Color.h"
#import "Constants.h"
#import "DB.h"
#import "F_Template.h"
#import "GTMBase64.h"
#import "F_Date.h"
@implementation C_MsgCell

- (id)init:(NSMutableDictionary*) data
{
    
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.backgroundColor=col_White();
        _data=data;
        [self initStatus];
        [self initTitle];
        [self initDate];
        
//        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)initStatus
{
    
    NSLog(@"-------------%@",[_data getString:@"status"]);
    
    _status = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*15/100, 50)];

    _status.backgroundColor = col_White();
    _status.font = fontBysize(13);
    _status.textAlignment=NSTextAlignmentCenter;
    
    _status.text=[NSString stringWithFormat:@"%@",[_data getString:@"status"] ];//[_data getString:@""];
    [self addSubview:_status];
}

-(void)initTitle
{
    _caption = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*15/100, 0, self.frame.size.width*60/100, 50)];
    
    _caption.backgroundColor = col_White();
    _caption.font = fontBysize(13);
    _caption.textAlignment=NSTextAlignmentLeft;
    
    _caption.text=[NSString stringWithFormat:@"%@",[_data getString:@"title"] ];
    [self addSubview:_caption];
}

-(void)initDate
{
    _time = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*75/100, 0, self.frame.size.width*25/100, 50)];
    
    _time.backgroundColor = col_White();
    _time.font = fontBysize(13);
    _time.textAlignment=NSTextAlignmentCenter;
    
    _time.text=[[_data getString:@"stime"] substringToIndex:10];
    [self addSubview:_time];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
