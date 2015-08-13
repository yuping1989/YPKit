//
//  YPWeixinUtil.h
//  iCarsClub
//
//  Created by 喻平 on 13-10-31.
//  Copyright (c) 2013年 iCarsclub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#define kNotiWeixinResp @"kNotiWeixinResp"
@interface YPWeixinUtil : NSObject
+ (void)auth;
+ (void)sendLinkMsgWithTitle:(NSString *)title
                       image:(UIImage *)image
                 description:(NSString *)description
                       scene:(int)scene
                        link:(NSString *)link;

@end
