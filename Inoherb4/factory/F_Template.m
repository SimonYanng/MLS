//
//  F_Template.m
//  SFA
//
//  Created by Ren Yong on 13-10-18.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "F_Template.h"
#import "D_UIItem.h"
#import "F_Color.h"
#import "F_Date.h"
#import "D_TempGroup.h"
#import "NSMutableArray+Tool.h"
#import "NSMutableDictionary+Tool.h"
#import "DB.h"
#import "F_UserData.h"
void addTemp(D_TempGroup*tempGroup, NSString*dictId, int type)
{
    NSMutableArray* dictList= [[DB instance] dictList:dictId];
    int tempType;
    D_Template* t;
    for (NSMutableDictionary* dict in dictList) {
        tempType = type*1000000 + [dict getInt:@"value"];
        t = [[D_Template alloc] init];
        t.name=[dict getString:@"labelname"];
        t.onlyType=tempType;
        //        t.inputType=3;
        //        t.isMustComplete=true;
        t.type=[NSString stringWithFormat:@"%d",tempType] ;
        [tempGroup addTemp:t];
    }
}

void addTemp1(D_TempGroup*tempGroup, NSString*dictId, int type,NSString* clientId)
{
    NSMutableArray* dictList= [[DB instance] dictList:dictId clientId:clientId];
    int tempType;
    D_Template* t;
    for (NSMutableDictionary* dict in dictList) {
        tempType = type*10000 + [dict getInt:@"value"];
        t = [[D_Template alloc] init];
        t.name=[dict getString:@"labelname"];
        t.onlyType=tempType;
        //        t.inputType=3;
        
        t.type=[NSString stringWithFormat:@"%d",tempType] ;
        [tempGroup addTemp:t];
    }
}

NSMutableArray* tempGroup_sales()
{
    NSMutableArray* list=[[NSMutableArray alloc] init];
    
    D_TempGroup* group=[[D_TempGroup alloc] init];
    group.showTitle=NO;
    group.name=@"基础管理";
    D_Template* temp=[[D_Template alloc] init];
    temp.type=@"1";
    temp.onlyType=1;
    //    temp.isMustComplete=YES;
    temp.name=@"客户资料管理报告";
    //    temp.inputType=2;
    [group addTemp:temp];
    
    temp=[[D_Template alloc] init];
    temp.type=@"2";
    temp.onlyType=2;
    //    temp.isMustComplete=YES;
    temp.name=@"分销管理报告";
    //    temp.inputType=2;
    [group addTemp:temp];
    
    
    temp=[[D_Template alloc] init];
    temp.type=@"3";
    temp.onlyType=3;
    //    temp.isMustComplete=YES;
    temp.name=@"新品铺货管理报告";
    //    temp.inputType=2;
    [group addTemp:temp];
    
    temp=[[D_Template alloc] init];
    temp.type=@"4";
    temp.onlyType=4;
    //    temp.isMustComplete=YES;
    temp.name=@"终端检查";
    //    temp.inputType=2;
    [group addTemp:temp];
    
    temp=[[D_Template alloc] init];
    temp.type=@"5";
    temp.onlyType=5;
    //    temp.isMustComplete=YES;
    temp.name=@"销量上报";
    //    temp.inputType=2;
    [group addTemp:temp];
    
    temp=[[D_Template alloc] init];
    temp.type=@"6";
    temp.onlyType=6;
    //    temp.isMustComplete=YES;
    temp.name=@"库存管理";
    //    temp.inputType=2;
    [group addTemp:temp];
    
    [list addTempGroup:group];
    
    group=[[D_TempGroup alloc] init];
    group.name=@"竞品管理";
    
    addTemp(group ,@"100",7);
    //    temp=[[D_Template alloc] init];
    //    temp.type=@"7";
    //1    temp.onlyType=7;
    //    //    temp.isMustComplete=YES;
    //    temp.name=@"活动执行报告";
    //    temp.inputType=2;
    //    [group addTemp:temp];
    
    [list addTempGroup:group];
    
    group=[[D_TempGroup alloc] init];
    group.showTitle=NO;
    group.name=@"客户反馈与建议";
    
    temp=[[D_Template alloc] init];
    temp.type=@"8";
    temp.onlyType=8;
    //    temp.isMustComplete=YES;
    temp.name=@"客户反馈与建议报告";
    //    temp.inputType=2;
    [group addTemp:temp];
    
    [list addTempGroup:group];
    
    
    return list;
}


