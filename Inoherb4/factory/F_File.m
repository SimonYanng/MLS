//
//  F_File.m
//  SFA
//
//  Created by Ren Yong on 13-11-13.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "F_File.h"
#import "Constants.h"

/**
 [""]	<#Description#>文件夹是否存在
 [""]	@param path"] <#path"] description#>
 [""] */
BOOL isFileExist(NSString* path)
{
    BOOL isDirectory=[[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    return isDirectory;
}


/**
[""]	<#Description#>创建文件夹
[""]	@param path"] <#path"] description#>
[""] */
void creatPath(NSString* path)
{
    if (!isFileExist(path))
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

/**
[""]	<#Description#>数据库文件
[""]	@param  <# description#>
[""]	@returns <#return value description#>
[""] */
NSString * dbPath()
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathname = [path objectAtIndex:0];
    NSString* dbName=[FILENAME stringByAppendingFormat:@"/%@",DBNAME];
	return [pathname stringByAppendingPathComponent:dbName];
}

/**
[""]	<#Description#>文件保存的文件夹
[""]	@param  <# description#>
[""]	@returns <#return value description#>
[""] */
NSString* filePath()

{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathname = [path objectAtIndex:0];
	return [pathname stringByAppendingPathComponent:FILENAME];
}

//NSString *absolutePathWithTableName(NSString *tableName)
//{
    //    NSString *path = [NSString stringWithFormat:@"%@/%@.plist", [self savePath], tableName];
//    NSString *path = [NSString stringWithFormat:@"%@/%@", filePath(), tableName];
//    return path;
//}