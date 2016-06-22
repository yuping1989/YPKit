//
//  YPNativeUtil.m
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-3-24.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "YPNativeUtil.h"
#import "MBProgressHUD.h"
#import <sys/utsname.h>


void YPOpenURLString(NSString *URLString) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
}

void YPHideKeyboard() {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

void YPCallTelephone(NSString *phone) {
    YPOpenURLString([NSString stringWithFormat:@"tel://%@", phone]);
}

@implementation YPNativeUtil

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (void)showToast:(NSString *)text
{
    [YPNativeUtil showToast:text hideAfterDelay:1.5f];
}

+ (void)showToastInAppWindow:(NSString *)text
{
    [YPNativeUtil showToast:text inView:[YPNativeUtil appDelegate].window hideAfterDelay:1.5f];
}

+ (void)showToast:(NSString *)text hideAfterDelay:(NSTimeInterval)delay
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [YPNativeUtil showToast:text inView:window hideAfterDelay:delay];
}

+ (void)showToast:(NSString *)text
           inView:(UIView *)view
   hideAfterDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.center = [YPNativeUtil  appDelegate].window.center;
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

+ (void)call:(NSString *)phone
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]]];
}

+ (CGFloat)onePixel {
    UIScreen* mainScreen = [UIScreen mainScreen];
    if ([mainScreen respondsToSelector:@selector(nativeScale)]) {
        return 1.0f / mainScreen.nativeScale;
    } else {
        return 1.0f / mainScreen.scale;
    }
}

+ (void)openURLString:(NSString *)URLString {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
}



+ (NSString *)deviceName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    NSDictionary *allDevice = @{
                                @"iPhone1,1" : @"iPhone 2G",
                                @"iPhone1,2" : @"iPhone 3G",
                                @"iPhone2,1" : @"iPhone 3GS",
                                @"iPhone3,1" : @"iPhone 4",
                                @"iPhone3,2" : @"iPhone 4",
                                @"iPhone3,3" : @"iPhone 4",
                                @"iPhone4,1" : @"iPhone 4S",
                                @"iPhone5,1" : @"iPhone 5",
                                @"iPhone5,2" : @"iPhone 5",
                                @"iPhone5,3" : @"iPhone 5c",
                                @"iPhone5,4" : @"iPhone 5c",
                                @"iPhone6,1" : @"iPhone 5s",
                                @"iPhone6,2" : @"iPhone 5s",
                                @"iPhone7,1" : @"iPhone 6 Plus",
                                @"iPhone7,2" : @"iPhone 6",
                                @"iPhone8,1" : @"iPhone 6s Plus",
                                @"iPhone8,2" : @"iPhone 6s",
                                
                                @"iPod1,1" : @"iPod Touch 1",
                                @"iPod2,1" : @"iPod Touch 2",
                                @"iPod3,1" : @"iPod Touch 3",
                                @"iPod4,1" : @"iPod Touch 4",
                                @"iPod5,1" : @"iPod Touch 5",
                                
                                @"iPad1,1" : @"iPad 1G",
                                @"iPad2,1" : @"iPad 2",
                                @"iPad2,2" : @"iPad 2",
                                @"iPad2,3" : @"iPad 2",
                                @"iPad2,4" : @"iPad 2",
                                @"iPad2,5" : @"iPad Mini 1",
                                @"iPad2,6" : @"iPad Mini 1",
                                @"iPad2,7" : @"iPad Mini 1",
                                
                                @"iPad3,1" : @"iPad 3",
                                @"iPad3,2" : @"iPad 3",
                                @"iPad3,3" : @"iPad 3",
                                @"iPad3,4" : @"iPad 4",
                                @"iPad3,5" : @"iPad 4",
                                @"iPad3,6" : @"iPad 4",
                                
                                @"iPad4,1" : @"iPad Air",
                                @"iPad4,2" : @"iPad Air",
                                @"iPad4,3" : @"iPad Air",
                                @"iPad4,4" : @"iPad Mini 2",
                                @"iPad4,5" : @"iPad Mini 2",
                                @"iPad4,6" : @"iPad Mini 2",
                                @"iPad4,7" : @"iPad Mini 3",
                                @"iPad4,8" : @"iPad Mini 3",
                                @"iPad4,9" : @"iPad Mini 3",
                                
                                @"iPad5,1" : @"iPad Mini 4",
                                @"iPad5,2" : @"iPad Mini 4",
                                @"iPad5,3" : @"iPad Air 2",
                                @"iPad5,4" : @"iPad Air 2",
                                
                                @"i386" : @"Simulator",
                                @"x86_64" : @"Simulator",
                                };
    NSString *deviceName = allDevice[code];
    if (!deviceName) {
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        } else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        } else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        } else {
            deviceName = @"Unknown";
        }
    }
    return deviceName;
}
@end