NSMutableArray* tempGroup_task()
{
    NSMutableArray* list=[[NSMutableArray alloc] init];
    
    D_TempGroup* group=[[D_TempGroup alloc] init];
    group.name=@"事件填写";
    
    D_Template* temp=[[D_Template alloc] init];
    temp.type=@"20";
    temp.onlyType=20;
    temp.name=@"事件报告";
    //    temp.inputType=2;
    [group addTemp:temp];
    [list addTempGroup:group];
    
    return list;
}

NSMutableArray* tempGroup_AccountCall()
{
    NSMutableArray* list=[[NSMutableArray alloc] init];
    
    D_TempGroup* group=[[D_TempGroup alloc] init];
    group.name=@"客户拜访";
    
    D_Template* temp=[[D_Template alloc] init];
    temp.type=@"6";
    temp.onlyType=6;
    temp.name=@"客户拜访";
    //    temp.inputType=2;
    [group addTemp:temp];
    [list addTempGroup:group];
    
    return list;
}

D_Template* temp_ById(NSString* tempId,NSString* name)
{
    
    NSLog(@"报告类型:%@",tempId);
    
    //    if ([tempId isEqualToString:@"3"])
    //    {
    //        return temp_QJ();
    //    }
    //    else if ([tempId isEqualToString:@"1"])
    //    {
    //        return temp_XLSB();
    //    }
    if ([tempId isEqualToString:@"-1"])
    {
        return temp_CheckIn();
    }
    else if ([tempId isEqualToString:@"-2"])
    {
        return temp_CheckOut();
    }
    
    else if ([tempId isEqualToString:@"1"])
    {
        return temp_JGYC();
    }
    else if ([tempId isEqualToString:@"2"])
    {
        return temp_ZCLTemplate();
    }
    else if ([tempId isEqualToString:@"3"])
    {
        return temp_D2CLYC();
    }
    
    else if ([tempId isEqualToString:@"4"])
    {
        return temp_SYXCLTemplate();
    }
    else if ([tempId isEqualToString:@"5"])
    {
        return temp_CXCLTemplate();
    }
    else if ([tempId isEqualToString:@"6"])
    {
        return temp_HDZXTemplate();
    }
    else if ([tempId hasPrefix:@"70"]||[tempId hasPrefix:@"69"])
    {
        return temp_JP(tempId,name);
    }
    else if ([tempId isEqualToString:@"8"])
    {
        return temp_XP();
    }
    
    
    else if ([tempId isEqualToString:@"9"])
    {
        return temp_RYJCTemplate();
    }
    
    else if ([tempId isEqualToString:@"10"])
    {
        return temp_XLYBTemplate();
    }
    
    
    else if ([tempId intValue] ==-1001)
    {
        return temp_EditPwd();
    }
    
    
    else if ([tempId intValue] ==20)
    {
        return temp_Task();
    }
    
    else if ([tempId intValue] ==-3)
    {
        return temp_StartWork();
    }
    else if ([tempId intValue] ==-4)
    {
        return temp_StopWork();
    }
    
    
    
    return nil;
}


D_Template* temp_StartWork()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"-3";
    table.onlyType=-3;
    table.name=@"上班报告";
    table.isMustPhoto=YES;
    
    
    //    D_Panel* panel=[[D_Panel alloc]init];
    //    panel.name=@"指标";
    //    panel.type=PANEL_PANEL;
    //
    //    D_UIItem* item=[[D_UIItem alloc]init];
    //    item.caption=@"当日指标";
    //    item.controlType=TEXT;
    //    item.verifyType=NUMBER;
    //    item.dataKey=@"INT1";
    //    item.isMustInput=YES;
    //    item.maxValue=999999;
    //    item.placeholder=@"当日指标";
    //    item.isShowCaption=YES;
    //    [panel addItem:item];
    //
    //    [table addPanel:panel];
    
    
    //    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    //    [button put:@"基本信息" key:@"name"];
    //    [button putInt:1 key:@"buttonId"];
    //    [table addButtonList:button];
    
    NSMutableDictionary*  button=[NSMutableDictionary dictionary];
    [button put:@"照片" key:@"name"];
    [button putInt:3 key:@"buttonId"];
    [table addButtonList:button];
    
    return table;
}


