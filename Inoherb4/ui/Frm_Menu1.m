//
//  Frm_Menu1.m
//  SFA1
//
//  Created by Ren Yong on 14-4-9.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "Frm_Menu1.h"
//#import "D_ArrayList.h"
#import "C_NavigationBar.h"
#import "F_Color.h"
#import "C_Button.h"
#import "F_UserData.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "Frm_MainMenu.h"
#import "DB.h"
#import "F_Alert.h"
#import "Frm_PlanList.h"
#import "Frm_Rpt.h"
#import "Frm_SetPlan.h"
#import "SyncWeb.h"
#import "Frm_ShowDocment.h"
#import "F_Date.h"
#import "C_MenuCell.h"
#import "C_ImageView.h"
#import "F_Font.h"
#import "Frm_MsgList.h"
#import "Frm_HDlist.h"
#import "Frm_SubmitRpt.h"
#import "Frm_ReportHistory.h"
#import "F_Phone.h"

#import "Frm_SkuList.h"


@interface Frm_Menu1 ()
{
    UITableView* _menuView;
    NSMutableArray* _menuList;
    D_Report* syncRpt;
    RequestType syncType;
    NSMutableDictionary* queryData;
    NSMutableDictionary* selectDownloadEoc;
    int downloadType;
    NSMutableArray* _msgList;
    int _index;
}

@end

@implementation Frm_Menu1


//int tableViewHeight;
-(id)init
{
    self=[super init];
    if (self) {
        self.sharedDownloadManager = [TCBlobDownloadManager sharedDownloadManager];
        
    }
    return self;
}

//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(syncRpt)
                                                   object:nil];
    [myThread start];
}

-(void)initBackView
{
    self.view.backgroundColor=UIColorFromRGB(0xffffff);
//    UIImage* imgBackground=[UIImage imageNamed:@"bg.jpg"];
//    C_ImageView* ImgVIewBackground=[[C_ImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) image:imgBackground];
//    [self.view addSubview:ImgVIewBackground];
}

-(void)syncRpt
{
        syncRpt=[[DB instance] submitPlan];
        if([[syncRpt getString:@"isSaved"] isEqualToString:@"Y"])
        {
            syncType=UPLOAD_PLAN;
            [[SyncWeb instance]syncWeb:UPLOAD_PLAN report:syncRpt delegate:self];
        }
//        else
//        {
////            syncRpt=[[DB instance] submitRpt];
////            if([[syncRpt getString:@"isSaved"] isEqualToString:@"Y"])
////            {
////                syncType=UPLOAD_REQUEST;
////                [[SyncWeb instance]syncWeb:UPLOAD_REQUEST report:syncRpt delegate:self];
////            }
////            else
////            {
//////                toast_showInfoMsg(LanguageForKey(@"uploadfinished"), 100);
//////                syncType=QUERY_REQUEST;
//////                if(!is_LoadDoc())
//////                {
//////                    [self querALLData];
//////                }
//////                else
//////                {
//////                    [self querData];//平台
//////                }
////            }
//        }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadMenuList];
    [self initBackView];
    [self initUI];
    
    //    [self download:@"http://www.parrowtech.com/shelf1.apk"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI
{
    //    self.view.backgroundColor = col_Background();
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"首页"];
    [self.view addSubview:bar];
    
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110,  22, 100,34)];
    [label setText:[NSString stringWithFormat:@"%@",user_Name1()]];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setTextColor:col_byIntColor(0xffffff)];
    [label setFont:fontBysize(13)];
    [self.view addSubview:label];
    //    [self.navigationController.view setBackgroundColor:col_Button()];
    //	[self.navigationController.navigationBar setBackgroundColor:col_Button()];
    [self initMenuView];
}

-(void)initMenuView
{
    int totalW=self.view.frame.size.width-10;
    int buttonW=totalW/2;
    
    int buttonH=(self.view.frame.size.height-SYSTITLEHEIGHT-buttonW*3)/4;
    
    _menuView = [[UITableView alloc]initWithFrame:CGRectMake(0, SYSTITLEHEIGHT+buttonH,self.view.frame.size.width,self.view.frame.size.height-SYSTITLEHEIGHT-buttonH) style:UITableViewStylePlain];
    _menuView.delegate = self;
    _menuView.dataSource = self;
    _menuView.backgroundColor=[UIColor clearColor];
    _menuView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_menuView];
}

