//
//  Frm_InputListDetail.m
//  ManonYw
//
//  Created by Bruce on 15/8/8.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "Frm_InputListDetail.h"
#import "C_ImageView.h"
#import "C_NavigationBar.h"
#import "C_Button.h"
#import "F_Color.h"
//#import "C_InputView.h"
#import "F_Image.h"
#import "C_TempView.h"
#import "F_Alert.h"
#import "NSMutableDictionary+Tool.h"
#import "C_MutiPickerView.h"
@interface Frm_InputListDetail ()
{
    NSMutableDictionary *_product;
    D_Panel* _panel;
    NSMutableDictionary* _newProduct;
    
    C_InputView* _inputView;
}

@end

@implementation Frm_InputListDetail


-(id)initWith:(NSMutableDictionary*)productInfo panel:(D_Panel*)panel
{
    self = [super init];
    if(self)
    {
        [self initInputField:productInfo];
        _product=productInfo;
        _panel=panel;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)initInputField:(NSMutableDictionary*)field
{
    _newProduct=[[NSMutableDictionary alloc]init];
    NSString* value;
    for(NSString *key in field) {
        value = [field getKeyString:key];
        [_newProduct put:value key:key];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyboard];
}


-(void)initUI
{
    self.view.backgroundColor = col_Background();
//    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithTitle:@"产品填写"];
//    [self.view addSubview:bar];
//    C_Button* back=[[C_Button alloc] initWithFrame:@"取消"];
//    C_ImageView *backView = [[C_ImageView alloc] initWithFrame:img_Back()];
//    [back addSubview:backView];
//    [back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchDown];
//    [bar addLeftButton:back];
//    
//    C_Button* save=[[C_Button alloc] initWithFrame:@"确定"];
//    [save addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchDown];
//    [bar addRightButton:save];
//    
    
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"产品填写"];
    [self.view addSubview:bar];
    
    C_GradientButton* btn_Hoc=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Hoc setTitle:@"确定" forState:UIControlStateNormal];
    [btn_Hoc useAddHocStyle];
    [btn_Hoc addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addRightButton:btn_Hoc];
    
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) buttonId:-1];
    [btn_Back setTitle:@"" forState:UIControlStateNormal];
    [btn_Back useImgStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    
//    tableViewHeight=self.view.frame.size.height-SYSTITLEHEIGHT;
    
    _inputView = [[C_InputView alloc] initWithFrame:CGRectMake(0, SYSTITLEHEIGHT, self.view.frame.size.width, self.view.frame.size.height-SYSTITLEHEIGHT) panel:_panel field:_newProduct];
    _inputView.delegate_View=self;
    [self.view addSubview:_inputView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveClicked:(id)sender
{
    [self.view endEditing:YES];
    [self reloadOldField:_newProduct];
    [_product put:@"Y" key:@"isInput"];
    //    toast_showInfoMsg(@"保存成功",100);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)delegate_selected
{
    if(_inputView)
        [_inputView reloadData];
    //    [self dismissKeyboard];
}

-(void)reloadOldField:(NSMutableDictionary*)field
{
    NSString* value;
    for(NSString *key in field) {
        value = [field getKeyString:key];
        [_product put:value key:key];
    }
}

-(void)dismissKeyboard
{
    [[self view] endEditing:YES];
}

-(void)showMutiPickerView:(D_UIItem *)item data:(NSMutableDictionary *)data
{
    C_MutiPickerView* pickerView=[[C_MutiPickerView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height) item:item data:data];
    pickerView.delegate=self;
    [pickerView showInView:self.view];
}


-(void)showPickerView:(D_UIItem *)item data:(NSMutableDictionary *)data
{
    C_PickView* pickerView=[[C_PickView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height) item:item data:data];
    pickerView.delegate=self;
    [pickerView showInView:self.view];
}

- (void)delegate_clickButton:(D_UIItem *)item data:(NSMutableDictionary *)data
{
    [self dismissKeyboard];
    
    if(item.controlType==MULTICHOICE)
        [self showMutiPickerView:item data: data];
    else
        [self showPickerView:item data: data];
}

-(void)dealloc
{
    if(_inputView)
        [_inputView dismiss];
}

@end