D_Template* temp_StopWork()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"-4";
    table.onlyType=-4;
    table.name=@"下班报告";
    table.isMustPhoto=YES;
    
    
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"照片" key:@"name"];
    [button putInt:3 key:@"buttonId"];
    [table addButtonList:button];
    
    return table;
}


D_Template* temp_JGYC()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"1";
    table.name=@"客户资料管理";
    table.onlyType=1;
    //    table.isMustPhoto=true;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"";
    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"客户名称";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str1";
    item.dicId=@"56";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"客户地址";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str2";
    item.dicId=@"56";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"老板姓名";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str3";
    item.dicId=@"56";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"联系方式";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str4";
    item.dicId=@"56";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"店内合作品牌";
    item.controlType=MULTICHOICE;
    item.verifyType=DEFAULT;
    item.dataKey=@"str5";
    item.dicId=@"100";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"其他";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str6";
    item.dicId=@"56";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"基础信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    //    button=[NSMutableDictionary dictionary];
    //    [button put:@"照片" key:@"name"];
    //    [button putInt:3 key:@"buttonId"];
    //    [table addButtonList:button];
    return table;
}


D_Template* temp_ZCLTemplate()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"2";
    table.onlyType=2;
    table.name=@"分销管理";
    //        table.isMustPhoto=YES;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"";
    panel.showTitle=NO;
    panel.type=PANEL_TABLE;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"产品名称";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.dataKey=@"productname";
    item.dicId=@"56";
    item.lableWidth=75;
    item.textAlignment=NSTextAlignmentLeft;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"有无分销";
    item.controlType=SINGLECHOICE;
    item.verifyType=NUMBER;
    item.dataKey=@"int1";
    item.dicId=@"200";
    item.lableWidth=25;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    NSMutableDictionary*
    button=[NSMutableDictionary dictionary];
    [button put:@"产品信息" key:@"name"];
    [button putInt:2 key:@"buttonId"];
    [table addButtonList:button];
    
    //        button=[NSMutableDictionary dictionary];
    //        [button put:@"拍照" key:@"name"];
    //        [button putInt:3 key:@"buttonId"];
    //        [table addButtonList:button];
    //
    return table;
}

D_Template* temp_D2CLYC()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"3";
    table.name=@"新品铺货管理";
    table.onlyType=3;
    //        table.isMustPhoto=true;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"";
    panel.type=PANEL_TABLE;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"新品名称";
    item.controlType=NONE;
    item.dataKey=@"productname";
    item.dicId=@"-100";
    //    item.isMustInput=YES;
    item.textAlignment=NSTextAlignmentLeft;
    item.lableWidth=75;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"是否铺货";
    item.controlType=SINGLECHOICE;
    item.verifyType=NUMBER;
    item.dataKey=@"int1";
    item.dicId=@"40";
    //    item.isMustInput=YES;
    item.textAlignment=NSTextAlignmentCenter;
    item.lableWidth=25;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"产品信息" key:@"name"];
    [button putInt:2 key:@"buttonId"];
    [table addButtonList:button];
    
    //    button=[NSMutableDictionary dictionary];
    //    [button put:@"照片" key:@"name"];
    //    [button putInt:3 key:@"buttonId"];
    //    [table addButtonList:button];
    return table;
}


D_Template* temp_SYXCLTemplate()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"4";
    table.onlyType=4;
    table.name=@"终端检查";
    //        table.isMustPhoto=YES;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"检查";
    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"是否有店招";
    item.controlType=SINGLECHOICE;
    item.verifyType=NUMBER;
    item.dataKey=@"int1";
    item.dicId=@"40";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"是否有海报张贴";
    item.controlType=SINGLECHOICE;
    item.verifyType=NUMBER;
    item.dataKey=@"int2";
    item.dicId=@"40";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"是否有条幅悬挂";
    item.controlType=SINGLECHOICE;
    item.verifyType=NUMBER;
    item.dataKey=@"int3";
    item.dicId=@"40";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"是否有展板";
    item.controlType=SINGLECHOICE;
    item.verifyType=NUMBER;
    item.dataKey=@"int4";
    item.dicId=@"40";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"是否有试灯台";
    item.controlType=SINGLECHOICE;
    item.verifyType=NUMBER;
    item.dataKey=@"int5";
    item.dicId=@"40";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"光源产品是否集中陈列";
    item.controlType=SINGLECHOICE;
    item.verifyType=NUMBER;
    item.dataKey=@"int6";
    item.dicId=@"40";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"其他终端展示";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str1";
    item.dicId=@"56";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    
    
    NSMutableDictionary*
    button=[NSMutableDictionary dictionary];
    [button put:@"基本信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    //    button=[NSMutableDictionary dictionary];
    //    [button put:@"产品信息" key:@"name"];
    //    [button putInt:2 key:@"buttonId"];
    //    [table addButtonList:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"拍照" key:@"name"];
    [button putInt:3 key:@"buttonId"];
    [table addButtonList:button];
    
    return table;
    
    
}



