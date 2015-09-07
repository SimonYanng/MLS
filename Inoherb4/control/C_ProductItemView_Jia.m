//
//  C_ProductItemView.m
//  Inoherb4
//
//  Created by Ren Yong on 14-2-18.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_ProductItemView_Jia.h"
#import "F_Color.h"
#import "C_Label.h"
#import "C_TextField.h"
#import "F_Phone.h"
#import "F_Color.h"
#import "C_ClientInfo.h"
#import "F_Template.h"
#import "NSMutableArray+Tool.h"
#import "C_CheckBox.h"

@interface C_ProductItemView_Jia()
{
    C_ClientInfo* _clientInfo;
    NSMutableDictionary* _selectClient;
}
@end

@implementation C_ProductItemView_Jia

@synthesize lable,textField,datePicker,pickView,shotPhoto,delegate=_delegate;

- (id)initWithFrame:(CGRect)frame field:(NSMutableDictionary*)field panel:(D_Panel*)panel delegate:(NSObject<delegateView>*) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectClient=field;
        _delegate=delegate;
        // Initialization code
        //        [self initItem:frame item:item data:data delegate:delegate];
        //        self.backgroundColor=col_Background();
        
        [self addItem_Jia:panel field:field delegate:delegate];
    }
    return self;
}

-(void)addItem_Jia:(D_Panel*)panel field:(NSMutableDictionary*)field delegate:(NSObject<delegateView>*) delegate
{
    int width=screenW();
    
    D_UIItem* item;
    item=[panel itemAt:0];
    
    int line_height = 30;
//    int checkBoxHeight = 40;
    
    C_Label* lable_0 = [[C_Label alloc] initWithFrame:CGRectMake(0, 0, width, line_height) data:field item:item];
    lable_0.textAlignment = NSTextAlignmentLeft;
    lable_0.text = [NSString stringWithFormat:@"  %@",[field getString:item.dataKey]];
    [self addSubview:lable_0];
    
    item=[panel itemAt:1];
    C_Label* lable_1 = [[C_Label alloc] initWithFrame:CGRectMake(0, line_height, width/5, line_height) data:field item:item];
    lable_1.textAlignment = NSTextAlignmentLeft;
    lable_1.text =[NSString stringWithFormat:@"  %@",[field getString:item.dataKey]];
    [self addSubview:lable_1];
    
    item=[panel itemAt:2];
    C_Label* lable_2 = [[C_Label alloc] initWithFrame:CGRectMake(lable_1.frame.origin.x+lable_1.frame.size.width, line_height, width-lable_1.frame.size.width-100, line_height) data:field item:item];
    lable_2.textAlignment = NSTextAlignmentLeft;
    lable_2.text =[NSString stringWithFormat:@"  %@",[field getString:item.dataKey]];
    [self addSubview:lable_2];
    
//    C_CheckBox *checkBox = [[C_CheckBox alloc] initWithFrameNoLabel:CGRectMake(width - checkBoxHeight - 10, 10, checkBoxHeight, checkBoxHeight) item:item data:field Size:30 callBackWithData:NO];
//    checkBox.delegate = delegate;
    
//    [self addSubview:checkBox];
    
}

