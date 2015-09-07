//
//  Frm_Rpt.m
//  SFA
//
//  Created by Ren Yong on 13-11-13.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "Frm_Rpt.h"
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
#import "UIImage+Tool.h"
#import "C_Filter.h"
#import "NSString+Tool.h"
#import "C_ProductTableView.h"
#import "F_Font.h"
#import "Frm_InputListDetail.h"

@interface Frm_Rpt ()
{
    NSMutableDictionary* _dicRptData;
    D_Report *_report;
    D_Template *_template;
    C_TempView *_tempView;
    NSMutableArray *_productList;
    
    D_Panel *_productPanel;
    C_ProductTableView *_productView;
    C_Filter* _filter;
    UIImageView *_imageView;
    
    int _requestType;
    
    C_PickView* _pickView;
    C_MutiPickerView* _mutiPickView;
    
    UIScrollView *_svPhoto;
    C_GradientButton* btn_Save;
    C_GradientButton* btn_Filter;
    C_NavigationBar* bar;
    int _index;
    NSMutableDictionary* _selectProduct;
    NSString* _selectItem;
    C_GradientButton* _selectButton;
    //    C_ViewButtonList* _viewButton;
    NSMutableDictionary* _filterData;
    
    C_GradientButton* _takePhoto;
    
    //    C_ProductTableView* _productView1;
    
    UILabel * totalDefen;
    C_TextField* txt_hls;
    C_GradientButton* btn_Photo;
}
@end

@implementation Frm_Rpt

int selectIndex;
int tableViewHeight;
//int KeyboardHeight=0;
//bool keyboardShown1=NO;

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
        _filterData=[NSMutableDictionary dictionary];
        [_filterData put:@"1" key:@"plan"];
    }
    return self;
}

-(void)initUI
{
    [self addNavigationBar];
    [self addViewBottom];
    [self initBody];
}

-(void)initBody
{
    NSMutableDictionary* button=[[_template buttonList] dictAt:0];
    if([button getInt:@"buttonId"]==1)
    {
        [self initTempView];
    }
    else  if([button getInt:@"buttonId"]==2)
    {
        [self initProductView];
    }
    else if([button getInt:@"buttonId"]==3)
    {
        [self initPhotoView];
    }
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
    
    btn_Filter=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Filter setTitle:@"筛选" forState:UIControlStateNormal];
    [btn_Filter useAddHocStyle];
    [btn_Filter addTarget:self action:@selector(filterClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn_Filter.hidden=YES;
    [bar addRightButton1:btn_Filter];
    
    btn_Save=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn_Save setTitle:@"保存" forState:UIControlStateNormal];
    [btn_Save useAddHocStyle];
    [btn_Save addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addRightButton:btn_Save];
    
}

//-(void)addButtom
//{
//    UIView* backButtom=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
//    [self.view addSubview:backButtom];
//
//    btn_Photo=[[C_GradientButton alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-20, 40)];
//    if([_report attSize]>0)
//        [btn_Photo setTitle:[NSString stringWithFormat:@"拍照(%d张)",[_report attSize] ] forState:UIControlStateNormal];
//    else
//        [btn_Photo setTitle:[NSString stringWithFormat:@"拍照" ] forState:UIControlStateNormal];
//    [btn_Photo useLoginStyle];
//    [btn_Photo addTarget:self action:@selector(takePhoto1:) forControlEvents:UIControlEventTouchUpInside];
//
//    [backButtom addSubview:btn_Photo];
//}

//-(void)takePhoto1:(id)sender
//{
//    [btn_Save setTitle:@"确定" forState:UIControlStateNormal];
//    //    _takePhoto=button;
//    [self initPhotoView];
//}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(_productView)
        [_productView reloadData];
}