D_Template* temp_CXCLTemplate()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"5";
    table.onlyType=5;
    table.name=@"销量上报";
    //    table.isMustPhoto=YES;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"促销陈列";
    panel.showTitle=NO;
    panel.type=PANEL_TABLE;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"产品名称";
    item.controlType=NONE;
    item.verifyType=AMOUNT;
    item.dataKey=@"productname";
    item.dicId=@"56";
    item.lableWidth=70;
    item.textAlignment=NSTextAlignmentLeft;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"金额(元)";
    item.controlType=TEXT;
    item.verifyType=AMOUNT;
    item.dataKey=@"str1";
    item.dicId=@"56";
    item.lableWidth=30;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    NSMutableDictionary*
    button=[NSMutableDictionary dictionary];
    [button put:@"产品信息" key:@"name"];
    [button putInt:2 key:@"buttonId"];
    [table addButtonList:button];
    
    //    button=[NSMutableDictionary dictionary];
    //    [button put:@"拍照" key:@"name"];
    //    [button putInt:3 key:@"buttonId"];
    //    [table addButtonList:button];
    
    return table;
    
    
}

D_Template* temp_HDZXTemplate()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"6";
    table.onlyType=6;
    table.name=@"库存管理";
    //    table.isMustPhoto=YES;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"库存";
    panel.showTitle=NO;
    panel.type=PANEL_TABLE;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"产品名称";
    item.controlType=NONE;
    item.verifyType=AMOUNT;
    item.dataKey=@"productname";
    item.dicId=@"56";
    item.textAlignment=NSTextAlignmentLeft;
    item.lableWidth=70;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"库存";
    item.controlType=TEXT;
    item.verifyType=NUMBER;
    item.dataKey=@"int1";
    item.dicId=@"56";
    item.lableWidth=30;
    [panel addItem:item];
    
    
    
    [table addPanel:panel];
    
    NSMutableDictionary*
    button=[NSMutableDictionary dictionary];
    [button put:@"产品信息" key:@"name"];
    [button putInt:2 key:@"buttonId"];
    [table addButtonList:button];
    
    //    button=[NSMutableDictionary dictionary];
    //    [button put:@"拍照" key:@"name"];
    //    [button putInt:3 key:@"buttonId"];
    //    [table addButtonList:button];
    
    return table;
    
}

D_Template* temp_XP()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"8";
    table.name=@"客户反馈与建议";
    table.onlyType=8;
    //    table.isMustPhoto=true;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"";
    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"客情反馈";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"int1";
    item.dicId=@"101";
    //    item.isMustInput=YES;
    item.textAlignment=NSTextAlignmentLeft;
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    
    item=[[D_UIItem alloc]init];
    item.caption=@"建议";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str1";
    item.textAlignment=NSTextAlignmentCenter;
    item.dicId=@"40";
    //    item.isMustInput=YES;
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"补充说明";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str2";
    item.textAlignment=NSTextAlignmentCenter;
    item.dicId=@"40";
    //    item.isMustInput=YES;
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    //    button=[NSMutableDictionary dictionary];
    //    [button put:@"照片" key:@"name"];
    //    [button putInt:3 key:@"buttonId"];
    //    [table addButtonList:button];
    return table;
}


