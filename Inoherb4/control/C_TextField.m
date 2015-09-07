//
//  C_TextField.m
//  SFA
//
//  Created by Ren Yong on 13-10-21.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_TextField.h"
#import "F_Color.h"
#import "F_Alert.h"
#import "F_Font.h"
#import "F_Image.h"
#import "C_Toast.h"
#import "D_Operation.h"
#import "NSMutableDictionary+Tool.h"
#import "TOTextInputChecker.h"

@interface C_TextField ()
{
    TOTextInputChecker * checker;
}
@end

@implementation C_TextField

@synthesize field,uiItem;

- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data
{

    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+5,frame.size.width, frame.size.height-10)];
    if (self) {
        
        field=data;
        uiItem=item;
        // Initialization code
        [self setBorderStyle:UITextBorderStyleNone];
        [self setFont:fontBysize(14)];
        if(!item.superViewColor)
        {
            [self setBackgroundColor:col_Background()];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 8, frame.size.height)];//左端缩进15像素
            self.leftView = view;
            self.leftViewMode =UITextFieldViewModeAlways;
        }
        
        [self setText:[self result:data item:item]];
        [self setTextColor:col_DarkText()];
        if(![item.placeholder isEqualToString:@""])
            [self setPlaceholder:[NSMutableString stringWithFormat:@"点击输入%@",item.placeholder]];
//            [self setPlaceholder:@"点击输入"];
        if(item.isSecureTextEntry)
            [self setSecureTextEntry:YES];
        [self setReturnKeyType:UIReturnKeyDone];//改变按钮
        //        [self setAdjustsFontSizeToFitWidth:YES];
        [self setMinimumFontSize:8];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];//内容居中
        [self setTextAlignment:NSTextAlignmentLeft];
//        [self setInputType:item];
        [self setKeyboardAppearance:UIKeyboardAppearanceDefault];//键盘外观
        //        [self setAutocapitalizationType:UITextAutocapitalizationTypeWords];//自动大小写
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        //再次编辑就清空
        self.clearsOnBeginEditing = NO;
//        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged ];
        self.layer.cornerRadius=CORNERRADIUS;

//        [self addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self setAdjustsFontSizeToFitWidth:YES];
        [self addCheck];

    }
    return self;
}


-(void)addCheck
{
    switch (uiItem.verifyType) {
        case AMOUNT:
            checker = [TOTextInputChecker moneyChecker:0.00f max:999999.00f];
            //        checker.backgroundNomarl = @"input_bg_nomarl_out.png";
            //        checker.backgroundHighlighted = @"input_bg_nomarl_on.png";
            //        checker.backgroundError = @"input_bg_error_out.png";
            //        checker.backgroundErrorHighlighted = @"input_bg_error_on.png";
            self.delegate = checker;
            break;
            
        case NUMBER:
            checker = [TOTextInputChecker  intChecker:0 max:999999];
            //        checker.backgroundNomarl = @"input_bg_nomarl_out.png";
            //        checker.backgroundHighlighted = @"input_bg_nomarl_on.png";
            //        checker.backgroundError = @"input_bg_error_out.png";
            //        checker.backgroundErrorHighlighted = @"input_bg_error_on.png";
            self.delegate = checker;
            break;
            
        case PHONE:
            checker = [TOTextInputChecker  telChecker:YES];
            //        checker.backgroundNomarl = @"input_bg_nomarl_out.png";
            //        checker.backgroundHighlighted = @"input_bg_nomarl_on.png";
            //        checker.backgroundError = @"input_bg_error_out.png";
            //        checker.backgroundErrorHighlighted = @"input_bg_error_on.png";
            self.delegate = checker;
            break;
            
        case EMAIL:
            checker = [TOTextInputChecker  mailChecker:YES];
            //        checker.backgroundNomarl = @"input_bg_nomarl_out.png";
            //        checker.backgroundHighlighted = @"input_bg_nomarl_on.png";
            //        checker.backgroundError = @"input_bg_error_out.png";
            //        checker.backgroundErrorHighlighted = @"input_bg_error_on.png";
            self.delegate = checker;
            break;
            
        case DEFAULT:
            checker = [TOTextInputChecker  defaultChecker];
            //        checker.backgroundNomarl = @"input_bg_nomarl_out.png";
            //        checker.backgroundHighlighted = @"input_bg_nomarl_on.png";
            //        checker.backgroundError = @"input_bg_error_out.png";
            //        checker.backgroundErrorHighlighted = @"input_bg_error_on.png";
            self.delegate = checker;
            break;
            
        default:
            break;
    }

}

/**
 [""]	保存填写的内容
 [""]	@param data <#data description#>
 [""]	@param item <#item description#>
 [""]	@returns <#return value description#>
 [""] */
-(void)setData:(NSString*) result
{
    [field put:result key:uiItem.dataKey];
}

/**
[""]	获取数据
[""]	@param data <#data description#>
[""]	@param item <#item description#>
[""]	@returns <#return value description#>
[""] */
-(NSString*)result:(NSMutableDictionary*)data item:(D_UIItem*)item
{
    return [data getString:item.dataKey];
}

@end