-(void)addItem:(D_Panel*)panel field:(NSMutableDictionary*)field delegate:(NSObject<delegateView>*) delegate
{
    int width=screenW();
    int lableW=0;
    int oldLableW=0;
    int count=[panel itemCount];
    
    D_UIItem* item;
    //    C_Label*  lable;
    //    C_TextField* textField;
    for (int i=0; i<count; i++) {
        item=[panel itemAt:i];
        lableW=width*item.lableWidth/100;
        
        switch (item.controlType) {
            case NONE:
                lable=[[C_Label alloc] initWithFrame:CGRectMake(oldLableW, 0, lableW, 50) data:field item:item];
                //                lable.backgroundColor=[UIColor whiteColor];
                lable.textAlignment=item.textAlignment;
                if(item.textAlignment==NSTextAlignmentLeft)
                    lable.text =[NSString stringWithFormat:@"  %@",[field getString:item.dataKey]];
                //                [lable setUserInteractionEnabled:YES];
                [self addSubview:lable];
                break;
                
            case BUTTON:
            {
                lable=[[C_Label alloc] initWithFrame: CGRectMake(oldLableW, 0, lableW, 50)  data:field item:item];
                //                lable.backgroundColor=[UIColor whiteColor];
                lable.textAlignment=item.textAlignment;
                
                lable.text =item.caption;
                
                lable.userInteractionEnabled=YES;
                UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
                
                [lable addGestureRecognizer:labelTapGestureRecognizer];
                [self addSubview:lable];
            }
                break;
            case TEXT:
                textField = [[C_TextField alloc] initWithFrame: CGRectMake(oldLableW+5, 0, lableW-10, self.frame.size.height) item:item data:field];
                textField.backgroundColor=col_Background();
                [textField.layer setCornerRadius:CORNERRADIUS];
                [self addSubview:textField];
                break;
            case SHOTPHOTO:
                shotPhoto = [[C_GradientButton alloc] initWithFrame: CGRectMake(oldLableW+5, 5, lableW-10, self.frame.size.height-10)];
                [shotPhoto setTitle:@"拍照" forState:UIControlStateNormal];
                [shotPhoto useToStyle];
                //                shotPhoto.tag=[field getInt:@"serverid"];
                [shotPhoto addTarget:self action:@selector(shotPhoto:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:shotPhoto];
                
                break;
                
                
            case SINGLECHOICE:
                pickView = [[C_DropView alloc] initWithFrame: CGRectMake(oldLableW+5, 0, lableW-10, self.frame.size.height) item:item data:field];
                //                pickView.backgroundColor=col_Background();
                //                [pickView.layer setCornerRadius:CORNERRADIUS];
                pickView.delegate_DropView=delegate;
                [self addSubview:pickView];
                break;
            default:
                break;
        }
        
        oldLableW+=lableW;
    }
}

-(void)shotPhoto:(id)sender
{
    C_GradientButton* button=(C_GradientButton*)sender;
    if(_delegate)
        [_delegate delegate_shotPhoto:_selectClient button:button];
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    C_Label *label=(C_Label*)recognizer.view;
    NSLog(@"%@被点击了",label.text);
    [self endEditing:YES];
    //    toast_showInfoMsg(label.text, 100);
    [self showClientInfo];
    
}

-(void)showClientInfo
{
    if(_clientInfo)
    {
        [_clientInfo cancelPicker];
        _clientInfo=nil;
    }
    _clientInfo=[[C_ClientInfo alloc] init:CGRectMake(0, 0, screenW(), screenH())  panelList:[self panelList] data:_selectClient];
    //    _clientInfo.delegate_clientInfo=self;
    [_clientInfo showInView:self.superview.superview.superview.superview];
}


-(NSMutableArray*)panelList
{
    NSMutableArray* panelList=[[NSMutableArray alloc]init];
    
    D_Panel*  panel=[[D_Panel alloc]init];
    panel.name=@"基本信息";
    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"编码";
    item.controlType=NONE;
    item.dataKey=@"outletcode";
    item.dicId=@"70";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"名称";
    item.controlType=NONE;
    item.dataKey=@"name";
    item.dicId=@"185";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"地址";
    item.controlType=NONE;
    item.dataKey=@"address";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"渠道";
    item.controlType=NONE;
    item.dataKey=@"str1";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    item=[[D_UIItem alloc]init];
    item.caption=@"省份";
    item.controlType=NONE;
    item.dataKey=@"str2";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    item=[[D_UIItem alloc]init];
    item.caption=@"城市";
    item.controlType=NONE;
    item.dataKey=@"str3";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"销售组织";
    item.controlType=NONE;
    item.dataKey=@"str4";
    item.dicId=@"-100";
    item.lableWidth=100;
    [panel addItem:item];
    
    [panelList addPanel:panel];
    return panelList;
}
@end

