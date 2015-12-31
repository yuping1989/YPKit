//
//  YPFileUtil.h
//  HuoQiuJiZhang
//
//  Created by 喻平 on 13-4-24.
//  Copyright (c) 2013年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPFileUtil : NSObject
+ (BOOL)createDirectoryAtPath:(NSString *)path;
+ (BOOL)createFileAtPath:(NSString *)path;
+ (BOOL)createFileAtDirectory:(NSString *)directory fileName:(NSString *)fileName;
+ (BOOL)createDirectoryAtDocument:(NSString *)path;

+ (NSString *)directory:(NSInteger)type;
+ (NSString *)applicationDocumentsDirectory;
+ (NSString *)applicationStorageDirectory;

+ (BOOL)appendStringToFile:(NSString *)path string:(NSString *)string;
+ (NSString *)readStringFromFile:(NSString *)path;

+ (BOOL)removeFile:(NSURL *)url;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
+ (NSString *)MD5WithPath:(NSString *)path;
@end