//加载分类数据
- (void)loadMenuList{
    _menuList = [[NSMutableArray alloc]init];
    NSMutableArray* arr=[[NSMutableArray alloc]init];
    
    
    NSMutableDictionary*     field=[NSMutableDictionary dictionary];
    [field put:@"当日考勤" key:@"title"];
    [field putInt:99 key:@"value"];
    [field put:@"1" key:@"TemplateId"];
    [arr addDict:field];
    
    field=[NSMutableDictionary dictionary];
    [field put:@"当日工作" key:@"title"];
    [field putInt:100 key:@"value"];
    [arr addDict:field];
    [_menuList addArray:arr];
    
    arr=[[NSMutableArray alloc]init];
    field=[NSMutableDictionary dictionary];
    [field put:@"设定计划" key:@"title"];
    [field putInt:101 key:@"value"];
    [field put:@"1" key:@"TemplateId"];
    [arr addDict:field];

    field=[NSMutableDictionary dictionary];
    [field put:@"电子资料" key:@"title"];
    [field putInt:105 key:@"value"];
    [arr addDict:field];
     [_menuList addArray:arr];
    
    arr=[[NSMutableArray alloc]init];
    field=[NSMutableDictionary dictionary];
    [field put:@"消息公告" key:@"title"];
    [field putInt:104 key:@"value"];
    [arr addDict:field];
    
    field=[NSMutableDictionary dictionary];
    [field put:@"系统设置" key:@"title"];
    [field putInt:106 key:@"value"];
    [arr addDict:field];


        [_menuList addArray:arr];
}