-(void)initTempView
{
    if(_productView)
        _productView.hidden=YES;
    if( _svPhoto)
        _svPhoto.hidden=YES;
    if(!_tempView)
    {
        
        //              _tempView=[[C_TempView alloc] init:CGRectMake(0, SYSTITLEHEIGHT+50, self.view.frame.size.width, tableViewHeight-50)  panelList:[_template panelList] data:[_report rptField] delegate:self];
        //        else
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
        
        _productView = [[C_ProductTableView alloc] init:CGRectMake(0, SYSTITLEHEIGHT, self.view.frame.size.width,tableViewHeight) panel:[_template product_PanelAt:0] productList:[_report detailList] delegate:self report:_report];
        _productView.delegateProduct=self;
        [self.view addSubview:_productView];
    }else
        _productView.hidden=NO;
}
-(void)delegate_productClick:(NSMutableDictionary *)product panel:(D_Panel *)panel
{
    Frm_InputListDetail* nextFrm = [[Frm_InputListDetail alloc] initWith:product panel:panel];
    [self.navigationController pushViewController:nextFrm animated:YES];
}

-(void)filterClicked:(id)sender
{
    if(_filter)
    {
        [_filter cancelPicker];
        _filter=nil;
    }
    _filter=[[C_Filter alloc]init:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) panelList:[self panelList] data:_filterData ];
    _filter.delegate_filter=self;
    [_filter showInView:self.view];
}

-(void)delegate_filter_ok
{
    //    [self initDataList];
    //    for (NSMutableDictionary* client in _clientList) {
    //        if([_selectClientList objectForKey:[client getString:@"serverid"]]) {
    //            [client put:@"1" key:@"selected"];
    //        }
    //        else
    //            [client put:@"0" key:@"selected"];
    //    }
    
    NSMutableArray* list=[_productView haveValueList];
    for (NSMutableDictionary* dic in list) {
        [_report setDetailField:dic ];
    }
    NSMutableString* sql=[NSMutableString stringWithFormat:@"select * from t_product  where iscompete=0  "];
    
    if(![[_filterData getString:@"brand"] isEmpty])
        [sql appendFormat:@" and brand='%@'", [_filterData getString:@"brand"]];
    if(![[_filterData getString:@"xilie"] isEmpty])
        [sql appendFormat:@" and xilie='%@'", [_filterData getString:@"xilie"]];
    if(![[_filterData getString:@"namecode"] isEmpty])
        [sql appendFormat:@" and (fullname like '%%%@%%' or productcode like '%%%@%%') ", [_filterData getString:@"namecode"], [_filterData getString:@"namecode"]];
    [sql appendFormat:@" order by  fullname limit 50"];
    NSLog(@"%@",sql);
    
    
    _productList=[[DB instance] fieldListBy1:sql];
    //
    //    for (NSMutableDictionary* dic in _productList) {
    //        for (NSMutableDictionary dict in [_report]) {
    //            <#statements#>
    //        }
    //    }
    
    for (NSMutableDictionary* dic in _productList) {
        for (NSMutableDictionary* dict in [_report detailList]) {
            if([[dic getString:@"serverid"] isEqualToString:[dict getString:@"serverid"]])
            {
                [dic put:[dict getString:@"int1"] key:@"int1"];
                break;
            }
        }
    }
    
    [_productView refreshData:_productList];
}

-(NSMutableArray*)panelList
{
    NSMutableArray* panelList=[[NSMutableArray alloc]init];
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"筛选";
    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"品牌";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"brand";
    item.dicId=@"-1001";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"系列";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"xilie";
    item.dicId=@"-1002";
    item.lableWidth=100;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"名称/操作码";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"namecode";
    item.dicId=@"";
    item.lableWidth=100;
    [panel addItem:item];
    
    
    [panelList addPanel:panel];
    return panelList;
}

-(void)delegate_shotPhoto:(NSMutableDictionary *)product button:(C_GradientButton *)button
{
    _selectButton=button;
    _selectProduct=product;
    [self takePhoto:0];
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
    if (_productView) {
        
        [_productView reloadData];
    }
    
    if(_tempView)
        [_tempView reloadData];
    
}

