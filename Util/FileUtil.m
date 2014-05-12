//
//  FileUtil.m
//  HuoQiuJiZhang
//
//  Created by 喻平 on 13-4-24.
//  Copyright (c) 2013年 com.huoqiu. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil
/**
 创建文件夹
 */
+ (BOOL)createDirectoryAtPath:(NSString *)path
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return YES;
    }
    return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}
/**
 在指定目录创建文件
 */
+ (BOOL)createFileAtDirectory:(NSString *)path fileName:(NSString *)fileName
{
    
    return [FileUtil createFileAtPath:[path stringByAppendingFormat:@"/%@", fileName]];
}
/**
 创建文件
 */
+ (BOOL)createFileAtPath:(NSString *)path
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return YES;
    }
    return [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
}
/**
 在文档目录创建文件夹
 */
+ (BOOL)createDirectoryAtDocument:(NSString *)path
{
    return [self createDirectoryAtPath:[[FileUtil applicationDocumentsDirectory] stringByAppendingString:path]];
}
/**
 返回文档路径
 */

+ (NSString *)directory:(int) type
{
    return [NSSearchPathForDirectoriesInDomains(type, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)applicationDocumentsDirectory
{
	return [self directory:NSDocumentDirectory];
}

+ (NSString *)applicationStorageDirectory
{
    NSString *applicationName = [[[NSBundle mainBundle] infoDictionary] valueForKey:(NSString *)kCFBundleNameKey];
    return [[self directory:NSApplicationSupportDirectory] stringByAppendingPathComponent:applicationName];
}

/**
 向指定文件添加字符串，如果文件不存在则创建
 */
+ (BOOL)appendStringToFile:(NSString *)path string:(NSString *)string
{
    if ([NSString isEmpty:string]) {
        return YES;
    }
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (!exists) {
        if (![FileUtil createFileAtPath:path]) {
            return NO;
        }
    }
    // 写入文件
    NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:path];
    [file seekToEndOfFile];
    [file writeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
    return YES;
}

+ (NSString *)readStringFromFile:(NSString *)path
{
    if (!path || ![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return nil;
    }
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

+ (BOOL)removeFile:(NSURL *)url
{
    return [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
}
@end
