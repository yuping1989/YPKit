//
//  YPQQUtil.m
//  iCarsClub
//
//  Created by 喻平 on 13-11-14.
//  Copyright (c) 2013年 iCarsclub. All rights reserved.
//

#import "YPQQUtil.h"

@implementation YPQQUtil



+ (void)onResp:(QQBaseResp *)resp
{
    NSLog(@"on resp--->%@  type-->%d desc-->%@", resp.result, resp.type, resp.extendInfo);
    if ([resp.result isEqual:@"0"]) {
        [NativeUtil showToast:@"操作成功"];
    } else if ([resp.result isEqual:@"-4"]) {
        [NativeUtil showToast:@"操作取消"];
    } else {
        [NativeUtil showToast:@"操作失败"];
    }
}

+ (void)onReq:(QQBaseReq *)req
{
    NSLog(@"onReq");
}

+ (void)isOnlineResponse:(NSDictionary *)response
{
    NSLog(@"isOnlineResponse");
}

+ (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            [NativeUtil showToast:@"App未注册"];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            [NativeUtil showToast:@"发送参数错误"];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            [NativeUtil showToast:@"未安装手机QQ"];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            [NativeUtil showToast:@"API接口不支持"];
            break;
        }
        case EQQAPISENDFAILD:
        {
            [NativeUtil showToast:@"发送失败"];
            break;
        }
        default:
        {
            break;
        }
    }
}


@end
