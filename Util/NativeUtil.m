//
//  NativeUtil.m
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-3-24.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "NativeUtil.h"
#import "MBProgressHUD.h"
@implementation NativeUtil

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (void)showToast:(NSString *)text
{
    [NativeUtil showToast:text inCenter:YES hideAfterDelay:1.5f];
}

+ (void)showToast:(NSString *)text inCenter:(BOOL)inCenter
{
    [NativeUtil showToast:text inCenter:inCenter hideAfterDelay:1.5f];
}

+ (void)showToast:(NSString *)text inCenter:(BOOL)inCenter hideAfterDelay:(NSTimeInterval)delay
{
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[NativeUtil appDelegate].window animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = text;
	hud.margin = 10.f;
    if (inCenter) {
        hud.center = [NativeUtil appDelegate].window.center;
    } else{
        hud.yOffset = [NativeUtil appDelegate].window.frame.size.height * 0.2f;
    }
	
	hud.removeFromSuperViewOnHide = YES;
	hud.userInteractionEnabled = NO;
	[hud hide:YES afterDelay:delay];
}

+ (void)hideKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

+ (NSString *)appVersionName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSInteger)appVersionCode
{
    return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] integerValue];
}
@end