/**
 [""]	<#Description#>加载数据
 [""]	@returns <#return value description#>
 [""] */
-(void)initData
{
    _template=temp_ById([_dicRptData getString:@"templateid"],[_dicRptData getString:@"name"]);
    
    _report=[[DB instance] curRpt:_template field:_dicRptData];
    
//    if([_template.type isEqualToString:@"7"])
//        [_report putValue:_template.name key:@"str3"];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
}


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
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"数据未保存，确认返回？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        //        [self.view endEditing:YES];
        [self dismissKeyboard];
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

-(BOOL)huodongzhixingOK
{
    if(_template.onlyType==6)
    {
        if(![[_report  getString:@"str2"] isEqualToString:@""]&&![[_report  getString:@"str2"] isEqualToString:@"0.00"])
        {
            if([_report attSize]==0)
            {
                toast_showInfoMsg(@"请拍摄照片", 100);
                return NO;
            }
        }
    }
    return YES;
}

-(BOOL)cuxiaoyuanOK
{
    if(_template.onlyType==9)
    {
        if([[_report  getString:@"int2"] isEqualToString:@"1"])
        {
            if([_report attSize]==0)
            {
                toast_showInfoMsg(@"请拍摄照片", 100);
                return NO;
            }
        }
    }
    return YES;
}

- (void)saveClicked:(id)sender
{
    [self dismissKeyboard];
    NSString* errMsg=[_report checkData];
    if([errMsg isEqualToString:@""])
    {
        if( [[DB instance] creatRpt:_report]>0)
        {
            toast_showInfoMsg(@"报告保存成功", 100);
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
            toast_showInfoMsg(@"报告保存失败,请重试", 100);
    }
    else
    {
        alert_showErrMsg(errMsg);
    }
    
}


-(void)dismissKeyboard
{
    [[self view] endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyboard];
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//     [self dismissKeyboard];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSLog(@"内存不足");
    //    [self gc];
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
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*self.view.frame.size.width, 0, self.view.frame.size.width-20,tableViewHeight)];
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
    
    [self takePhoto:0];
}



//-(void)delegate_takePhoto:(C_GradientButton *)button
//{
////    [btn_Save setTitle:@"确定" forState:UIControlStateNormal];
//    _takePhoto=button;
////    showPage=2;
//    [self initPhotoView];
//}

//-(void)delegate_selectProduct:(NSString *)name
//{
//    [btn_Save setTitle:@"确定" forState:UIControlStateNormal];
//    showPage=1;
//    [self initProductView1:name];
//}


-(NSMutableArray*)buttonList
{
    NSMutableArray* buttonList=[[NSMutableArray alloc] init];
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"拍照" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [buttonList addDict:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"选择照片" key:@"name"];
    [button putInt:2 key:@"buttonId"];
    [buttonList addDict:button];
    
    return buttonList;
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
            [self takePhoto:0];
        }
    }
}

//- (void)imgClicked:(id)sender
//{
//    [self takePhoto];
//}

- (void)takePhoto:(int)type
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    //    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - drawing
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //    if(![_template.type isEqualToString:@"2"])
    //    {
    UIImage* image= scaleToSize([info objectForKey:UIImagePickerControllerOriginalImage],CGSizeMake(screenW(), screenH()-100));
    
    NSMutableDictionary* attField=[NSMutableDictionary dictionary ];
    [attField put:encodeBase64Data(UIImageJPEGRepresentation(image, 0.5)) key:@"photo"];
    [attField put:nowToWeb() key:@"shottime"];
    
    //        if([_template.type isEqualToString:@"3"])
    //        {
    //            [attField put:_template.type key:@"PhotoType"];
    //            [attField put:[_selectProduct getString:@"serverid" ] key:@"ProductId"];
    //            [attField put:_selectItem key:@"remark"];
    //            [_selectButton addBackImg:image];
    //        }
    //        else
    //        {
    _imageView.image = image;
    _imageView.contentMode =  UIViewContentModeScaleToFill;
    _index++;
    
    [self resetScrollView];
    
    //        }
    
    [_report addAttField:attField];
    attField=nil;
    image=nil;
    //    }
    //    else
    //    {
    //        UIImage *image_bg = [info objectForKey:UIImagePickerControllerOriginalImage];
    //        //----------------
    //        PIDrawerViewController *drawerController = [[PIDrawerViewController alloc] initWithNibName:@"PIDrawerViewController" bundle:nil];
    //        //[self.navigationController pushViewController:drawerController animated:YES];
    //        drawerController.delegate = self;
    //        drawerController.oriImage = image_bg;
    //
    //        [self presentViewController:drawerController animated:YES completion:nil];
    //    }
    return;
}


