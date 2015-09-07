//
//  Frm_SubmitRpt.m
//  Inoherb
//
//  Created by Bruce on 15/4/1.
//  Copyright (c) 2015年 Bruce.ren. All rights reserved.
//

#import "Frm_SubmitRpt.h"
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

@interface Frm_SubmitRpt ()
{
    NSMutableDictionary* _dicRptData;
    D_Report *_report;
    D_Template *_template;
    C_TempView *_tempView;
    NSMutableArray *_productList;
    
    D_Panel *_productPanel;
    C_ProductTableView *_productView;
    
    UIImageView *_imageView;
    
    int _requestType;
    
    C_PickView* _pickView;
    C_MutiPickerView* _mutiPickView;
    
    UIScrollView *_svPhoto;
    C_GradientButton* btn_Save;
    C_NavigationBar* bar;
    int _index;
    
    
}
@end

@implementation Frm_SubmitRpt

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
    self.view.backgroundColor=[UIColor whiteColor];
    [self addNavigationBar];
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
    
    btn_Save=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Save setTitle:@"提交" forState:UIControlStateNormal];
    [btn_Save useAddHocStyle];
    [btn_Save addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addRightButton:btn_Save];
}


-(void)initTempView
{
    if(_productView)
        _productView.hidden=YES;
    if( _svPhoto)
        _svPhoto.hidden=YES;
    if(!_tempView)
    {
        _tempView=[[C_TempView alloc] init:CGRectMake(0, SYSTITLEHEIGHT, self.view.frame.size.width, tableViewHeight)  panelList:[_template panelList] data:[_report rptField] delegate:self];
        
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
        _productView = [[C_ProductTableView alloc] init:CGRectMake(0, SYSTITLEHEIGHT, self.view.frame.size.width,tableViewHeight) panel:[_template product_PanelAt:0] productList:[_report detailList] delegate:self report:_report];
        [self.view addSubview:_productView];
    }else
        _productView.hidden=NO;
}

- (void)delegate_clickButton:(D_UIItem*)item data:(NSMutableDictionary*)data
{
    [self dismissKeyboard];
    if(item.controlType==MULTICHOICE)
        [self showMutiPickerView:item data: data];
    else
        [self showPickerView:item data:data];
    
}

-(void)showMutiPickerView:(D_UIItem *)item data:(NSMutableDictionary *)data
{
    _mutiPickView=[[C_MutiPickerView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height) item:item data:data];
    _mutiPickView.delegate=self;
    [_mutiPickView showInView:self.view];
}

-(void)showPickerView:(D_UIItem *)item data:(NSMutableDictionary *)data
{
    if(_pickView)
        [_pickView cancelPicker];
    _pickView=[[C_PickView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) item:item data:data];
    _pickView.delegate=self;
    [_pickView showInView:self.view];
}

-(void)delegate_selected
{
    if(_tempView)
        [_tempView reloadData];
}

/**
 [""]	<#Description#>加载数据
 [""]	@returns <#return value description#>
 [""] */
-(void)initData
{
    _template=temp_ById([_dicRptData getString:@"templateid"],@"");
    
    
    _report=[[DB instance] curRpt:_template field:_dicRptData];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
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
    [self showAlert];
}

-(void)showAlert
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"数据未提交，确认返回？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        if(_tempView)
            [_tempView dismiss];
        if(_productView)
            [_productView dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) syncWeb:(RequestType)type report:(D_Report* )rpt
{
    [[SyncWeb instance]syncWeb:_requestType report:rpt delegate:self];
}

- (void)saveClicked:(id)sender
{
    [self dismissKeyboard];
    NSString* errMsg=[_report checkData];
    if([errMsg isEqualToString:@""])
    {
        
        if(_template.onlyType==-1001)
        {
            NSLog(@"%@-------------------%@",[_report getString:@"str2"],[_report getString:@"str3"]);
            if(![[_report getString:@"str2"] isEqualToString:[_report getString:@"str3"] ])
            {
                toast_showInfoMsg(@"两次密码输入不匹配！", 100);
                return;
            }
            else
            {
                pro_showInfoMsg(@"数据提交中,请稍候");
                _requestType=QUERY_REQUEST;
                NSMutableDictionary* queryData=[NSMutableDictionary dictionary];
                [queryData putKey:user_Id() key:@"empId"];
                [queryData putKey:[_report getString:@"str1"] key:@"oldPwd"];
                [queryData putKey:[_report getString:@"str2"] key:@"newPwd"];
                [queryData putKey:@"ResetPassword" key:METHOD];
                [self syncWeb:_requestType field:queryData];
                
            }
        }
        
        else
        {
            pro_showInfoMsg(@"数据提交中,请稍候");
            
            _requestType=UPLOAD_REQUEST;
            [self syncWeb:_requestType report:_report];
        }
    }
    else
    {
        toast_showInfoMsg(errMsg,100);
    }
}

