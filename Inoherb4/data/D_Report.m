//
//  D_Report.m
//  SFA
//
//  Created by Ren Yong on 13-11-27.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "D_Report.h"



//@interface D_Report ()
//{
//
//    D_ArrayList* detailList;
//    D_ArrayList* attList;
//    D_Template* template;
//    NSString* type;
//    NSString* templateId;
//}
//@end
@implementation D_Report
@synthesize isSaved,field,detailList,attList,temp,type,templateId;

//D_Report* mInstance;
//-(D_Report*) newInstance:(D_Template*)temp
//{
//    mInstance = [[D_Report alloc] init:temp];
//    return mInstance;
//}

- (id)init:(D_Template*)t
{
    self = [super init];
    if (self)
    {
        self.type=t.type;
        self.templateId=t.templateId;
        
        self.isSaved=NO;
        self.temp=t;
        [self initField];
    }
    return self;
}

-(void) initField
{
    if (self.field==nil) {
        self.field=[NSMutableDictionary dictionary];
    }
}

-(NSMutableDictionary*) rptField
{
    return field;
}

//-(void) setField:(NSMutableDictionary *)fields
//{
//    self.field=fields;
//}
/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(void) putValue:(NSString*)object key:(NSString*)key
{
    [self initField];
    [field put:object key:key];
}

/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(void) putKey:(NSString*)object key:(NSString*)key
{
    [self initField];
    [field putKey:object key:key];
}

-(NSString*) getString:(NSString*)key
{
    return [field getString:key];
}

-(void) initDetailList
{
    if (detailList==nil) {
        detailList=[[NSMutableArray alloc]init];
    }
}

/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(void) addDetailField:(NSMutableDictionary*)value
{
    [self initDetailList];
    [detailList addDict:value];
}

-(void) resetDetailField:(NSMutableArray*)list
{
    detailList=list;
}


-(void) setDetailField:(NSMutableDictionary*)value
{
    [self initDetailList];
    BOOL bHave=NO;
    for(NSMutableDictionary* data in detailList)
    {
        if([[value getString:@"serverid"] isEqualToString:[data getString:@"serverid"]])
        {
            if([[value getString:@"int1"] isEqualToString:@"2"])
                [ detailList removeObject:data];
            bHave=YES;
            break;
        }
    }
    if(!bHave&&[[value getString:@"int1"] isEqualToString:@"1"])
    [detailList addDict:value];
}
-(NSMutableArray*) detailList
{
    return detailList;
}

-(NSMutableDictionary*) detailFieldAt:(int)index
{
    return [detailList dictAt:index];
}

-(int) detailSize
{
    return detailList==nil?0: [detailList count];
}

-(void) initAttList
{
    if (attList==nil) {
        attList=[[NSMutableArray alloc]init];
    }
}

/**
 <#Description#>存入数据
 @param key <#key description#>
 */
-(void) addAttField:(NSMutableDictionary*)value
{
    [self initAttList];
    [attList addDict:value];
}

-(void) resetAttField:(NSMutableDictionary*)value
{
    attList=[[NSMutableArray alloc]init];
    [attList addDict:value];
}
-(void) resetAttField
{
    attList=[[NSMutableArray alloc]init];
}
-(NSMutableArray*) attList
{
    return attList;
}

-(NSMutableDictionary*) attFieldAt:(int)index
{
    return [attList dictAt:index];;
}



-(int) attSize
{
    return attList==nil?0: [attList count];
}



-(NSString*)checkData
{
    D_Panel* panel;
    D_UIItem* item;
    for (int i=0;i<self.temp.panelCount; i++) {
        panel=[self.temp panel_PanelAt:i];
        for (int j=0; j<panel.itemCount; j++) {
            item=[panel itemAt:j];
            if (item.isMustInput)
            {
                if ([[self getString:item.dataKey] isEqualToString:@""])
                    return [NSString stringWithFormat:@"%@未填写!", item.caption];
            }
        }
    }
    
    
    if (self.temp.isMustPhoto) {
        if ([self attSize]==0) {
            return @"请拍摄照片";
        }
    }
    return @"";
}

@end
