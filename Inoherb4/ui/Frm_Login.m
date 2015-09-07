//
//  Frm_LoginViewController.m
//  SFA
//
//  Created by Ren Yong on 13-10-14.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "Frm_Login.h"
#import "F_Color.h"
#import "F_UserData.h"
#import "F_Alert.h"
#import "C_CheckBox.h"
#import "F_DBConfig.h"
#import "D_UIItem.h"
#import "C_Label.h"
#import "C_TextField.h"
//#import "Frm_MainMenu.h"
#import "D_Template.h"
#import "F_Template.h"
#import "DB.h"
#import "SyncWeb.h"
#import "F_Date.h"
#import "F_Tool.h"
#import "F_Phone.h"
#import "C_ItemView.h"
#import "Frm_Menu.h"
#import "C_NavigationBar.h"
#import "C_Button.h"
#import "C_DatePicker.h"
#import "F_Image.h"
#import "C_Toast.h"
#import "C_GradientButton.h"
#import "Frm_MainMenu.h"
#import "FBShimmeringView.h"
#import "C_ImageView.h"
#import "F_Phone.h"
#import "F_Font.h"
#import "Frm_Menu1.h"
#import "Constants.h"
@interface Frm_Login()
{
    UIView* view_background;
    C_TextField* txt_name;
    C_TextField* txt_pwd;
    NSMutableDictionary* dic_user;
    NSString* _downLoadUrl;
}

@end

@implementation Frm_Login

@synthesize queryData,index,requestType,msgList;
static int itemHeight=50;
static int viewGap=20;

-(id)init
{
    self = [super init];
    if (self) {
        
        //        NSLog(@"日期%@---------今天%@",[login_date() substringToIndex:7],[today() substringToIndex:7]);
    }
    return self;
}

//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 [""]	<#Description#>加载界面
 [""]	@returns <#return value description#>
 [""] */
-(void)initUI
{
    [self initBackView];
    [self addNavigationBar];
    [self initBody];
    [self addBtnLogin];
    [self addLabelVersion];
}

-(void)initBackView
{
    //    UIImage* imgBackground=[UIImage imageNamed:@"bg.jpg"];
    //    UIImageView* ImgVIewBackground=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //    ImgVIewBackground.image=imgBackground;
    //    ImgVIewBackground.backgroundColor=col_Title();
    view_background=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //    [view_background addSubview:ImgVIewBackground];
    [view_background setBackgroundColor:col_byIntColor(0x6DCAE9)];
    
    
    [self.view addSubview:view_background];
    
    
}
-(void)addNavigationBar
{
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"系统登录"];
    [self.view addSubview:bar];

}

