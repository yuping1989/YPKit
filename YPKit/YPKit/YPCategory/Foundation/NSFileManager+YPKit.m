//
//  NSFileManager+YPKit.m
//  YPKit
//
//  Created by 喻平 on 2017/10/24.
//  Copyright © 2017年 YPKit. All rights reserved.
//

#import "NSFileManager+YPKit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSFileManager (YPKit)

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

+ (NSString *)md5StringForFileWithPath:(NSString *)path {
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

+ (BOOL)disableICloudBackupForPath:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    BOOL success = [url setResourceValue:@YES
                                  forKey:NSURLIsExcludedFromBackupKey
                                   error:&error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [url lastPathComponent], error);
    }
    return success;
}

@end
