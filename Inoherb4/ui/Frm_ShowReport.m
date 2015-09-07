//
//  Frm_ShowReport.m
//  JahwaS
//
//  Created by Bruce on 15/7/10.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "Frm_ShowReport.h"
#import "C_ItemView.h"
#import "D_Template.h"
#import "D_Panel.h"
#import "DB.h"
#import "C_NavigationBar.h"
#import "Constants.h"
#import "F_Phone.h"
#import "C_Button.h"
#import "F_Color.h"
#import "C_TextField.h"
#import "F_Image.h"
#import "C_Bottom.h"

#import "F_Template.h"
#import "F_UserData.h"
#import "F_Date.h"
#import "SyncWeb.h"
#import "F_Alert.h"
#import "C_Progress.h"
#import "F_Tool.h"
#import "C_Mutipickerview.h"
#import "C_GradientButton.h"
#import "GTMBase64.h"
@interface Frm_ShowReport ()
{
    NSMutableDictionary* _dicRptData;
    D_Report *_report;
    D_Template *_template;
    C_TempView *_tempView;
    NSMutableArray *_productList;
    
    D_Panel *_productPanel;
    C_ProductTableView *_productView;
    
    UIImageView *_imageView;
    
    
    C_PickView* _pickView;
    C_MutiPickerView* _mutiPickView;
    
    UIScrollView *_svPhoto;
    C_GradientButton* btn_Save;
    C_NavigationBar* bar;
    int _index;
}
@end

@implementation Frm_ShowReport

int selectIndex;
int tableViewHeight;
//int KeyboardHeight=0;
//bool keyboardShown=NO;

//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(id)init:(NSMutableDictionary*)data
{
    self = [super init];
    if(self)
    {
        _dicRptData=data;
        _index=0;
    }
    return self;
}

-(void)initUI
{
    
    [self addViewBottom];
    [self initBody];
}

-(void)initBody
{
    NSMutableDictionary* button=[[_template buttonList] dictAt:0];
    if([button getInt:@"buttonId"]==1)
        [self initTempView];
    else  if([button getInt:@"buttonId"]==2)
        [self initProductView];
    else if([button getInt:@"buttonId"]==3)
        [self initPhotoView];
}


-(void)addViewBottom
{
    if ([[_template buttonList] count]>1) {
        tableViewHeight=self.view.frame.size.height-BOTTOMHEIGHT-SYSTITLEHEIGHT;
        C_Bottom* bottom=[[C_Bottom alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-BOTTOMHEIGHT, self.view.frame.size.width, BOTTOMHEIGHT) buttonList:[_template buttonList]];
        bottom.delegate=self;
        [self.view addSubview:bottom];
    }
    else
        tableViewHeight=self.view.frame.size.height-SYSTITLEHEIGHT;
}

-(void)addNavigationBar
{
    bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:_template.name];
    [self.view addSubview:bar];
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) buttonId:-1];
    
    [btn_Back setTitle:@"" forState:UIControlStateNormal];
    [btn_Back useImgStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
}


-(void)initTempView
{
    if(_productView)
        _productView.hidden=YES;
    if( _svPhoto)
        _svPhoto.hidden=YES;
    if(!_tempView)
    {
        _tempView=[[C_TempView alloc] init:CGRectMake(0, SYSTITLEHEIGHT, self.view.frame.size.width, tableViewHeight)  panelList:[_template panelList] data:[_report rptField] delegate:nil];
        
        [self.view addSubview:_tempView];
    }else
        _tempView.hidden=NO;
}

-(void)initProductView
{
    if(_tempView)
        _tempView.hidden=YES;
    if(_svPhoto)
        _svPhoto.hidden=YES;
    if(!_productView)
    {
        //        _productList=[[DB instance] productList:@""];
        _productView = [[C_ProductTableView alloc] init:CGRectMake(0, SYSTITLEHEIGHT, self.view.frame.size.width,tableViewHeight) panel:[_template product_PanelAt:0] productList:[_report detailList] delegate:nil report:nil];
        [self.view addSubview:_productView];
    }else
        _productView.hidden=NO;
}

//- (void)delegate_clickButton:(D_UIItem*)item data:(NSMutableDictionary*)data
//{
//    [self dismissKeyboard];
//    if(item.controlType==MULTICHOICE)
//        [self showMutiPickerView:item data: data];
//    else
//        [self showPickerView:item data:data];
//
//}
//
//-(void)showMutiPickerView:(D_UIItem *)item data:(NSMutableDictionary *)data
//{
//    _mutiPickView=[[C_MutiPickerView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height) item:item data:data];
//    _mutiPickView.delegate=nil;
//    [_mutiPickView showInView:self.view];
//}
//
//-(void)showPickerView:(D_UIItem *)item data:(NSMutableDictionary *)data
//{
//    if(_pickView)
//        [_pickView cancelPicker];
//    _pickView=[[C_PickView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) item:item data:data];
//    _pickView.delegate=nil;
//    [_pickView showInView:self.view];
//}

-(void)delegate_selected
{
    if(_tempView)
        [_tempView reloadData];
}

/**
 [""]	<#Description#>加载数据
 [""]	@returns <#return value description#>
 [""] */
//-(void)initData
//{
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initData];
    [self addNavigationBar];
    pro_showInfoMsg(@"正在查询,请稍候");
    [self querData];
    //    [self initUI];
}

