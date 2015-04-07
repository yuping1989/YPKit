//
//  YPWeixinUtil.m
//  iCarsClub
//
//  Created by 喻平 on 13-10-31.
//  Copyright (c) 2013年 iCarsclub. All rights reserved.
//

#import "YPWeixinUtil.h"
#import "MBProgressHUD.h"
@implementation YPWeixinUtil

+ (void)auth {
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"LoginController";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}
+ (void)sendLinkMsgWithTitle:(NSString *)title
                       image:(UIImage *)image
                 description:(NSString *)description
                       scene:(int)scene
                        link:(NSString *)link;
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:image];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = link;
    
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
}

+ (void)onResp:(BaseResp *)resp
{
    NSString *operate = nil;
    NSString *showStr = nil;
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        operate = @"操作";
    }
    if ([resp isKindOfClass:[PayResp class]]) {
        operate = @"充值";
    }
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        operate = @"登录";
    }
    NSLog(@"onresp->%d error-->%@", resp.errCode, resp.errStr);
    switch (resp.errCode) {
        case 0:
            if ([resp isKindOfClass:[PayResp class]] || [resp isKindOfClass:[SendAuthResp class]]) {
                showStr = nil;
            } else {
                showStr = [NSString stringWithFormat:@"%@成功", operate];
            }
            break;
        case -1:
            showStr = [NSString stringWithFormat:@"%@失败", operate];
            break;
        case -2:
            showStr = [NSString stringWithFormat:@"%@取消", operate];
            break;
        case -3:
            showStr = @"发送失败";
            break;
        case -4:
            showStr = @"授权失败";
            break;
        case -5:
            showStr = @"微信不支持";
            break;
        default:
            break;
    }
    
    if (showStr) {
        [NativeUtil showToast:showStr];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotiWeixinResp object:resp userInfo:nil];
}
@end
