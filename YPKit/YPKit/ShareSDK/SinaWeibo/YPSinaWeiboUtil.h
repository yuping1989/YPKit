//
//  YPSinaWeiboUtil.h
//  iCarsClub
//
//  Created by 喻平 on 13-11-6.
//  Copyright (c) 2013年 iCarsclub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

#define kNotiSinaWeiboResp @"kNotiSinaWeiboResp"
@interface YPSinaWeiboUtil : NSObject
+ (void)authWithAppKey:(NSString *)appKey redirectURI:(NSString *)redirectURI SSOFrom:(NSString *)from;
+ (void)sendTextMsgWithText:(NSString *)text;
+ (void)sendImageMsgWithImage:(NSData *)imageData;
+ (void)sendMediaMsgWithTitle:(NSString *)title
                  description:(NSString *)description
                    imageData:(NSData *)imageData
                         link:(NSString *)link
                     objectID:(NSString *)objectID;
@end