-(void)initBody
{
    UIImage* imgLogo=[UIImage imageNamed:@"logo1.png"];
    C_ImageView* imgVIewLogo=[[C_ImageView alloc] initWithFrame:CGRectMake(20, 70, self.view.frame.size.width-40, 100) image:imgLogo];
    imgVIewLogo.alpha=0;
    [view_background addSubview:imgVIewLogo];
    
    [UIView animateWithDuration:1 animations : ^{
        imgVIewLogo.alpha=1;
    }completion:^(BOOL finished) {
    }];
    
    txt_name=[[C_TextField alloc] initWithFrame:CGRectMake(viewGap,190, view_background.frame.size.width-2*viewGap, 50)];
    
    //    [txt_name setBackground:[UIImage imageNamed:@"input_box.png"]];
    UIImage* imgName=[UIImage imageNamed:@"user.png"];
    UIView *viewSuojin = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 37, 50)];//左端缩进15像素
    txt_name.leftView = viewSuojin;
    txt_name.leftViewMode =UITextFieldViewModeAlways;
    UIView *viewline = [[UIView alloc]initWithFrame:CGRectMake(32, 15, 1, 20)];//左端缩进15像素
    [viewline setBackgroundColor:col_byIntColor(0xedefe5)];
    txt_name.layer.borderColor=[UIColor colorWithWhite:0.9 alpha:1].CGColor;
    txt_name.layer.borderWidth=1;
    txt_name.layer.cornerRadius=4;
    txt_name.backgroundColor =[UIColor whiteColor];
    [ txt_name addSubview:viewline];
    
    C_ImageView* imgVIewName=[[C_ImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20) image:imgName];
    [txt_name addSubview:imgVIewName] ;
    [txt_name setTextColor:[UIColor blackColor]];
    [txt_name setText:user_Name()];
    [txt_name setPlaceholder:@"请输入您的用户名"];
    [view_background addSubview:txt_name];
    
    txt_pwd=[[C_TextField alloc] initWithFrame:CGRectMake(viewGap,255, view_background.frame.size.width-2*viewGap, 50)];
    
    //    [txt_pwd setBackground:[UIImage imageNamed:@"input_box.png"]];
    UIImage* imgPwd=[UIImage imageNamed:@"lock.png"];
    UIView *viewPwdSuojin = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 37, 50)];//左端缩进15像素
    txt_pwd.leftView = viewPwdSuojin;
    txt_pwd.leftViewMode =UITextFieldViewModeAlways;
    UIView *viewPwdline = [[UIView alloc]initWithFrame:CGRectMake(32, 15, 1, 20)];//左端缩进15像素
    [viewPwdline setBackgroundColor:col_byIntColor(0xedefe5)];
    txt_pwd.layer.borderColor=[UIColor colorWithWhite:0.9 alpha:1].CGColor;
    txt_pwd.layer.borderWidth=1;
    txt_pwd.layer.cornerRadius=4;
    txt_pwd.backgroundColor =[UIColor whiteColor];
    
    [ txt_pwd addSubview:viewPwdline];
    C_ImageView* imgVIewPwd=[[C_ImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20) image:imgPwd];
    [txt_pwd addSubview:imgVIewPwd] ;
    [txt_pwd setTextColor:[UIColor blackColor]];
    
    [txt_pwd setSecureTextEntry:YES];
    [txt_pwd setPlaceholder:@"请输入您的密码"];
    [txt_pwd setText:user_Pwd()];
    [txt_pwd setClearsOnBeginEditing:YES];
    [txt_pwd setReturnKeyType:UIReturnKeyDone];//改变按钮
    [view_background addSubview:txt_pwd];
}

-(void)addLabelVersion
{
    //    UIView* viewLeftLine=[[UIView alloc] initWithFrame:CGRectMake(viewGap+5,450, 50, 1)];
    //    [viewLeftLine setBackgroundColor:col_byIntColor(0x6a9e5e)];
    //    [view_background addSubview:viewLeftLine];
    
    C_GradientButton* btnHotLine=[[C_GradientButton alloc]initWithFrame:CGRectMake(viewGap+35,425, self.view.frame.size.width-2*viewGap-70, 50)];
    [btnHotLine useClearStyle];
    [btnHotLine setTitle:HOTLINE forState:UIControlStateNormal];
    [btnHotLine addTarget:self action:@selector(callClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [btnHotLine setTextColor:[UIColor whiteColor]];
    [self.view addSubview:btnHotLine];
    
    //    UIView* viewRightLine=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-viewGap-50-5,450, 50, 1)];
    //    [viewRightLine setBackgroundColor:col_byIntColor(0x6a9e5e)];
    //    [view_background addSubview:viewRightLine];
    
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(viewGap+35,455, self.view.frame.size.width-2*viewGap-70, 30)];
    [label setText:[NSString stringWithFormat:@"版本号 %@", APPVERSION ]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:fontBysize(12)];
    [view_background addSubview:label];
}

-(void)addBtnLogin
{
    C_GradientButton* btnLogin=[[C_GradientButton alloc] initWithFrame:CGRectMake(viewGap,335, self.view.frame.size.width-2*viewGap, 50) buttonId:-2];
    [btnLogin useLoginStyle];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view_background addSubview:btnLogin];
}

-(void)callClicked:(id)sender
{
    callNumber(@"4006729851",view_background);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyboard];
}