-(void)viewDidAppear:(BOOL)animated
{

}

-(void)querData
{
    NSMutableDictionary*_queryData=[NSMutableDictionary dictionary];
    [_queryData putKey:user_Id() key:@"userId"];
    
    [_queryData putKey:[_dicRptData getString:@"reportid"] key:@"reportid"];
    
    [_queryData putKey:@"GetClientReportDetail" key:METHOD];
    
    [[SyncWeb instance]syncWeb:QUERY_REQUEST field:_queryData delegate:self];
}
//-(void)viewDidAppear:(BOOL)animated
//{
//
//}


- (void)delegate_buttonClick:(int)buttonId
{
    switch (buttonId) {
        case 1:
            [self initTempView];
            break;
        case 2:
            [self initProductView];
            break;
        case 3:
            [self initPhotoView];
            break;
        default:
            break;
    }
    
}

- (void)backClicked:(id)sender
{
    if(_tempView)
        [_tempView dismiss];
    if(_productView)
        [_productView dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dismissKeyboard
{
    [[self view] endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyboard];
}


-(void)initPhotoView
{
    if(_tempView)
        _tempView.hidden=YES;
    if(_productView)
        _productView.hidden=YES;
    
    if(!_svPhoto)
    {
        _index=[_report attSize];
        [self initScrollView];
        for (int i=0; i<_index; i++) {
            [self addImgView:i];
        }
    }
    else
        _svPhoto.hidden=NO;
}

-(void)addImgView:(int)index
{
    UIWebView* imageView = [[UIWebView alloc] initWithFrame:CGRectMake(index*self.view.frame.size.width, 0, self.view.frame.size.width-20,tableViewHeight)];
    imageView.tag=index;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClicked:)];
    //    singleTap.v=index;
    
    [imageView addGestureRecognizer:singleTap];
    [self initImage:imageView];
    
    [_svPhoto addSubview:imageView];
    //    [list addObject:imageView1];
    
    C_Label*lable=[[C_Label alloc] initWithFrame: CGRectMake(index*self.view.frame.size.width+15, 5, self.view.frame.size.width-50, 30)  label:@""];
    lable.backgroundColor=[UIColor whiteColor];
    lable.text=[NSString stringWithFormat:@"照片%d",index+1];
    [_svPhoto addSubview:lable];
    
}

- (void)imgClicked:(id)sender
{
    _imageView=(UIImageView*)[sender view];
//    [self takePhoto];
}

-(void)initScrollView
{
    _svPhoto = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SYSTITLEHEIGHT, self.view.frame.size.width,tableViewHeight)];
    _svPhoto.contentSize = CGSizeMake(self.view.frame.size.width*_index, tableViewHeight);
    _svPhoto.scrollEnabled = YES;
    _svPhoto.bounces = YES;
    _svPhoto.pagingEnabled = YES;
    _svPhoto.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_svPhoto];
}

//-(void)resetScrollView
//{
//    _svPhoto.contentSize = CGSizeMake(self.view.frame.size.width*_index, tableViewHeight);
//    [self addImgView:(_index-1)];
//}

-(void)initImage:(UIWebView*)imgView
{
    
//    if([_report attSize]>imgView.tag)
//    {
    imgView.opaque = NO;
    imgView.backgroundColor=[UIColor clearColor];
    imgView.scalesPageToFit =YES;
    UIScrollView *tempView=(UIScrollView *)[imgView.subviews objectAtIndex:0];
    tempView.scrollEnabled=NO;
    NSString *photoString = [[_report attFieldAt:imgView.tag] getString:@"STR1"];
    NSURL *url = [[NSURL alloc]initWithString:photoString];
    if (url) {
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [imgView loadRequest:request];
    }
}


- (void)delegate_requestDidSuccess:(D_SyncResult*)result
{
    stopProgress();
    int status=[result getInt:SUCCESS];
    if (status==1)
    {
        NSLog(@"数量++++++++++++++++++%d",result.size);
        
        if(result.size>0)
        {
           
            _template=temp_ById([_dicRptData getString:@"templateid"],@"");
            _report = [[D_Report alloc]init:_template];
            for(NSMutableDictionary* data in result.list)
            {
                if([[data getString:@"TypeId"] isEqualToString:@"1"])
                {
//                    for (NSString* key in  data.keyEnumerator) {
//                        NSLog(@"key--------%@",key  );
//                    }
                     if([[_dicRptData getString:@"templateid"] isEqualToString:@"2"])
                         _template=temp_ById(@"2",[data getString:@"STR10"]);
                    _report.field=data;
                }
                else  if([[data getString:@"typeid"] isEqualToString:@"2"])
                {
                    [_report addDetailField:data];
                }
                else if([[data getString:@"typeid"] isEqualToString:@"3"])
                {
                    [_report addAttField:data];
                }
            }
            [self initUI];
        }
        else
            toast_showInfoMsg(@"未查询到数据", 100);
        //                _listHD=result.getFieldList;
        //                [_tableViewHD reloadData];
        
        
    }
    else
    {
        toast_showInfoMsg([result getString:ERRMSG], 100);
        
    }
}


-(void) delegate_requestDidFail:(NSString*) errMsg
{
    stopProgress();
    alert_showErrMsg(errMsg);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