- (void)mergeMarkController:(PIDrawerViewController*)mergeVC didFinishWithImg:(UIImage*)mergedImg
{
    UIImage* image= scaleToSize(mergedImg, CGSizeMake(screenW(), screenH()-100));
    NSString* shottime=nowToWeb();
    
    image = [image imageWithStringWaterMark:shottime atPoint:CGPointMake(5,screenH()-135) color:[UIColor whiteColor] font:[UIFont systemFontOfSize:13]];
    
    image = [image imageWithStringWaterMark:[NSString stringWithFormat:@"门店:%@",  [_dicRptData getString:@"fullname"]]  atPoint:CGPointMake(5,screenH()-120) color:[UIColor whiteColor] font:[UIFont systemFontOfSize:13]];
    
    _imageView.image = image;
    _imageView.contentMode =  UIViewContentModeScaleToFill;
    
    NSMutableDictionary* attField=[NSMutableDictionary dictionary ];
    [attField put:encodeBase64Data(UIImageJPEGRepresentation(image, 0.5)) key:@"photo"];
    [attField put:shottime key:@"shottime"];
    [_report addAttField:attField];
    
    _index++;
    [self resetScrollView];
    
    attField=nil;
    image=nil;
    [mergeVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


//- (void)delegate_requestDidSuccess:(D_SyncResult*)result
//{
//    stopProgress();
//    int status=[result getInt:SUCCESS];
//    switch (_requestType) {
//        case UPLOAD_REQUEST:
//            if (status==1)
//            {
//                if([_template.type isEqualToString:@"-3"])
//                {
//                    save_Sales([_report getString:@"int1"]);
//                }
//                if ([_template.type isEqualToString:@"-3"]||[_template.type isEqualToString:@"-4"]||[_template.type isEqualToString:@"-5"]||[_template.type isEqualToString:@"3"]) {
//                    [[DB instance] creatRpt:_report];
//                }
//                //                [self GC];
//                if([_template.type isEqualToString:@"1"])
//                {
//                    save_ClientCode([_report getString:@"ClientCode"]);
//                }
//
//                if(_tempView)
//                    [_tempView dismiss];
//                if(_productView)
//                    [_productView dismiss];
//
//
//                if([_template.type isEqualToString:@"1"])
//                    alert_showInfoMsg([NSString stringWithFormat:@"%@的销量报告提交成功", [result getString:@"ClientName"]]);
//                //                    toast_showInfoMsg([NSString stringWithFormat:@"%@的销量报告提交成功", [result getString:@"ClientName"]],100);
//                else
//                    toast_showInfoMsg(@"提交成功",100);
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//            else if(status==-1)
//            {
//                alert_showErrMsg([result getString:ERRMSG]);
//            }
//            else if(status==-2)
//            {
//                alert_showErrMsg([result getString:ERRMSG]);
//            }
//            break;
//        default:
//            break;
//    }
//}
//
//
//-(void) delegate_requestDidFail:(NSString*) errMsg
//{
//    stopProgress();
//    alert_showErrMsg(errMsg);
//}


@end