/**
 [""]	<#Description#>加载数据
 [""]	@returns <#return value description#>
 [""] */
-(void)initData
{
    dic_user=[NSMutableDictionary dictionary];
    //    [userData put:user_Name() key:USERNAME];
    //    if(is_SavePwd())
    //        [userData put:user_Pwd() key:PWD];
    //    [userData putBool:is_SavePwd() key:@"savePwd"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

-(NSString*) checkLogin
{
    if(isEmpty([dic_user getString:USERNAME] ))
    {
        return @"请输入用户名";
    }
    else if(isEmpty([dic_user getString:PWD]))
    {
        return @"请输入密码";
    }
    else if(!isConnecting())
    {
        return @"网络连接失败，请确认网络连接！";
    }
    else if(availableMemory()<10.0)
    {
        toast_showInfoMsg([NSString stringWithFormat:@"可用内存%f",availableMemory()], 100);
        return @"检测到手机内存不足250M,请先清理内存";
    }
    
    return @"";
}

-(void)dismissKeyboard
{
    [[self view] endEditing:YES];
}

-(void)resetData
{
    [dic_user put:txt_name.text key:USERNAME];
    [dic_user put:txt_pwd.text key:PWD];
}

- (void)loginButtonClicked:(id)sender
{
    [self dismissKeyboard];
    [self resetData];
    NSString* errMsg=[self checkLogin];
    if(isEmpty(errMsg))
    {
        pro_showInfoMsg(@"验证用户名密码,请稍候");
        
        NSMutableDictionary* field=[NSMutableDictionary dictionary];
        [field putKey:[dic_user getString:USERNAME] key:USERNAME];
        [field putKey:[dic_user getString:PWD] key:PWD];
        [field putKey:APPVERSION1 key:VERSION];
        [field putKey:@"2" key:DEVICETYPE];
        [field putKey:LOGIN key:METHOD];
        
        requestType=LOGIN_REQUEST;
        [self syncWeb:requestType field:field];
        field=nil;
    }
    else
        alert_showErrMsg(errMsg);
    
}


-(void) toMainMenu
{
    Frm_MainMenu * nextFrm = [[Frm_MainMenu alloc] init];
    [self.navigationController pushViewController:nextFrm animated:YES];
}

-(void) syncWeb:(RequestType)type field:(NSMutableDictionary* )field
{
    [[SyncWeb instance]syncWeb:requestType field:field delegate:self];
}

- (void)delegate_Checked:(BOOL)value
{
    save_UserSavePwd(value);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //    [self clearData];
}


-(void) delegate_requestDidFail:(NSString*) errMsg
{
    stopProgress();
    alert_showErrMsg(errMsg);
}

-(void) saveUserInfo:(D_SyncResult*)result
{
    save_UserName([dic_user getString:USERNAME]);
    save_UserPwd([dic_user getString:PWD]);
    //    save_UserSavePwd([userData getBool:@"savePwd"]);
    save_UserId([result getString:USERID]);
    save_UserName1([result getString:@"EmpName"]);
    save_Sales([result getString:@"IsTeam"]);
}


-(void)checkLoginTo
{
    if(!is_Used())
    {
        [self querALLData];
        //        [self toMainMenu];
    }
    else
    {
        if([login_date() isEqualToString:today()])
        {
            [self toMainMenu];
        }
        else
        {
            [self deletTable];
            [self querALLData];
            //            [self querData];//平台
        }
    }
}

-(void)deletTable
{
    NSMutableArray* sqlList=[[NSMutableArray alloc]init];
    
    if(![[login_date() substringToIndex:7] isEqualToString:[today() substringToIndex:7]])
    {
        [sqlList addString:[NSString stringWithFormat:@"delete from t_data_callReport where reportdate<'%@'",today()]];
        [sqlList addString:@"delete from t_data_callReportDetail"];
    }
    [sqlList addString:@"delete from t_data_callReportPhoto"];
    [[DB instance] execSqlList:sqlList];
}

-(void)clearData
{
    NSMutableArray* sqlList=[[NSMutableArray alloc]init];
    for(D_Table* table in table_List())
    {
        [sqlList addObject:[NSString stringWithFormat:@"delete from %@",table.tableName]];
    }
    [[DB instance] execSqlList:sqlList];
    save_Used(NO);
}

- (void)delegate_requestDidSuccess:(D_SyncResult*)result
{
    stopProgress();
    int status=[result getInt:SUCCESS];
    switch (requestType) {
        case LOGIN_REQUEST:
            if (status==1)
            {
                if (![[dic_user getString:USERNAME]isEqualToString:user_Name()])
                    [self clearData];
                
                [self saveUserInfo:result];
                
                msgList=[result getFieldList];
                requestType=QUERY_REQUEST;
                index=0;
                [self checkLoginTo];
            }
            else if(status==-1)
            {
                alert_showErrMsg([result getString:@"ErrorMsg"]);
            }
            else if(status==-2)
            {
                _downLoadUrl=   [result getString:@"appurl"];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"系统检测到新版本，请先更新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }
            break;
        case QUERY_REQUEST:
            if (status==1)
            {
                if([queryData getInt:ISALL]==0&&[queryData getInt:STARTROW]==0)
                {
                    [[DB instance] execSql:[NSMutableString stringWithFormat:@"delete from %@ ",[result getString:RETURNTYPE]]];
                }
                if([[DB instance] upsertData:result])
                {
                    if([result getInt:DONE]==0)
                    {
                        NSMutableDictionary* msg = [msgList dictAt:index];
                        pro_showInfoMsg([msg getString:DESC]);
                        
                        [queryData putKey:[result getString:NEXTSTARTROW] key:STARTROW];
                        [self syncWeb:requestType field:queryData];
                    }
                    else
                    {
                        index++;
                        if(index<[msgList count])
                        {
                            NSMutableDictionary* msg = [msgList dictAt:index];
                            pro_showInfoMsg([msg getString:DESC]);
                            [queryData putKey:@"0" key:STARTROW];
                            [queryData putKey:[msg getString:@"MsgType"] key:METHOD];
                            
                            [self syncWeb:requestType field:queryData];
                        }
                        else
                        {
                            save_LoginDate(today());
                            save_UpdateTime(now());
                            save_Used(YES);
                            [self toMainMenu];
                            
                        }
                    }
                }
                else
                {
                    alert_showErrMsg([NSMutableString stringWithFormat:@"%@保存失败", [result getString:RETURNTYPE]]);
                }
                
            }
            else if(status==-1)
            {
                alert_showErrMsg([result getString:ERRMSG]);
            }
            
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _downLoadUrl]]];
}

/**
 [""]	;数据查询
 [""]	@param result <#result description#>
 [""]	@returns <#return value description#>
 [""] */
-(void)querALLData
{
    NSMutableDictionary* msg = [msgList dictAt:index];
    pro_showInfoMsg([msg getString:@"MsgInfo" ]);//DESC
    queryData=[NSMutableDictionary dictionary];
    [queryData putKey:user_Id() key:USERID];
    [queryData putKey:@"0" key:@"isAll"];
    [queryData putKey:@"0" key:@"startRow"];
    [queryData putKey:today() key:@"lastTime"];
    [queryData putKey:[msg getString:@"MsgType"] key:METHOD];
    [self syncWeb:requestType field:queryData];
}

-(void)querData
{
    NSMutableDictionary* msg = [msgList dictAt:index];
    pro_showInfoMsg([msg getString:DESC]);
    queryData=[NSMutableDictionary dictionary];
    [queryData putKey:user_Id() key:USERID];
    [queryData putKey:@"1" key:ISALL];
    [queryData putKey:@"0" key:STARTROW];
    [queryData putKey:update_time() key:LASTTIME];
    [queryData putKey:[msg getString:@"MsgType"] key:METHOD];
    [self syncWeb:requestType field:queryData];
}


@end