-(void) syncWeb:(RequestType)type field:(NSMutableDictionary* )field
{
    [[SyncWeb instance]syncWeb:type field:field delegate:self];
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
        _index=[_report attSize]+1;
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
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*self.view.frame.size.width, 0, self.view.frame.size.width,tableViewHeight)];
    imageView.tag=index;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClicked:)];
    //    singleTap.v=index;
    
    [imageView addGestureRecognizer:singleTap];
    [self initImage:imageView];
    
    [_svPhoto addSubview:imageView];
    //    [list addObject:imageView1];
    
    //    C_Label*lable=[[C_Label alloc] initWithFrame: CGRectMake(index*self.view.frame.size.width+15, 5, self.view.frame.size.width-50, 30)  label:@""];
    //    lable.backgroundColor=[UIColor whiteColor];
    //    lable.text=[NSString stringWithFormat:@"照片%d",index+1];
    //    [_svPhoto addSubview:lable];
    
}

- (void)imgClicked:(id)sender
{
    _imageView=(UIImageView*)[sender view];
    [self takePhoto];
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

-(void)resetScrollView
{
    _svPhoto.contentSize = CGSizeMake(self.view.frame.size.width*_index, tableViewHeight);
    [self addImgView:(_index-1)];
}

-(void)initImage:(UIImageView*)imgView
{
    
    if([_report attSize]>imgView.tag)
    {
        NSString *photoString = [[_report attFieldAt:imgView.tag] getString:@"photo"];
        NSData *photoData = [photoString dataUsingEncoding: NSUTF8StringEncoding];
        photoData = [GTMBase64 decodeData:photoData];
        imgView.image= [UIImage imageWithData: photoData];
        imgView.contentMode =  UIViewContentModeScaleToFill;
    }
    else
    {
        imgView.image= [UIImage imageNamed:@"photo.png"];
        imgView.contentMode =  UIViewContentModeCenter;
        if(imgView.tag==0)
        {
            _imageView=imgView;
            [self takePhoto];
        }
    }
}


- (void)takePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    picker.sourceType = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image= scaleToSize([info objectForKey:UIImagePickerControllerOriginalImage],CGSizeMake(screenW(), screenH()-100));
    _imageView.image = image;
    _imageView.contentMode =  UIViewContentModeScaleToFill;
    NSMutableDictionary* attField=[NSMutableDictionary dictionary ];
    [attField put:encodeBase64Data(UIImageJPEGRepresentation(image, 0.5)) key:@"photo"];
    [attField put:nowToWeb() key:@"shottime"];
    [_report addAttField:attField];
    _index++;
    if( _template.onlyType!=-3&&_template.onlyType!=-4)
        [self resetScrollView];
    attField=nil;
    image=nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)delegate_requestDidSuccess:(D_SyncResult*)result
{
    stopProgress();
    
    //    int status=[[result getField:0]getInt:SUCCESS];
    switch (_requestType) {
        case UPLOAD_REQUEST:
        {
            if([[result getFieldList] count]>0)
            {
                int status=[[result getField:0]getInt:SUCCESS];
                if (status==1)
                {
                    if(_tempView)
                        [_tempView dismiss];
                    if(_productView)
                        [_productView dismiss];
                    
                    
                    [_report putKey:[result getString:@"ReportId"] key:@"serverid"];
                    
                    [[DB instance] creatRpt:_report];
                    
                    toast_showInfoMsg([NSString stringWithFormat:@"%@ 提交成功", _template.name],100);
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else if(status==-1)
                {
                    alert_showErrMsg([[result getField:0] getString:ERRMSG]);
                }
                else if(status==-2)
                {
                    alert_showErrMsg([[result getField:0] getString:ERRMSG]);
                }
            }
            else
            {
                alert_showErrMsg(@"网络异常,请重试");
            }
        }
            break;
            
        case QUERY_REQUEST:
        {
            int status=[result getInt:SUCCESS];
            if (status==1)
            {
                toast_showInfoMsg(@"密码修改成功",100);
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if(status==-1)
            {
                alert_showErrMsg([result getString:ERRMSG]);
            }
            else if(status==-2)
            {
                alert_showErrMsg([result getString:ERRMSG]);
            }
        }
            break;
        default:
            break;
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
