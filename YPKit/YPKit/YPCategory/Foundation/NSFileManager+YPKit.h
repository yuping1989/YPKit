//
//  NSFileManager+YPKit.h
//  YPKit
//
//  Created by 喻平 on 2017/10/24.
//  Copyright © 2017年 YPKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (YPKit)

/**
 *  返回文档路径
 */
+ (NSString *)directory:(NSSearchPathDirectory)type;
+ (NSString *)applicationDocumentsDirectory;
+ (NSString *)applicationStorageDirectory;

/**
 *  获取文件的MD5
 */
+ (NSString *)md5StringForFileWithPath:(NSString *)path;

/**
 *  设置跳过iCloud备份
 */
+ (BOOL)disableICloudBackupForPath:(NSString *)path;

@end
