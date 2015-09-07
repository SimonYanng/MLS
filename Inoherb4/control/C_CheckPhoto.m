//
//  C_CheckPhoto.m
//  SFA
//
//  Created by Ren Yong on 13-11-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "C_CheckPhoto.h"
#import "F_Color.h"
#import "F_Font.h"
#import "Frm_Menu.h"
#import "F_Image.h"
#import "F_Tool.h"
#import "F_Date.h"
#import "D_Report.h"
#import "DB.h"
#import "F_Template.h"
#import "F_UserData.h"
#import "GTMBase64.h"
#import "NSMutableDictionary+Tool.h"
#import "F_Alert.h"
#import "UIImage+Tool.h"

@interface C_CheckPhoto()
{
    UIImageView * _imgView;
    C_GradientButton* _takePhoto;
    PhotoType _type;
    NSMutableDictionary* _clientInfo;
    BOOL _isShot;
}

@end
@implementation C_CheckPhoto

@synthesize form=_form,delegate=_delegate;


- (id)initWithFrame:(CGRect)frame type:(PhotoType)type clientInfo:(NSMutableDictionary*)clientInfo
{
    _type = type;
    _clientInfo=clientInfo;
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = UIColorFromRGB(0xD9ECF1);
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 1, 50, frame.size.height-2)];
        _imgView.backgroundColor =col_ClearColor();
        [self initImage];
        [self addSubview:_imgView];
        
        _takePhoto=[[C_GradientButton alloc] initWithFrame:CGRectMake(240, 10, 70, frame.size.height -20)];
        
        [_takePhoto useAddHocStyle];
        
        if (type == CHECKIN)
        {
            [_takePhoto setTitle:@"进店照片" forState:UIControlStateNormal];
        }
        else
        {
            [_takePhoto setTitle:@"出店照片" forState:UIControlStateNormal];
        }
        [_takePhoto addTarget:self action:@selector(takePhotoButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_takePhoto];
    }
    return self;
}

-(void)initImage
{
    D_Report* rpt=[self report];
    if([rpt attSize]>0)
    {
        NSString *testString = [[[self report] attFieldAt:0] getString:@"photo"];
        NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
        testData = [GTMBase64 decodeData:testData];
        _imgView.image= [UIImage imageWithData: testData];
        _imgView.contentMode =  UIViewContentModeScaleToFill;
        _isShot=YES;
    }
    else
    {
        _isShot=NO;
        _imgView.image= img_Camera();
        _imgView.contentMode =  UIViewContentModeScaleToFill;
    }
}

- (void)takePhotoButtonClicked:(UIButton *)button
{
    if(!_isShot)
    {
        if(_type == CHECKOUT&&![self isCheckin])
        {
            toast_showInfoMsg(@"请先拍摄进店照片", 100);
        }
        else
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [_form presentViewController:picker animated:YES completion:nil];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image= scaleToSize([info objectForKey:UIImagePickerControllerOriginalImage],CGSizeMake(320, 320));
    
    NSString* shottime=nowToWeb();
    image = [image imageWithStringWaterMark:shottime atPoint:CGPointMake(5,290) color:[UIColor whiteColor] font:[UIFont systemFontOfSize:13]];
    image = [image imageWithStringWaterMark:[NSString stringWithFormat:@"门店:%@",  [_clientInfo getString:@"fullname"]]  atPoint:CGPointMake(5,305) color:[UIColor whiteColor] font:[UIFont systemFontOfSize:13]];
    
    NSMutableDictionary* attField=[NSMutableDictionary dictionary];
    [attField put:encodeBase64Data(UIImageJPEGRepresentation(image, 0.5)) key:@"photo"];
    
    [attField put:shottime key:@"shottime"];
    
    D_Report* rpt=[self report];
    [rpt resetAttField:attField];
    [rpt putValue:shottime key:@"shottime"];
    if ([[DB instance] creatRpt:rpt]>0) {
        _imgView.image = image;
        _isShot=YES;
        toast_showInfoMsg(@"照片拍摄成功", 100);
    }
    else
    {
        toast_showInfoMsg(@"照片拍摄失败,请重新拍摄", 100);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    attField=nil;
    image=nil;
    rpt=nil;
}

-(BOOL)isCheckin
{
    D_Template* checkinTemp= temp_ById(@"-1",@"");
    D_Report* report=[[DB instance] curRpt:checkinTemp field:_clientInfo];
    if(report.isSaved)
        return YES;
    return NO;
}
-(D_Report*)report
{
    D_Template* template=[self template];
    D_Report* report;
    if (template) {
        report=[[DB instance] curRpt:template field:_clientInfo];
    }
    template=nil;
    return report;
}

-(D_Template*)template
{
    if (_type == CHECKIN)
        return temp_ById(@"-1",@"");
    else
        return temp_ById(@"-2",@"");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