D_Template* temp_JP(NSString* type,NSString* name)
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"7";
    table.name=name;
    table.onlyType=[type intValue];
    //    table.isMustPhoto=true;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"";
    panel.showTitle=NO;
    //    panel.intputType=1;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item;
    if([type isEqualToString:@"7000006"])
    {
        item=[[D_UIItem alloc]init];
        item.caption=@"竞品名称";
        item.controlType=TEXT;
        item.verifyType=DEFAULT;
        item.dataKey=@"str3";
        item.dicId=@"-100";
        item.isMustInput=YES;
        item.textAlignment=NSTextAlignmentLeft;
        item.lableWidth=labelW()+30;
        [panel addItem:item];
    }
    
    item=[[D_UIItem alloc]init];
    item.caption=@"有无促销";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"int2";
    item.dicId=@"200";
    //    item.isMustInput=YES;
    item.textAlignment=NSTextAlignmentLeft;
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    
    item=[[D_UIItem alloc]init];
    item.caption=@"促销品项";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str1";
    item.dicId=@"-100";
    //    item.isMustInput=YES;
    item.textAlignment=NSTextAlignmentLeft;
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"促销政策";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str2";
    item.dicId=@"-100";
    //    item.isMustInput=YES;
    item.textAlignment=NSTextAlignmentLeft;
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"照片" key:@"name"];
    [button putInt:3 key:@"buttonId"];
    [table addButtonList:button];
    return table;
}


D_Template* temp_RYJCTemplate()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"9";
    table.onlyType=9;
    table.name=@"潜在客户";
    //    table.isMustPhoto=YES;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"";
    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"客户名称";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str1";
    item.dicId=@"200";
    item.isMustInput=YES;
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"客户地址";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str2";
    item.dicId=@"40";
    item.isMustInput=YES;
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"老板姓名";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str3";
    item.dicId=@"302";
    item.isMustInput=YES;
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"联系方式";
    item.controlType=TEXT;
    item.verifyType=PHONE;
    item.dataKey=@"str4";
    item.isMustInput=YES;
    item.dicId=@"302";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"店内合作品牌";
    item.controlType=MULTICHOICE;
    //    item.verifyType=AMOUNT;
    item.dataKey=@"str5";
    item.dicId=@"100";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"其他";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str6";
    item.dicId=@"302";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"洽谈情况";
    item.controlType=SINGLECHOICE;
    //    item.verifyType=AMOUNT;
    item.dataKey=@"int1";
    item.dicId=@"102";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"补充说明";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str7";
    item.dicId=@"302";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    NSMutableDictionary*
    button=[NSMutableDictionary dictionary];
    [button put:@"基本信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    //    button=[NSMutableDictionary dictionary];
    //    [button put:@"拍照" key:@"name"];
    //    [button putInt:3 key:@"buttonId"];
    //    [table addButtonList:button];
    
    return table;
    
}


D_Template* temp_XLYBTemplate()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"10";
    table.onlyType=10;
    table.name=@"销售月报";
    //    table.isMustPhoto=YES;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"销售月报";
    panel.showTitle=NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"上月销售占比(%)";
    item.controlType=TEXT;
    item.verifyType=AMOUNT;
    item.dataKey=@"str1";
    item.dicId=@"200";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    
    [table addPanel:panel];
    
    NSMutableDictionary*
    button=[NSMutableDictionary dictionary];
    [button put:@"基本信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"拍照" key:@"name"];
    [button putInt:3 key:@"buttonId"];
    [table addButtonList:button];
    
    return table;
    
}

D_Template* temp_FHZJTemplate()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"5";
    table.onlyType=5;
    table.name=@"访店总结";
    //    table.isMustPhoto=YES;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"访店总结";
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"店铺人员的反馈与建议";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str1";
    item.dicId=@"56";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"商品对品牌的看法与需求，对代理商如何评价？";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str2";
    item.dicId=@"55";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"其他总结";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str3";
    item.dicId=@"57";
    item.lableWidth=labelW()+30;
    [panel addItem:item];
    
    
    [table addPanel:panel];
    
    NSMutableDictionary*
    button=[NSMutableDictionary dictionary];
    [button put:@"基础数据" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    //    button=[NSMutableDictionary dictionary];
    //    [button put:@"Top5产品" key:@"name"];
    //    [button putInt:2 key:@"buttonId"];
    //    [table addButtonList:button];
    
    return table;
    
    
}



D_Template* temp_Task()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"20";
    table.name=@"事件";
    table.onlyType=20;
    //    table.isMustPhoto=YES;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"";
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"描述";
    item.controlType=TEXT;
    item.verifyType=BIGTEXT;
    item.dataKey=@"str1";
    item.placeholder=@"描述";
    item.isShowCaption=YES;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"基本信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"照片" key:@"name"];
    [button putInt:3 key:@"buttonId"];
    [table addButtonList:button];
    
    return table;
}


