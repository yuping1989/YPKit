//
//  YPFileUtil.h
//  HuoQiuJiZhang
//
//  Created by 喻平 on 13-4-24.
//  Copyright (c) 2013年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPFileUtil : NSObject
/**
 *  文件操作
 */
+ (BOOL)createDirectoryAtPath:(NSString *)path;
+ (BOOL)createFileAtPath:(NSString *)path;
+ (BOOL)createFileAtDirectory:(NSString *)directory fileName:(NSString *)fileName;
+ (BOOL)removeFileAtPath:(NSString *)path;

+ (BOOL)createDirectoryAtDocument:(NSString *)path;

/**
 *  返回文档路径
 */
+ (NSString *)directory:(NSSearchPathDirectory)type;
+ (NSString *)applicationDocumentsDirectory;
+ (NSString *)applicationStorageDirectory;

/**
 *  向指定文件添加字符串，如果文件不存在则创建
 */
+ (BOOL)appendStringToFile:(NSString *)path string:(NSString *)string;

/**
 *  读取文件中的文字
 */
+ (NSString *)readStringFromFile:(NSString *)path;



/**
 *  设置跳过iCloud备份
 */
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

/**
 *  获取文件的MD5
 */
+ (NSString *)MD5WithPath:(NSString *)path;
@end
