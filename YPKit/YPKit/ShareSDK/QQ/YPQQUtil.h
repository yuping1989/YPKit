//
//  YPQQUtil.h
//  iCarsClub
//
//  Created by 喻平 on 13-11-14.
//  Copyright (c) 2013年 iCarsclub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApi.h>
@interface YPQQUtil : NSObject
+ (void)handleSendResult:(QQApiSendResultCode)sendResult;
@end