D_Template* temp_QJ()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"51";
    table.name=@"当日请假";
    table.onlyType=51;
    //    table.isMustPhoto=YES;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"时间";
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"开始时间";
    item.controlType=DATETIME;
    item.verifyType=DEFAULT;
    item.dataKey=@"STR1";
    //    item.isMustInput=YES;
    //    item.maxValue=999999;
    item.placeholder=@"开始时间";
    item.isShowCaption=YES;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"结束时间";
    item.controlType=DATETIME;
    item.verifyType=DEFAULT;
    item.dataKey=@"STR2";
    //    item.isMustInput=YES;
    //    item.maxValue=999999;
    item.placeholder=@"结束时间";
    item.isShowCaption=YES;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    panel=[[D_Panel alloc]init];
    panel.name=@"原因说明";
    panel.type=PANEL_PANEL;
    
    item=[[D_UIItem alloc]init];
    item.caption=@"原因说明";
    item.controlType=TEXT;
    item.verifyType=BIGTEXT;
    item.dataKey=@"STR3";
    item.placeholder=@"原因说明";
    item.isShowCaption=NO;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"基本信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    return table;
}

/**
 <#Description#> 获取登录界面模板
 @returns <#return value description#>
 */
D_Template* temp_Login()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=LOGIN_FRM;
    table.name=@"登录";
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"登录";
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"用户名";
    item.controlType=TEXT;
    item.verifyType=EMAIL;
    item.dataKey=USERNAME;
    item.maxLenth=50;
    item.superViewColor=col_White();
    item.placeholder=@"用户名";
    item.isShowCaption=NO;
    item.textAlignment=NSTextAlignmentLeft;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"密码";
    item.controlType=TEXT;
    item.dataKey=PWD;
    item.maxLenth=10;
    item.superViewColor=col_White();
    item.placeholder=@"密码";
    item.isShowCaption=NO;
    item.textAlignment=NSTextAlignmentLeft;
    item.isSecureTextEntry=YES;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"记住密码";
    item.controlType=CHECKBOX;
    item.dataKey=@"savePwd";
    item.superViewColor=col_ClearColor();
    item.isShowCaption=NO;
    item.textAlignment=NSTextAlignmentLeft;
    [panel addItem:item];
    
    [table addPanel:panel];
    return table;
}


D_Template* temp_Pbjh()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"20001";
    table.onlyType=20001;
    table.name=@"排班报告";
    //    table.isMustPhoto=YES;
    
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"排班类型";
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"类型选择";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"int1";
    item.isMustInput=YES;
    item.dicId=@"10500";
    item.placeholder=@"类型选择";
    item.isShowCaption=YES;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    panel=[[D_Panel alloc]init];
    panel.name=@"上班时间一";
    panel.type=PANEL_PANEL;
    
    item=[[D_UIItem alloc]init];
    item.caption=@"上班时间";
    item.controlType=TIME;
    item.dataKey=@"str1";
    item.placeholder=@"上班时间";
    item.isShowCaption=YES;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"下班时间";
    item.controlType=TIME;
    item.dataKey=@"str2";
    item.placeholder=@"下班时间";
    item.isShowCaption=YES;
    [panel addItem:item];
    [table addPanel:panel];
    
    panel=[[D_Panel alloc]init];
    panel.name=@"上班时间二";
    panel.type=PANEL_PANEL;
    
    item=[[D_UIItem alloc]init];
    item.caption=@"上班时间";
    item.controlType=TIME;
    item.dataKey=@"str3";
    item.placeholder=@"上班时间";
    item.isShowCaption=YES;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"下班时间";
    item.controlType=TIME;
    item.dataKey=@"str4";
    item.placeholder=@"下班时间";
    item.isShowCaption=YES;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    panel=[[D_Panel alloc]init];
    panel.name=@"上班时间三";
    panel.type=PANEL_PANEL;
    
    item=[[D_UIItem alloc]init];
    item.caption=@"上班时间";
    item.controlType=TIME;
    item.dataKey=@"str5";
    item.placeholder=@"上班时间";
    item.isShowCaption=YES;
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"下班时间";
    item.controlType=TIME;
    item.dataKey=@"str6";
    item.placeholder=@"下班时间";
    item.isShowCaption=YES;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    return table;
}


