//
//  YPSinaWeiboUtil.m
//  iCarsClub
//
//  Created by 喻平 on 13-11-6.
//  Copyright (c) 2013年 iCarsclub. All rights reserved.
//

#import "YPSinaWeiboUtil.h"

@implementation YPSinaWeiboUtil
+ (void)authWithAppKey:(NSString *)appKey redirectURI:(NSString *)redirectURI SSOFrom:(NSString *)from {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:appKey];
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = redirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": from};
    [WeiboSDK sendRequest:request];
}
+ (void)sendTextMsgWithText:(NSString *)text
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = text;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
}

+ (void)sendImageMsgWithImage:(NSData *)imageData
{
    WBImageObject *object = [WBImageObject object];
    object.imageData = imageData;
    
    WBMessageObject *message = [WBMessageObject message];
    message.imageObject = object;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
}


+ (void)sendMediaMsgWithTitle:(NSString *)title
                  description:(NSString *)description
                    imageData:(NSData *)imageData
                         link:(NSString *)link
                     objectID:(NSString *)objectID
{
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = objectID;
    webpage.title = title;
    webpage.description = description;
    webpage.thumbnailData = imageData;
    webpage.webpageUrl = link;
    WBMessageObject *message = [WBMessageObject message];
    message.text = [NSString stringWithFormat:@"%@\n%@", title, description];
    message.mediaObject = webpage;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
}

+ (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

+ (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        switch (response.statusCode) {
            case WeiboSDKResponseStatusCodeSuccess:
                [NativeUtil showToast:@"操作成功"];
                break;
            case WeiboSDKResponseStatusCodeUserCancel:
                [NativeUtil showToast:@"操作取消"];
                break;
            case WeiboSDKResponseStatusCodeSentFail:
                [NativeUtil showToast:@"操作失败"];
                break;
            case WeiboSDKResponseStatusCodeAuthDeny:
                [NativeUtil showToast:@"授权失败"];
                break;
            case WeiboSDKResponseStatusCodeUserCancelInstall:
                [NativeUtil showToast:@"用户取消安装微博客户端"];
                break;
            case WeiboSDKResponseStatusCodeUnsupport:
                [NativeUtil showToast:@"不支持的请求"];
                break;
            case WeiboSDKResponseStatusCodeUnknown:
                [NativeUtil showToast:@"未知错误"];
                break;
            default:
                break;
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotiSinaWeiboResp object:response];
    
    NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
    NSLog(@"response-->%@", message);
    if ([response isKindOfClass:[WBAuthorizeResponse class]]) {

    }
}
@end