-(void)delegate_menuButtonClick:(int)buttonId
{
    switch (buttonId) {
            
        case 99:{
            Frm_SkuList* nextFrm = [[Frm_SkuList alloc] init];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
            

            
        case 100:{
            Frm_MainMenu * nextFrm = [[Frm_MainMenu alloc] init];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
        case 101:
        {
            Frm_SetPlan * nextFrm = [[Frm_SetPlan alloc] init];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
      
        case 103:
        {
//                        Frm_HDlist * nextFrm = [[Frm_HDlist alloc] init:nil];
//                        [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
        case 104:
        {
            Frm_MsgList* nextFrm = [[Frm_MsgList alloc] init];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
        case 105:
        {
            Frm_ShowDocment * nextFrm = [[Frm_ShowDocment alloc] init];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
            

            
        case 106:
        {
                        NSMutableDictionary* dicRptData=[NSMutableDictionary dictionary];
                        [dicRptData put:[NSString stringWithFormat:@"%d",-1001 ] key:@"templateid"];
                        Frm_SubmitRpt * nextFrm = [[Frm_SubmitRpt alloc] init:dicRptData ];
                        [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;
            
        case 107:
        {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新数据?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" ,nil  ];
            [alertView show];
        }
//            [self loadData];
            break;
        case 108:
        {
            Frm_ReportHistory * nextFrm = [[Frm_ReportHistory alloc] init];
            [self.navigationController pushViewController:nextFrm animated:YES];
        }
            break;

            
            
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        pro_showInfoMsg(@"验证用户名密码,请稍候");
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(loadData) userInfo:nil repeats:NO];
    }
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

-(void)loadData
{
    
    
    NSMutableDictionary* field=[NSMutableDictionary dictionary];
    [field putKey:user_Name() key:USERNAME];
    [field putKey:user_Pwd() key:PWD];
    [field putKey:APPVERSION1 key:VERSION];
    //        [field putKey:client_type() key:DEVICETYPE];
    [field putKey:@"asdad" key:DEVICETYPE];
    [field putKey:idfv key:IMEI];
    [field putKey:LOGIN key:METHOD];
    [field putKey:[NSString stringWithFormat:@"%f",availableMemory()] key:@"freeSpace"];
    [field putKey:user_version key:@"mobileVersion"];
    
    syncType=LOGIN_REQUEST;
    
    [self syncWeb:syncType field:field];
}



#pragma mark - TableViewdelegate&&TableViewdataSource
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    int totalW=self.view.frame.size.width-10;
    int buttonW=totalW/2;
    
    int buttonH=(self.view.frame.size.height-SYSTITLEHEIGHT-buttonW*3)/4;
    
    return buttonH+buttonW;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    D_Result* value=[result getResult:section];
    return [_menuList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray* field=[_menuList arrayAt:indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    C_MenuCell* cellRpt=[[C_MenuCell alloc ]init:CGRectMake(0, 0, self.view.frame.size.width, _menuView.frame.size.height/2) data:field ];
    cellRpt.delegate=self;
    [cell addSubview:cellRpt];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    [_tableView reloadData];
    //    NSMutableDictionary* field=[_menuList dictAt:indexPath.row];
    //    [self toFrm:field];
    
    //    Frm_SkuList *nextFrm = [[Frm_SkuList alloc] init];
    //    [self.navigationController pushViewController:nextFrm animated:YES];
}



- (void)delegate_requestDidSuccess:(D_SyncResult*)result
{
    stopProgress();
    int status=[result getInt:SUCCESS];
    switch (syncType) {
            //
        case UPLOAD_REQUEST:
        {
            status=[[result getField:0] getInt:SUCCESS];
            if (status==1)
            {
                
                NSString* sql=[NSString stringWithFormat:@"update t_data_callreport set issubmit='1' where key_id='%@'",[syncRpt getString:@"key_id"]];
                [[DB instance] execSql:sql];
                
//                [self syncRpt];
                
            }
            else if(status==-1)
            {
                NSString* sql=[NSString stringWithFormat:@"update t_data_callreport set issubmit='2' where key_id='%@'",[syncRpt getString:@"key_id"]];
                [[DB instance] execSql:sql];
                toast_showInfoMsg([result getString:ERRMSG], 100);
            }
            
            NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                         selector:@selector(syncRpt)
                                                           object:nil];
            [myThread start];
        }
            break;
        case UPLOAD_PLAN:
        {
            status=[[result getField:0] getInt:SUCCESS];
            if (status==1)
            {
                NSMutableArray* list=[[NSMutableArray alloc]init];
                NSString* sql;
                int index=0;
                for (NSMutableDictionary* detail in  [syncRpt detailList]) {
                    sql=[NSString stringWithFormat:@"update t_visit_plan_detail set issubmit='1' ,serverid='%@' where key_id ='%@'",[[result getField:index] getString:@"ReportId"],[detail getString:@"key_id"]];
                    
                    [list addObject:sql];
                    index++;
                }
                [[DB instance] execSqlList:list];
               
            }
            else if(status==-1)
            {
                //        NSString* sql=[NSString stringWithFormat:@"update t_data_callreport set issubmit='2' where key_id='%@'",[syncRpt getString:@"key_id"]];
                //        [[DB instance] execSql:sql];
                //        //                isSync=true;
                //        toast_showInfoMsg([result getString:ERRMSG], 100);
            }
            NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                         selector:@selector(syncRpt)
                                                           object:nil];
            [myThread start];
        }
            break;
            
        case LOGIN_REQUEST:
            if (status==1)
            {                
                _msgList=[result getFieldList];
                syncType=QUERY_REQUEST;
                _index=0;
                 [self querALLData];
            }
            else if(status==-1)
            {
                alert_showErrMsg([result getString:@"ErrorMsg"]);
            }
            else if(status==-2)
            {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"检测到新版本，请先更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
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
                        NSMutableDictionary* msg = [_msgList dictAt:_index];
                        pro_showInfoMsg([msg getString:DESC]);
                        
                        [queryData putKey:[result getString:NEXTSTARTROW] key:STARTROW];
                        [self syncWeb:syncType field:queryData];
                    }
                    else
                    {
                        _index++;
                        if(_index<[_msgList count])
                        {
                            NSMutableDictionary* msg = [_msgList dictAt:_index];
                            pro_showInfoMsg([msg getString:DESC]);
                            [queryData putKey:@"0" key:STARTROW];
                            [queryData putKey:[msg getString:@"MsgType"] key:METHOD];
                            
                            [self syncWeb:syncType field:queryData];
                        }
                        else
                        {
                            toast_showInfoMsg(@"数据更新成功", 100);
                            
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
            
            break;
        default:
            break;
    }
}


-(void)downLoadEoc
{
    //    NSMutableArray* downloadEoc=[[DB instance] fieldListByData:nil type:DOWNLOADEOC];
    //    if([downloadEoc count]>0)
    //    {
    //
    //        selectDownloadEoc=[downloadEoc dictAt:0];
    //        if([[selectDownloadEoc getString:@"issubmit"] isEqualToString:@"-1"])
    //        {
    ////            downloadType=0;
    //            [self downloadFrontCover];
    //        }
    //        else if([[selectDownloadEoc getString:@"issubmit"] isEqualToString:@"0"])
    //        {
    ////            downloadType=1;
    //            [self downloadDoc];
    //        }
    //    }
    //    else
    //        toast_showInfoMsg(@"下载完成", 100);
}

-(void)downloadFrontCover
{
    downloadType=0;
    [self download:[NSString stringWithFormat:@"%@%@",DOWNLOADURL,[selectDownloadEoc getString:@"frontCoverPhotoPath"]]];
}

-(void)downloadDoc
{
    downloadType=1;
    [self download:[NSString stringWithFormat:@"%@%@", DOWNLOADURL, [selectDownloadEoc getString:@"docPath"]]];
}

-(void) delegate_requestDidFail:(NSString*) errMsg
{
    stopProgress();
    toast_showInfoMsg(errMsg,100);
    
    [self syncRpt];
}

- (void)download:(NSString*)url
{
    // Delegate
    /*[self.sharedDownloadManager startDownloadWithURL:self.urlField.text
     customPath:nil
     andDelegate:self];*/
    
    // Blocks
    //  TCBlobDownload* downLoad=[self.sharedDownloadManager startDownloadWithURL:[NSURL URLWithString:url]
    //                                          customPath:nil
    //                                       firstResponse:NULL
    //                                            progress:NULL
    //                                               error:NULL
    //                                            complete:NULL];
    //
    ////    downLoad
    //    downLoad.delegate=self;
    NSLog(@"下载链接%@",url);
    [self.sharedDownloadManager startDownloadWithURL:[NSURL URLWithString:url] customPath:nil delegate:self];
    
    //    downLoad.isFinished
    
}

- (void)cancelAll:(id)sender
{
    [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
}


#pragma mark - BlobDownloadManager Delegate (Optional, your choice)


- (void)download:(TCBlobDownload *)blobDownload didReceiveFirstResponse:(NSURLResponse *)response
{
    
}

- (void)download:(TCBlobDownload *)blobDownload
  didReceiveData:(uint64_t)receivedLength
         onTotal:(uint64_t)totalLength
{
    //    if(receivedLength==totalLength)
    //        NSLog(@"下载完成");
    //    NSLog(@"asdasd:%lld,asdasd:%lld",receivedLength,totalLength);
}

- (void)download:(TCBlobDownload *)blobDownload didStopWithError:(NSError *)error
{
    NSLog(error.description);
    
    if(downloadType==0)
    {
        [[DB instance] execSql:[NSString stringWithFormat:@"update t_data_edoc set issubmit = '2', str10='%@' where key_id=%@",error.description,[selectDownloadEoc getString:@"key_id"]]];
        [self downloadDoc];
    }else
    {
        [[DB instance] execSql:[NSString stringWithFormat:@"update t_data_edoc set issubmit = '3',str10='%@' where key_id=%@",error.description,[selectDownloadEoc getString:@"key_id"]]];
        [self downLoadEoc];
    }
}

- (void)download:(TCBlobDownload *)blobDownload didCancelRemovingFile:(BOOL)fileRemoved
{
    
}

- (void)download:(TCBlobDownload *)blobDownload didFinishWithSucces:(BOOL)downloadFinished atPath:(NSString *)pathToFile
{
    
    if(downloadFinished)
    {
        if(downloadType==0)
        {
            [[DB instance] execSql:[NSString stringWithFormat:@"update t_data_edoc set issubmit = '0' where key_id=%@",[selectDownloadEoc getString:@"key_id"]]];
            [self downloadDoc];
        }else
        {
            NSLog(@"文件地址:%@",pathToFile);
            [[DB instance] execSql:[NSString stringWithFormat:@"update t_data_edoc set issubmit = '1' where key_id=%@",[selectDownloadEoc getString:@"key_id"]]];
            [self downLoadEoc];
        }
    }
    else
        toast_showInfoMsg(@"网络异常", 100);
}

-(void) syncWeb:(RequestType)type field:(NSMutableDictionary* )field
{
    [[SyncWeb instance]syncWeb:type field:field delegate:self];
}
/**
 [""]	;数据查询
 [""]	@param result <#result description#>
 [""]	@returns <#return value description#>
 [""] */
//-(void)querALLData
//{
//    //平台
//    queryData=[NSMutableDictionary dictionary];
//    [queryData putKey:user_Id() key:USERID];
//    [queryData putKey:@"0" key:ISALL];
//    [queryData putKey:@"0" key:STARTROW];
//    [queryData putKey:@"downloadEdoc" key:METHOD];
//    [self syncWeb:syncType field:queryData];
//}

-(void)querALLData
{
    NSMutableDictionary* msg = [_msgList dictAt:_index];
    pro_showInfoMsg([msg getString:@"MsgInfo" ]);//DESC
    queryData=[NSMutableDictionary dictionary];
    [queryData putKey:user_Id() key:USERID];
    [queryData putKey:@"0" key:@"isAll"];
    [queryData putKey:@"0" key:@"startRow"];
    [queryData putKey:today() key:@"lastTime"];
    [queryData putKey:[msg getString:@"MsgType"] key:METHOD];
    [self syncWeb:syncType field:queryData];
}

-(void)querData
{
    queryData=[NSMutableDictionary dictionary];
    [queryData putKey:user_Id() key:USERID];
    [queryData putKey:@"1" key:ISALL];
    [queryData putKey:@"0" key:STARTROW];
    [queryData putKey:diffDate(update_time(),-1) key:LASTTIME];
    [queryData putKey:@"downloadEdoc" key:METHOD];
    [self syncWeb:syncType field:queryData];
}


@end