D_Template* temp_Message()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"-1000";
    table.name=@"消息内容";
    table.onlyType=-1000;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"消息";
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"标题";
    item.controlType=NONE;
    item.dataKey=@"title";
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"发送人";
    item.controlType=NONE;
    item.dataKey=@"sender";
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"时间";
    item.controlType=NONE;
    item.dataKey=@"stime";
    [panel addItem:item];
    [table addPanel:panel];
    
    panel=[[D_Panel alloc]init];
    panel.name=@"内容";
    panel.type=PANEL_PANEL;
    
    item=[[D_UIItem alloc]init];
    item.caption=@"内容";
    item.controlType=NONE;
    item.dataKey=@"content";
    //    item.orientation=VERTICAL;
    item.isShowCaption=NO;
    [panel addItem:item];
    
    [table addPanel:panel];
    
    
    return table;
}

D_Template* temp_CheckIn()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"-1";
    table.name=@"进店照片";
    table.onlyType=-1;
    
    
    NSMutableDictionary*button=[NSMutableDictionary dictionary];
    [button put:@"照片" key:@"name"];
    [button putInt:3 key:@"buttonId"];
    [table addButtonList:button];
    
    return table;
}

D_Template* temp_CheckOut()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"-2";
    table.name=@"出店照片";
    table.onlyType=-2;
    
    NSMutableDictionary*button=[NSMutableDictionary dictionary];
    [button put:@"照片" key:@"name"];
    [button putInt:3 key:@"buttonId"];
    [table addButtonList:button];
    return table;
}

int labelW()
{
    return 35;
}

D_Template* temp_CL(int type)
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"4";
    table.name=@"陈列";
    table.onlyType=type;
    table.isMustPhoto=true;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"陈列";
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"数量";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"int2";
    item.dicId=@"10205";
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"第一陈列位";
    item.controlType=SINGLECHOICE;
    item.dataKey=@"int3";
    item.dicId=@"10200";
    item.lableWidth=labelW();
    [panel addItem:item];
    
    [table addPanel:panel];
    
    if(type<1010)
    {
        panel=[[D_Panel alloc]init];
        panel.name=@"其他";
        panel.type=PANEL_PANEL;
        
        if(type==1001||type==1004)
        {
            item=[[D_UIItem alloc]init];
            item.caption=@"是否亮灯";
            item.controlType=SINGLECHOICE;
            item.dataKey=@"int4";
            item.dicId=@"10200";
            item.lableWidth=labelW();
            [panel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"有/无明星架";
            item.controlType=SINGLECHOICE;
            item.dataKey=@"int5";
            item.dicId=@"10300";
            item.lableWidth=labelW();
            [panel addItem:item];
            
            item=[[D_UIItem alloc]init];
            item.caption=@"是/否当季灯片";
            item.controlType=SINGLECHOICE;
            item.dataKey=@"int6";
            item.dicId=@"10200";
            item.lableWidth=labelW();
            [panel addItem:item];
            
        }
        
        else if(type==1002)
        {
            item=[[D_UIItem alloc]init];
            item.caption=@"整节装饰物";
            item.controlType=MULTICHOICE;
            item.dataKey=@"str2";
            item.dicId=@"10206";
            item.lableWidth=labelW();
            [panel addItem:item];
        }
        else if(type==1007)
        {
            item=[[D_UIItem alloc]init];
            item.caption=@"男士陈列面积";
            item.controlType=SINGLECHOICE;
            item.dataKey=@"int7";
            item.dicId=@"10207";
            item.lableWidth=labelW();
            [panel addItem:item];
        }
        [table addPanel:panel];
    }
    
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"基本信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    button=[NSMutableDictionary dictionary];
    [button put:@"照片" key:@"name"];
    [button putInt:3 key:@"buttonId"];
    [table addButtonList:button];
    return table;
}

D_Template* temp_EditPwd()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"-1001";
    table.name=@"修改密码";
    table.onlyType=-1001;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"修改密码";
    panel.showTitle= NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"旧密码";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.isSecureTextEntry=YES;
    item.dataKey=@"str1";
    item.dicId=@"-100";
    item.maxLenth=6;
    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"新密码";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.dataKey=@"str2";
    item.isSecureTextEntry=YES;
    item.dicId=@"-100";
    item.maxLenth=6;
    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"确认密码";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    item.isSecureTextEntry=YES;
    item.dataKey=@"str3";
    item.dicId=@"-100";
    item.maxLenth=6;
    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    [table addPanel:panel];
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"基本信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    return table;
}



