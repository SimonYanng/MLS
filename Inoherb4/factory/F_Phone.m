//
//  F_Phone.m
//  SFA
//
//  Created by Ren Yong on 13-11-13.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "F_Phone.h"

#import <SystemConfiguration/SystemConfiguration.h>  // 需要事先导入SystemConfiguration.framework
#import <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#import <sys/sysctl.h>
#import <mach/mach.h>

int screenWeight=320;
int screenHeight=640;

BOOL isPhone()
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        // The device is an iPad running iOS 3.2 or later.
        return YES;
    }
    else
    {
        // The device is an iPhone or iPod touch.
        return NO;
    }
}

void setScreenH(int h)
{
    screenHeight=h;
}

int screenH()
{
    return screenHeight;
}


void setScreenW(int w)
{
    screenWeight=w;
}

int screenW()
{
    return screenWeight;
}

double availableMemory()
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

/**
 [""]	<#Description#>是否联网
 [""]	@param  <# description#>
 [""]	@returns <#return value description#>
 [""] */
BOOL isConnecting()
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

UIApplication* application()
{
    return  [UIApplication sharedApplication];
}

CGRect statusBarFrame()
{
    return [application() statusBarFrame];
}

int statusBarHeight()
{
    CGRect cGRect=statusBarFrame();
    return cGRect.size.height;
}

//- (NSString *) imei
//{
//    NSArray *results = getValue(@"device-imei");
//    if (results)
//    {
//        //return [results objectAtIndex:0];
//        NSString *string_content = [results objectAtIndex:0];
//        const char *char_content = [string_content UTF8String];
//        return  [[NSString alloc] initWithCString:(constchar*)char_content  encoding:NSUTF8StringEncoding];
//
//    }
//    //if(results)
//    //{
//    //    return [(NSString *)[results objectAtIndex:0] substringToIndex:2];
//    // }
//    return @"";
//}
//
//NSArray *getValue(NSString *iosearch)
//{
//    mach_port_t          masterPort;
//    CFTypeID             propID = (CFTypeID) NULL;
//    unsigned int         bufSize;
//
//    kern_return_t kr = IOMasterPort(MACH_PORT_NULL, &masterPort);
//    if (kr != noErr) return nil;
//
//    io_registry_entry_t entry = IORegistryGetRootEntry(masterPort);
//    if (entry == MACH_PORT_NULL) return nil;
//
//    CFTypeRef prop = IORegistryEntrySearchCFProperty(entry,kIODeviceTreePlane, (CFStringRef) iosearch, nil,kIORegistryIterateRecursively);
//    if (!prop) return nil;
//
//    propID = CFGetTypeID(prop);
//    if (!(propID == CFDataGetTypeID()))
//    {
//        mach_port_deallocate(mach_task_self(), masterPort);
//        return nil;
//    }
//
//    CFDataRef propData = (CFDataRef) prop;
//    if (!propData) return nil;
//
//    bufSize = CFDataGetLength(propData);
//    if (!bufSize) return nil;
//
//    //NSString *p1 = [[[NSString alloc] initWithBytes:CFDataGetBytePtr(propData) length:bufSize encoding:1] autorelease];
//    NSString *p1 = [[[NSString alloc]initWithBytes:CFDataGetBytePtr(propData) length:bufSizeencoding:NSUTF8StringEncoding] autorelease];
//    mach_port_deallocate(mach_task_self(), masterPort);
//    return [p1 componentsSeparatedByString:@"/0"];
//}

void callNumber(NSString*number, UIView* view)
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",number];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [view addSubview:callWebview];
}



