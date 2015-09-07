//
//  C_CellRpt.m
//  Inoherb
//
//  Created by Bruce on 15/3/30.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "C_CellRpt.h"
#import "F_Image.h"
#import "C_ImageView.h"
#import "F_Font.h"
#import "F_Color.h"
#import "NSMutableDictionary+Tool.h"


@interface C_CellRpt ()
{
    C_ImageView*_checkImg;
    D_Template* _template;
}
@end

@implementation C_CellRpt

- (id)initWithFrame:(CGRect)frame template:(D_Template*)template
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _template=template;
        [self initStatus];
        [self initCaption];
    }
    return self;
}

-(void)initStatus
{
    UIImage* image=img_UnCall();
    _checkImg =[[C_ImageView alloc]initWithFrame:CGRectMake(20, (self.frame.size.height - image.size.height) / 2, 15, 15) image:image];
    [self addSubview:_checkImg];
}

-(void)initCaption
{
   UILabel* caption = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 200, self.frame.size.height)];
    caption.backgroundColor = col_ClearColor();
    caption.font =fontBysize(14);
    caption.textColor = col_DarkText();
    caption.text=_template.name;
    caption.textAlignment=NSTextAlignmentLeft;
    [self addSubview:caption];
    
//    UIView* line=[[UIView alloc] initWithFrame:CGRectMake(15, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
//    line.backgroundColor=col_LightGray();
//    [self addSubview:line];
}

-(void)refresh:(NSMutableArray*)listTempStatus
{
    for (NSMutableDictionary* temp in listTempStatus) {
        
        if([temp getInt:@"onlytype"] ==_template.onlyType)
        {
            _checkImg.image=img_Checked();
            break;
        }
    }
}

@end
