//
//  Request.m
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "Request.h"
#import "XMLWriter.h"
#import "F_UserData.h"
@implementation Request

NSString *envNameSpaceURI = @"http://schemas.xmlsoap.org/soap/envelope/";
NSString *sfaNameSpaceURI = @"http://tempuri.org/";
//    NSString *sfaNameSpaceURI = @"http://soap.sfa.parrow.com/";
NSString *envLocalName = @"Envelope";
NSString *BODY = @"Body";

- (NSString *)uploadMsgSoapString:(D_Report *)report
{
    XMLWriter* xmlWriter = [[XMLWriter alloc]init];
    
    [xmlWriter setPrefix:@"n0" namespaceURI:envNameSpaceURI];
    [xmlWriter writeStartElementWithNamespace:envNameSpaceURI localName:envLocalName];
    [xmlWriter writeStartElementWithNamespace:envNameSpaceURI localName:BODY];
    
    [xmlWriter writeCloseStartElement];
    [xmlWriter setPrefix:@"n1" namespaceURI:sfaNameSpaceURI];
    [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"SubMsgStatus"];
    
    [self appendValue:user_Id() forKey:@"empId" xmlWritter:xmlWriter];
    
    [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"msgInfos"];
    
    [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"MessageInfo"];
    
    
    for (NSMutableDictionary* msg in report.detailList) {
        [self appendValue:[msg getString:@"serverid"] forKey:@"MsgId" xmlWritter:xmlWriter];
    }
    
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    
    return [xmlWriter toString];
}

- (NSString *)uploadSoapString:(RequestType)type report:(D_Report *)report
{
    XMLWriter* xmlWriter = [[XMLWriter alloc]init];
    
    [xmlWriter setPrefix:@"n0" namespaceURI:envNameSpaceURI];
    [xmlWriter writeStartElementWithNamespace:envNameSpaceURI localName:envLocalName];
    [xmlWriter writeStartElementWithNamespace:envNameSpaceURI localName:BODY];
    
    [xmlWriter writeCloseStartElement];
    [xmlWriter setPrefix:@"n1" namespaceURI:sfaNameSpaceURI];
    [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"SubReportList"];
    
    [self appendValue:user_Id() forKey:@"empId" xmlWritter:xmlWriter];
    
    [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"reportData"];
    NSLog(@"asdasda-------------%@",[report getString:@"TemplateId"]);
    if([[report getString:@"TemplateId"] isEqualToString:@"-100"])
    {
        
        NSMutableDictionary* detailField;
        for (int i=0; i<[report detailSize]; i++) {
            [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"Report_mainInfo"];
            detailField=[report detailFieldAt:i];
            
            [self appendValue:[detailField getKeyString:@"ReportDate"] forKey:@"ReportDate" xmlWritter:xmlWriter];
            [self appendValue:[report getString:@"TemplateId"] forKey:@"TemplateId" xmlWritter:xmlWriter];
            [self appendValue:[detailField getKeyString:@"ClientId"] forKey:@"ClientId" xmlWritter:xmlWriter];
            
            NSLog(@"%@",[report getString:@"clienttype"]);
            if([[detailField getKeyString:@"ClientType"] isEqualToString:@""])
                [self appendValue:@"1" forKey:@"ClientType" xmlWritter:xmlWriter];
            else
                [self appendValue:[detailField getKeyString:@"ClientType"] forKey:@"ClientType" xmlWritter:xmlWriter];
            
            [self appendValue:@"2" forKey:@"InputType" xmlWritter:xmlWriter];
            //            if(![[detailField getString:@"ClientCode"] isEqualToString:@""])
            [self appendValue:[detailField getKeyString:@"ClientCode"] forKey:@"ClientCode" xmlWritter:xmlWriter];
            
            [self appendValue:user_Id() forKey:@"EmpId" xmlWritter:xmlWriter];
            [self appendValue:[detailField getKeyString:@"INT10"] forKey:@"INT10" xmlWritter:xmlWriter];
            
            [xmlWriter writeEndElement];
        }
        
        
    }
    else
    {
        
        [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"Report_mainInfo"];
        
        [self appendValue:[report getString:@"ReportDate"] forKey:@"ReportDate" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"TemplateId"] forKey:@"TemplateId" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"ClientId"] forKey:@"ClientId" xmlWritter:xmlWriter];
        
        NSLog(@"%@",[report getString:@"clienttype"]);
        if([[report getString:@"clienttype"] isEqualToString:@""])
            [self appendValue:@"1" forKey:@"ClientType" xmlWritter:xmlWriter];
        else
            [self appendValue:[report getString:@"clienttype"] forKey:@"ClientType" xmlWritter:xmlWriter];
        
        [self appendValue:@"2" forKey:@"InputType" xmlWritter:xmlWriter];
        if(![[report getString:@"ClientCode"] isEqualToString:@""])
            [self appendValue:[report getString:@"ClientCode"] forKey:@"ClientCode" xmlWritter:xmlWriter];
        
        [self appendValue:user_Id() forKey:@"EmpId" xmlWritter:xmlWriter];
        
        
        [self appendValue:[report getString:@"INT1"] forKey:@"INT1" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"INT2"] forKey:@"INT2" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"INT3"] forKey:@"INT3" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"INT4"] forKey:@"INT4" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"INT5"] forKey:@"INT5" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"INT6"] forKey:@"INT6" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"INT7"] forKey:@"INT7" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"INT8"] forKey:@"INT8" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"INT9"] forKey:@"INT9" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"INT10"] forKey:@"INT10" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"STR1"] forKey:@"STR1" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"STR2"] forKey:@"STR2" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"STR3"] forKey:@"STR3" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"STR4"] forKey:@"STR4" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"STR5"] forKey:@"STR5" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"STR6"] forKey:@"STR6" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"STR7"] forKey:@"STR7" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"STR8"] forKey:@"STR8" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"STR9"] forKey:@"STR9" xmlWritter:xmlWriter];
        [self appendValue:[report getString:@"STR10"] forKey:@"STR10" xmlWritter:xmlWriter];
        
        
        if([report detailSize]>0)
        {
            [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"ReportDetailList"];
            
            NSMutableDictionary* detailField;
            for (int i=0; i<[report detailSize]; i++) {
                [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"Report_detailInfo"];
                detailField=[report detailFieldAt:i];
                [self appendValue:[detailField getString:@"ProductId"] forKey:@"ProductId" xmlWritter:xmlWriter];
                
                [self appendValue:[detailField getString:@"INT1"] forKey:@"INT1" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"INT2"] forKey:@"INT2" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"INT3"] forKey:@"INT3" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"INT4"] forKey:@"INT4" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"INT5"] forKey:@"INT5" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"INT6"] forKey:@"INT6" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"INT7"] forKey:@"INT7" xmlWritter:xmlWriter];
                
                [self appendValue:[detailField getString:@"STR1"] forKey:@"STR1" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"STR2"] forKey:@"STR2" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"STR3"] forKey:@"STR3" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"STR4"] forKey:@"STR4" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"STR5"] forKey:@"STR5" xmlWritter:xmlWriter];
                [self appendValue:[detailField getString:@"STR6"] forKey:@"STR6" xmlWritter:xmlWriter];
                
                [xmlWriter writeEndElement];
            }
            
            [xmlWriter writeEndElement];
        }
        
        if([report attSize]>0)
        {
            [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"PhotoList"];
            
            NSMutableDictionary* attField;
            for (int i=0; i<[report attSize]; i++) {
                [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:@"PhotoInfo"];
                attField=[report attFieldAt:i];
                [self appendValue:[attField getString:@"photo"] forKey:@"Photo" xmlWritter:xmlWriter];
                [self appendValue:[attField getString:@"shottime"] forKey:@"ShotTime" xmlWritter:xmlWriter];
                
                  [self appendValue:[attField getString:@"PhotoType"] forKey:@"PhotoType" xmlWritter:xmlWriter];
                  [self appendValue:[attField getString:@"ProductId"] forKey:@"ProductId" xmlWritter:xmlWriter];
                [self appendValue:[attField getString:@"Remark"] forKey:@"Remark" xmlWritter:xmlWriter];
                
                [xmlWriter writeEndElement];
            }
            [xmlWriter writeEndElement];
        }
        [xmlWriter writeEndElement];
        
    }
    [xmlWriter writeEndElement];
    
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    return [xmlWriter toString];
}

