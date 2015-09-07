//
//  SyncWeb.m
//  SFA
//
//  Created by Ren Yong on 13-11-12.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "SyncWeb.h"
#import "F_Request.h"
#import <objc/runtime.h>
#import "AFXMLRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "D_SyncResult.h"

@interface SyncWeb()
{
    NSObject<delegateRequest>* mDelegate;
    NSString * mElementName;
    //    NSString* oldElementName;
    RequestType mType;
    D_SyncResult* mResult;
    NSMutableDictionary* mField;
    BOOL inRecord;
}
@end

@implementation SyncWeb
static SyncWeb* mInstance;

+(SyncWeb*) instance
{
    @synchronized(self)
    {
        if (mInstance == nil)
        {
            mInstance = [[SyncWeb alloc] init];
        }
    }
    return mInstance;
}

- (void)syncWeb:(RequestType)type report:(D_Report*)report delegate:(NSObject<delegateRequest>*) delegate
{
    [self syncToWeb:type requestString:soapUpload(type,report) delegate:delegate];
}

-(void)syncToWeb:(RequestType)type requestString:(NSString*)requestString delegate:(NSObject<delegateRequest>*) delegate
{
    @synchronized(self)
    {
        NSURL *url = [self requestUrl:type];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];//调用webservice必须添加
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[requestString dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"请求:%@",requestString);
        
        AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                                                                   XMLParser.delegate = self;
                                                                                                   [XMLParser parse];
                                                                                               }
                                                                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                                                                                   
                                                                                                   [self delegate_requestfail:error];
                                                                                               }
                                            ];
        mType=type;
        mDelegate=delegate;
        [operation start];
        [operation waitUntilFinished];
    }
}

- (void)syncWeb:(RequestType)type field:(NSMutableDictionary*)field delegate:(NSObject<delegateRequest>*) delegate
{
    [self syncToWeb:type requestString:soapRequest(type,field) delegate:delegate];
}

-(void) delegate_requestfail:(NSError*) error
{
    if (mDelegate && [mDelegate respondsToSelector:@selector(delegate_requestDidFail:)])
    {
        NSString* err=@"";
        if(error)
            err=[error localizedDescription];
        [mDelegate delegate_requestDidFail:err];
    }
}

- (NSURL *)requestUrl:(RequestType)type
{
    return [NSURL URLWithString:BASEURL];
}

-(BOOL)isRecord:(NSString*)elementName
{
    if([elementName isEqualToString:MSGTYPELIST]||[elementName isEqualToString:CLIENTTABLE]||[elementName isEqualToString:TABLE]||[elementName isEqualToString:@"MsgTypeItem"]||[elementName isEqualToString:@"ReportInfo"])
        return YES;
    return NO;
}

#pragma mark -
#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    mElementName = elementName;
    //处理id转化为serverid
    if ([elementName isEqualToString:@"id"])
    {
        mElementName = @"serverid";
    }
    
    if([self isRecord:mElementName])
    {
        inRecord=YES;
        mField=[NSMutableDictionary dictionary];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(mResult==nil)
        mResult=[[D_SyncResult alloc]init];
    
    NSLog(@"key:%@------value:%@",mElementName,string);
    if(inRecord)
    {
        //        if([oldElementName isEqualToString:mElementName])
        [mField put:[NSString stringWithFormat:@"%@%@",[mField getString:mElementName],string] key:mElementName];
        //        [mField put:string key:mElementName];
    }
    else
    {
        [mResult put:[NSString stringWithFormat:@"%@%@",[mResult getString:mElementName],string] key:mElementName];
        //        [mResult put:string key:mElementName];
    }
    
    //    oldElementName=mElementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([self isRecord:elementName])
    {
        inRecord=NO;
        [mResult addField:mField];
    }
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if (mDelegate && [mDelegate respondsToSelector:@selector(delegate_requestDidFail:)])
    {
        [mDelegate delegate_requestDidFail:@"XML解析失败"];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (mDelegate && [mDelegate respondsToSelector:@selector(delegate_requestDidSuccess:)])
    {
        [mDelegate delegate_requestDidSuccess:mResult];
    }
    [self gc];
}

-(void)gc
{
    mElementName=nil;
    mResult=nil;
    mField=nil;
    inRecord=NO;
    //    inRecord=nil;
}

@end
