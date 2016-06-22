//
//  YPFileUtil.m
//  HuoQiuJiZhang
//
//  Created by 喻平 on 13-4-24.
//  Copyright (c) 2013年 com.huoqiu. All rights reserved.
//

#import "YPFileUtil.h"
#import "CommonCrypto/CommonDigest.h"

@implementation YPFileUtil

/**
 创建文件夹
 */
+ (BOOL)createDirectoryAtPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return YES;
    }
    return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

/**
 在指定目录创建文件
 */
+ (BOOL)createFileAtDirectory:(NSString *)path fileName:(NSString *)fileName {
    
    return [YPFileUtil createFileAtPath:[path stringByAppendingFormat:@"/%@", fileName]];
}

/**
 * 创建文件
 */
+ (BOOL)createFileAtPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return YES;
    }
    return [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
}

+ (BOOL)removeFileAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}
/**
 * 在文档目录创建文件夹
 */
+ (BOOL)createDirectoryAtDocument:(NSString *)path {
    return [self createDirectoryAtPath:[[YPFileUtil applicationDocumentsDirectory] stringByAppendingString:path]];
}

+ (NSString *)directory:(NSSearchPathDirectory)type {
    return [NSSearchPathForDirectoriesInDomains(type, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)applicationDocumentsDirectory {
	return [self directory:NSDocumentDirectory];
}

+ (NSString *)applicationStorageDirectory {
    NSString *applicationName = [[[NSBundle mainBundle] infoDictionary] valueForKey:(NSString *)kCFBundleNameKey];
    return [[self directory:NSApplicationSupportDirectory] stringByAppendingPathComponent:applicationName];
}


+ (BOOL)appendStringToFile:(NSString *)path string:(NSString *)string {
    if ([NSString isEmpty:string]) {
        return YES;
    }
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (!exists) {
        if (![YPFileUtil createFileAtPath:path]) {
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

+ (NSString *)readStringFromFile:(NSString *)path {
    if (!path || ![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return nil;
    }
    
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}



+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    assert([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES]
                                  forKey:NSURLIsExcludedFromBackupKey error:&error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+ (NSString *)MD5WithPath:(NSString *)path {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if(handle == nil) {
        return nil;
    }
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done) {
        NSData *fileData = [handle readDataOfLength: 256 ];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString *str = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return str;
}
@end
