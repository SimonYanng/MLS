//
//  C_DatePicker.m
//  Inoherb4
//
//  Created by Ren Yong on 14-2-14.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_DatePicker.h"
#import "F_Date.h"
#import "F_Phone.h"
#import "F_Color.h"
#import "F_Font.h"
#import "F_Image.h"
#import "NSMutableDictionary+Tool.h"
@implementation C_DatePicker

@synthesize delegate;
-(UIDatePicker*)datePicker
{
    return datePicker;
}

-(UITextField*)textField
{
    return textField;
}

-(NSDate*)date
{
    return date;
}

-(void)setDate:(NSDate *)d
{
    date=d;
    datePicker.date=date;
}

-(NSDateFormatter*)dateFormatter
{
    return dateFormatter;
}

-(void)setDateFormatter:(NSDateFormatter *)df
{
    dateFormatter=df;
    textField.text=[dateFormatter stringFromDate:date];
}

-(UIDatePickerMode)datePickerMode
{
    return datePickerMode;
}

-(void)setDatePickerMode:(UIDatePickerMode)mode
{
    datePickerMode=mode;
    datePicker.datePickerMode=datePickerMode;
}

- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)uiItem data:(NSMutableDictionary*)userData
{
    
    item=uiItem;
    field=userData;
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
        //        date=[NSDate date];
        //默认日期格式为yyyy-MM-dd
        dateFormatter= [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];//location设置为中国
        if(uiItem.controlType==DATE)
        {
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            datePickerMode=UIDatePickerModeDate;
            
        }
        else  if(uiItem.controlType==TIME)
        {
            [dateFormatter setDateFormat:@"HH:mm"];
            datePickerMode=UIDatePickerModeTime;
        }
        else  if(uiItem.controlType==DATETIME)
        {
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            datePickerMode=UIDatePickerModeDateAndTime;
        }
        //        else if
        //构造一个子视图,用于显示日期选择器
        subview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,screenH())];
        subview.backgroundColor=col_Black1();
        
        //        [subview setUserInteractionEnabled:YES];
        //        [subview addGestureRecognizer:UIGestureRecognizerStateRecognized];
        subview.tag=0;
        //为子视图构造工具栏按钮
        UIButton* button=[[UIButton alloc] initWithFrame:CGRectMake(20, 0, 280, 44)];
        //        label.text=@"确定";
        //        label.textAlignment=NSTextAlignmentRight;
        //        [label.titleLabel setFont:font_NavButton()];//设置显示字体
        [button setTitleColor:col_buttonColor() forState:UIControlStateNormal];
        [button setTitle:@"确定" forState:UIControlStateNormal];//设置显示内容
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];//设置文字的对其方式
        [button addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
        //        UIBarButtonItem* item = [[UIBarButtonItem alloc]
        //                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
        //                                  target:self action:@selector(btnCloseClick)];
        UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        NSArray* buttons=[NSArray arrayWithObjects:buttonItem,nil];
        //为子视图构造工具栏
        UIToolbar *subToolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, screenH()-240, 320, 44)];
        subToolbar.barStyle = UIBarStyleDefault;
        [subToolbar sizeToFit];
        [subToolbar setItems:buttons animated:YES]; //把按钮加入工具栏
        [subview addSubview:subToolbar];//把工具栏加入子视图
        //为子视图构造datePicker
        datePicker=[[UIDatePicker alloc]init];
        
        datePicker.frame=CGRectMake(0, screenH()-240+44, 320, 216);
        datePicker.datePickerMode=datePickerMode;
        datePicker.backgroundColor=[UIColor whiteColor];
        //指定datepicker的valueChanged事件
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        [subview addSubview:datePicker]; //把datePicker加入子视图
        //上面是子视图，下面是父视图
        //文本框
        textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 5, frame.size.width, frame.size.height-10)];
        textField.delegate=self;
        textField.enabled=YES;
        textField.textAlignment=NSTextAlignmentLeft;
        textField.borderStyle=UITextBorderStyleNone;
        [textField setBackgroundColor:col_Background()];
        textField.layer.cornerRadius=CORNERRADIUS;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 8, frame.size.height)];//左端缩进15像素
        textField.leftView = view;
        textField.leftViewMode =UITextFieldViewModeAlways;
        
        UIImage* img=img_Triangle();
        UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(textField.frame.size.width-img.size.width-5, (textField.frame.size.height-img.size.height)/2, img.size.width, img.size.height)]; //] initWithImage:img_MustInput()];
        imgv.image=img;
        [textField addSubview:imgv];
        
        //picker的默认时间为当前时间
        NSString* d=[userData getString:uiItem.dataKey];
        if([d isEqualToString:@""])
        {
            date=[NSDate date];
//            textField.text=[dateFormatter stringFromDate:date];
        }
        else
        {
            if(uiItem.controlType==DATE)
                date=string2Date(d);
            else  if(uiItem.controlType==DATETIME)
                date=string2DateTime(d);
            else
                date=string2Time(d);
            textField.text=d;
        }
//        [self setData:textField.text];
        textField.font= fontBysize(14);
        textField.textColor=col_DarkText();
        [self addSubview:textField];
        
        [datePicker setDate:date];
    }
    return self;
}

//当datepicker的值改变时触发
-(void)dateChanged:(id)sender{
    date = [sender date];//获取datepicker的日期
    //改变textField的值
    NSString* selectDate=[NSString stringWithString:
                          [dateFormatter stringFromDate:date]];
    BOOL result = [item.maxDate compare:selectDate]== NSOrderedAscending;
    if(result)
    {
        [datePicker setDate:string2Date(item.maxDate)];
        textField.text=item.maxDate;
    }
    else
        textField.text=selectDate;
    
    [self setData:textField.text];
    
    if(delegate)
        [delegate delegate_dateChanged];
}

-(void)setData:(NSString*)value
{
    [field put:value key:item.dataKey];
}

//关闭按钮点击时触发
-(void)btnCloseClick{
    
    date = [datePicker date];//获取datepicker的日期
    //改变textField的值
    NSString* selectDate=[NSString stringWithString:
                          [dateFormatter stringFromDate:date]];
    BOOL result = [item.maxDate compare:selectDate]== NSOrderedAscending;
    if(result)
    {
        [datePicker setDate:string2Date(item.maxDate)];
        textField.text=item.maxDate;
    }
    else
        textField.text=selectDate;
    
    [self setData:textField.text];
    
    if(delegate)
        [delegate delegate_dateChanged];
    
    if(subview!=nil){
        subview.tag=0;
        [subview removeFromSuperview];
    }
}

- (void)dealloc {
    
    //    [textField release];
    //
    //    [date release];
    //
    //    [dateFormatter release];
    //
    //    [datePicker release];
    //
    //    [subview release];
    //
    //    [super dealloc];
    
}

#pragma mark textField delegate method
//当textField被点击时触发
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (subview.tag==0) {//若tag标志等于0，说明datepicker未显示
        
        [self.superview.superview.superview.superview.superview.superview.superview  endEditing:YES];
        //置tag标志为1，并显示子视图
        subview.tag=1;
        [self.superview.superview.superview.superview.superview.superview.superview addSubview:subview];
    }
    return NO;
}
@end
