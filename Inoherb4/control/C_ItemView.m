//
//  C_ItemView.m
//  SFA
//
//  Created by Ren Yong on 13-11-14.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_ItemView.h"
#import "F_Color.h"
#import "C_Label.h"
#import "C_TextField.h"
#import "TOTextInputChecker.h"
@interface C_ItemView()
{
//    TOTextInputChecker * checker;
}
@end
@implementation C_ItemView
@synthesize lable,textField,checkBox,datePicker,pickView,takePhoto,delegate=_delegate,selectProduct;

- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data delegate:(NSObject<delegateView>*) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _delegate=delegate;
        [self initItem:frame item:item data:data delegate:delegate];
    }
    return self;
}

-(void) initItem:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data delegate:(NSObject<delegateView>*) delegate
{
    if(item.superViewColor)
        self.backgroundColor = item.superViewColor;
    self.layer.cornerRadius=CORNERRADIUS;
    int width=frame.size.width-5;
    int lableW=0;
    
    if(item.isShowCaption)
    {
        //        if (item.orientation==HORIZONTAL) {
//        lableW=width*item.lableWidth/100;
//        lable= [[C_Label alloc] initWithFrame: CGRectMake(20, 0, lableW, frame.size.height) item:item data:data];
//        [self addSubview:lable];
        //        }
        //        else  if (item.orientation==VERTICAL)
        //        {
                    lableW=width;
                    lable= [[C_Label alloc] initWithFrame: CGRectMake(10, 0, lableW, 20) item:item data:data];
                    [self addSubview:lable];
        //        }
        
        
    }
    

    
    int contentW=0;
    int contentH=0;
    int startW=0;
    int startH=0;
    //    if (item.orientation==HORIZONTAL)
    //    {
    
//    contentH=frame.size.height;
//    if(item.isMustInput)
//        startW=lableW+21;
//    else
//        startW=lableW+20;
//    contentW=width-startW;
//    startH=0;
    //    }
    //    else
    //    {
            contentW=width-10;
            contentH=frame.size.height-20;
            startW=10;
            startH=20;
    
    if(item.isMustInput)
    {
        lable= [[C_Label alloc] initWithFrame: CGRectMake(startW-1, 20+15, 1, 20) label:@""];
        lable.backgroundColor=[UIColor redColor];
        [self addSubview:lable];
    }
    //    }
    NSLog(@"开始:%d-----宽:%d----高:%d----开始高度:%d",startW,contentW,contentH,startH);
    switch (item.controlType) {
        case TEXT:
            textField = [[C_TextField alloc] initWithFrame: CGRectMake(startW, startH, contentW, contentH) item:item data:data];
            [self addSubview:textField];
            
//            [self addCheck:item textField:textField];
            
            textField=nil;
            break;
        case TAKEPHOTO:
            takePhoto = [[C_GradientButton alloc] initWithFrame: CGRectMake(startW, startH, contentW, contentH) ];
            
            if([data getInt:@"photoCount"]>0)
                [takePhoto setTitle:[NSString    stringWithFormat:@"拍摄照片(已拍%d张)", [data getInt:@"photoCount"]] forState:UIControlStateNormal];
            else
                [takePhoto setTitle:@"拍摄照片" forState:UIControlStateNormal];
            [takePhoto useToStyle];
            [takePhoto addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:takePhoto];
//            textField=nil;
            break;
            
        case SELECTPRODUCT:
            selectProduct = [[C_GradientButton alloc] initWithFrame: CGRectMake(startW, startH, contentW, contentH) ];
            
            [selectProduct setTitle:item.caption forState:UIControlStateNormal];
            [selectProduct useToStyle];
            [selectProduct addTarget:self action:@selector(selectProduct:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:selectProduct];
//            textField=nil;
            break;
            
            
            
            
        case CHECKBOX:
            checkBox = [[ C_CheckBox alloc] initWithFrame:CGRectMake(startW, startH, contentW, contentH) item:item data:data];
            checkBox.delegate = delegate;
            [self addSubview:checkBox];
            checkBox=nil;
            break;
            
        case DATE:
            datePicker = [[ C_DatePicker alloc] initWithFrame:CGRectMake(startW, startH, contentW, contentH) item:item data:data];
            [self addSubview:datePicker];
            datePicker=nil;
            break;
        case TIME:
            datePicker = [[ C_DatePicker alloc] initWithFrame:CGRectMake(startW, startH, contentW, contentH) item:item data:data];
            [self addSubview:datePicker];
            datePicker.delegate=delegate;
            datePicker=nil;
            break;
            
        case DATETIME:
            datePicker = [[ C_DatePicker alloc] initWithFrame:CGRectMake(startW, startH, contentW, contentH) item:item data:data];
            [self addSubview:datePicker];
            datePicker=nil;
            break;
        case SINGLECHOICE:
            pickView = [[ C_DropView alloc] initWithFrame: CGRectMake(startW, startH, contentW, contentH) item:item data:data];
            pickView.delegate_DropView=delegate;
            [self addSubview:pickView];
            pickView=nil;
            break;
        case MULTICHOICE:
            pickView = [[ C_DropView alloc] initWithFrame: CGRectMake(startW, startH, contentW, contentH) item:item data:data];
            pickView.delegate_DropView=delegate;
            [self addSubview:pickView];
            pickView=nil;
            break;
            
        default:
            lable= [[C_Label alloc] initWithFrame: CGRectMake(startW, 10, contentW, contentH) data:data item:item ];
            if(!item.isShowCaption||contentH>70)
            {
                lable.textAlignment=NSTextAlignmentNatural;
                lable.numberOfLines=0;
                lable.lineBreakMode=NSLineBreakByWordWrapping;
                if (!item.isShowCaption) {
                    //                    [self sizeToFit];
                    [lable sizeToFit];
                    
                    NSLog(@"高度%f",lable.frame.size.height);
                }
                if (item.isShowCaption) {
                    lable.textColor = col_Button();
                }
            }
            else
                lable.textColor = col_Button();
            [self addSubview:lable];
            break;
    }
    
}

//
//-(void)addCheck:(D_UIItem*)item textField:(C_TextField*)textField1
//{
//    if(item.verifyType==AMOUNT)
//    {
//        checker = [[TOTextInputChecker alloc ]moneyChecker:0.00f max:999999.00f];
////        checker.backgroundNomarl = @"input_bg_nomarl_out.png";
////        checker.backgroundHighlighted = @"input_bg_nomarl_on.png";
////        checker.backgroundError = @"input_bg_error_out.png";
////        checker.backgroundErrorHighlighted = @"input_bg_error_on.png";
//        textField1.delegate = checker;
////        [textField1 setBackground:[UIImage imageNamed:@"input_bg_nomarl_out.png"]];
//    }
//}

-(void)takePhoto:(id)sender
{
     C_GradientButton* button=(C_GradientButton*)sender;
    if(_delegate)
        [_delegate delegate_takePhoto:button];
}

-(void)selectProduct:(id)sender
{
    C_GradientButton* button=(C_GradientButton*)sender;
    if(_delegate)
        [_delegate delegate_selectProduct:button.titleLabel.text];
}


-(CGFloat)cellHight
{
    if(lable)
        return lable.frame.size.height;
    return self.frame.size.height;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
-(void)dealloc {
    //[super dealloc];
}

@end