- (NSString *)requestSoapString:(RequestType)type field:(NSMutableDictionary *)field
{
    
    XMLWriter* xmlWriter = [[XMLWriter alloc]init];
    
    [xmlWriter setPrefix:@"n0" namespaceURI:envNameSpaceURI];
    [xmlWriter writeStartElementWithNamespace:envNameSpaceURI localName:envLocalName];
    [xmlWriter writeStartElementWithNamespace:envNameSpaceURI localName:BODY];
    
    [xmlWriter writeCloseStartElement];
    [xmlWriter setPrefix:@"n1" namespaceURI:sfaNameSpaceURI];
    [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:[field getString:METHOD]];
    
    NSString* value;
    for(NSString *key in field) {
        if(![key isEqualToString:METHOD])
        {
            value = [field getKeyString:key];
            [self appendValue1:value forKey:key xmlWritter:xmlWriter];
        }
    }
    
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    
    return [xmlWriter toString];
}

- (void)appendValue1:(NSString*)value forKey:(NSString *)key xmlWritter:(XMLWriter *)xmlWriter
{
//    if(![value isEqualToString:@""])
//    {
        [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:key];
        [xmlWriter writeCharacters:value];
        [xmlWriter writeEndElement];
//    }
}

- (void)appendValue:(NSString*)value forKey:(NSString *)key xmlWritter:(XMLWriter *)xmlWriter
{
    if(![value isEqualToString:@""])
    {
        [xmlWriter writeStartElementWithNamespace:sfaNameSpaceURI localName:key];
        [xmlWriter writeCharacters:value];
        [xmlWriter writeEndElement];
    }
}

@end
