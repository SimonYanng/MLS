//
//  Constants.h
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#define DOWNLOADURL @"http://www.parrowtech.com/ios/RB-business.html"
//#define BASEURL @"http://223.4.23.60:8078/DataWebService.asmx"
#define BASEURL @"http://223.4.23.60:8357/DataWebService.asmx"

#define APPVERSION @"1.0"
#define APPVERSION1 @"v1.0"

#define HOTLINE @"客服电话:400-672-9851"

//服务器
#define LOGINSERVICE @"loginService"
#define QUERYSERVICE @"downloadService"
#define UPLOADSERVICE @"uploadService"

//接口方法
//#define LOGIN @"login"
#define LOGIN @"UserLogin"

//登录参数
#define USERNAME @"userName"
#define PWD @"pwd"
#define IMEI @"imei"
#define VERSION @"appVersion"
#define DEVICETYPE @"deviceType"

//查询参数
#define USERID @"userId"
#define ISALL @"isAll"
#define STARTROW @"startRow"
#define NEXTSTARTROW @"nextstartrow"
#define METHOD @"method"
#define LASTTIME @"lastTime"

//返回的数据
#define ERRMSG @"Msg"
#define DESC @"MsgInfo"
#define SUCCESS @"success"
#define USERID @"userId"
#define DONE @"done"
//#define NEXTSTARTROW @"nextStartRow"
#define RETURNTYPE @"type"

//数据列表
#define MSGTYPELIST @"msgTypeList"
#define CLIENTTABLE @"clientTable"

#define TABLE @"Table"

//数据库信息
#define FILENAME @"manon"
#define DBNAME @"yw.sqlite"



#define MOBILE_KEY @"uuid"


//tableview参数
#define HEADHEIGHT  30.0f
#define CELLHEIGHT    50

//标题栏参数
#define SYSTITLEHEIGHT    60.0f

#define BOTTOMHEIGHT 50.0f

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

//屏幕宽度
//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
//#define SYSTEMW 640
//#else
//#define SYSTEMW 320
//#endif

//#define SYSTEMW 320
#define SYSTEMH 640

//圆角大小
#define CORNERRADIUS 3.0f

//进出店照片高度
#define CHECKPHOTOHEIGHT 50

//字典参数
#define DICTITEMNAME @"labelname"
#define DICTVALUE @"value"
#define DICTREMARK @"remark"
#define DICTCODE @"dictcode"
#define DICTNAME @"dictname"


//地图参数
#define CLIENTNAME  @"clientname"
#define CLIENTADD @"clientadd"
//#define CLIENTLONG @"clientlong"
#define CLIENTLATLONG @"clientgps"





#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];


#define user_version [[UIDevice currentDevice] systemVersion]
#define client_type platformString()
//NSString * platformString(void)
//{
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
//    free(machine);
//    
//    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
//    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
//    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
//    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
//    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
//    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
//    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
//    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
//    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
//    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
//    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
//    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
//    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
//    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
//    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
//    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
//    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
//    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
//    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
//    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
//    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
//    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
//    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
//    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
//    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
//    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (WiFi)";
//    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
//    if ([platform isEqualToString:@"i386"])         return @"Simulator";
//    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
//    return platform;
//}

#define idfv [[[UIDevice currentDevice] identifierForVendor] UUIDString]
//当控件为text时,验证类型

enum
{
    DEFAULT,
    NUMBER,
    AMOUNT,
    PHONE,
    EMAIL,
    NUMBERTEXT,
    URL,
    BIGTEXT
};
typedef NSUInteger Verifytype;

//模板类型
enum
{
    LOGIN_FRM,
    MAINMENU_FRM,
};
typedef NSUInteger TempLateType;


//排列类型
enum
{
    HORIZONTAL,
    VERTICAL
};
typedef NSUInteger Orientation;

//控件类型
enum
{
    NONE,
    TEXT,
    MULTICHOICE,
    SINGLECHOICE,
    RADIOBUTTON,
    DATE,
    CHECKBOX,
    TIME,
    DATETIME,
    BUTTON,
    SELECTPRODUCT,
    TAKEPHOTO,
    SHOTPHOTO
};
typedef NSUInteger ControlType;


//request类型
enum
{
    LOGIN_REQUEST,
    QUERY_REQUEST,
    UPLOAD_REQUEST,
    UPLOAD_PLAN,
    QUERY_MSG,
    UPLOAD_MSG
};
typedef NSUInteger RequestType;

//数据库,表的字段类型
enum
{
    VACHAR,
    INTEGER,
    BLOB,
    TIMESTAMP
};
typedef NSUInteger TableFieldType;

//拍照类型
enum
{
    CHECKIN,
    CHECKOUT
};
typedef NSUInteger PhotoType;


//sql类型
enum
{
    VISITPLAN,
    HOCPLAN,
    DICTSQL,
    SEARCHCLIENT,
    COMPLETERPT
};
typedef NSUInteger SqlType;

//按钮类型
enum
{
    LOGINBUTTON,
    NAVBUTTON,
    RPTBUTTON
};
typedef NSUInteger buttonType;


//计算类型
enum
{
    DIVISOR,//除数
    DIVIDER,//被除数
};
typedef NSUInteger RequestType;