D_Template* temp_Question(NSString* type)
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"-200";
    table.name=@"问题状态修改";
    table.onlyType=-200;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"问题描述";
    //    panel.showTitle= NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"名称";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.isSecureTextEntry=YES;
    item.dataKey=@"QuestionName";
    item.dicId=@"-100";
    item.maxLenth=6;
    //    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"门店";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.dataKey=@"FullName";
    item.isSecureTextEntry=YES;
    item.dicId=@"-100";
    item.maxLenth=6;
    //    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"拜访人";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.isSecureTextEntry=YES;
    item.dataKey=@"empname";
    item.dicId=@"-100";
    item.maxLenth=6;
    //    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"日期";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.isSecureTextEntry=YES;
    item.dataKey=@"ReportDate";
    item.dicId=@"-100";
    item.maxLenth=6;
    //    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"状态";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.isSecureTextEntry=YES;
    item.dataKey=@"DealName";
    item.dicId=@"-100";
    item.maxLenth=6;
    //    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    [table addPanel:panel];
    
    panel=[[D_Panel alloc]init];
    panel.name=@"修改";
    //    panel.showTitle= NO;
    panel.type=PANEL_PANEL;
    
    item=[[D_UIItem alloc]init];
    item.caption=@"选择时间";
    item.controlType=DATE;
    item.verifyType=NUMBER;
    item.isSecureTextEntry=YES;
    item.dataKey=@"str1";
    item.dicId=@"-100";
    item.maxLenth=6;
    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"状态";
    item.controlType=SINGLECHOICE;
    item.verifyType=NUMBER;
    item.dataKey=@"int2";
    item.isSecureTextEntry=YES;
    
    if([type isEqualToString:@"3"])
        item.dicId=@"201";
    else
        item.dicId=@"188";
    item.maxLenth=500;
    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"备注";
    item.controlType=TEXT;
    item.verifyType=DEFAULT;
    //    item.isSecureTextEntry=YES;
    item.dataKey=@"str2";
    item.dicId=@"-100";
    item.maxLenth=500;
    //        item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    [table addPanel:panel];
    
    
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"基本信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    return table;
}



D_Template* temp_Question1()
{
    D_Template* table=[[D_Template alloc]init];
    table.type=@"-200";
    table.name=@"问题查看";
    table.onlyType=-200;
    
    D_Panel* panel=[[D_Panel alloc]init];
    panel.name=@"问题描述";
    //    panel.showTitle= NO;
    panel.type=PANEL_PANEL;
    
    D_UIItem* item=[[D_UIItem alloc]init];
    item.caption=@"名称";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.isSecureTextEntry=YES;
    item.dataKey=@"QuestionName";
    item.dicId=@"-100";
    item.maxLenth=6;
    //    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"门店";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.dataKey=@"FullName";
    item.isSecureTextEntry=YES;
    item.dicId=@"-100";
    item.maxLenth=6;
    //    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"拜访人";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.isSecureTextEntry=YES;
    item.dataKey=@"empname";
    item.dicId=@"-100";
    item.maxLenth=6;
    //    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"日期";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.isSecureTextEntry=YES;
    item.dataKey=@"ReportDate";
    item.dicId=@"-100";
    item.maxLenth=6;
    //    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    item=[[D_UIItem alloc]init];
    item.caption=@"状态";
    item.controlType=NONE;
    item.verifyType=NUMBER;
    item.isSecureTextEntry=YES;
    item.dataKey=@"DealName";
    item.dicId=@"-100";
    item.maxLenth=6;
    //    item.isMustInput=YES;
    item.lableWidth=labelW();
    [panel addItem:item];
    
    [table addPanel:panel];
    
    panel=[[D_Panel alloc]init];
    panel.name=@"流转记录";
    //    panel.showTitle= NO;
    panel.type=PANEL_PANEL;
    
    
    [table addPanel:panel];
    
    
    NSMutableDictionary* button=[NSMutableDictionary dictionary];
    [button put:@"基本信息" key:@"name"];
    [button putInt:1 key:@"buttonId"];
    [table addButtonList:button];
    
    return table;
}
