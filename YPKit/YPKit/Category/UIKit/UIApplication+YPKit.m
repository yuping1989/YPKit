//
//  UIApplication+YPKit.m
//  NBD2
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import "UIApplication+YPKit.h"
#import "UIDevice+YPKit.h"
#import "MBProgressHUD.h"
#import <sys/sysctl.h>

@implementation UIApplication (YPKit)

+ (NSString *)appBundleName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

+ (NSString *)appBundleDisplayName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

+ (NSString *)appBundleID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

+ (NSString *)appVersionName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString *)appShortVersionString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (BOOL)isPirated {
    if ([[UIDevice currentDevice] isSimulator]) return YES; // Simulator is not from appstore
    
    if (getgid() <= 10) return YES; // process ID shouldn't be root
    
    if ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"SignerIdentity"]) {
        return YES;
    }
    
    if (![self fileExistInMainBundle:@"_CodeSignature"]) {
        return YES;
    }
    
    if (![self fileExistInMainBundle:@"SC_Info"]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)fileExistInMainBundle:(NSString *)name {
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *path = [NSString stringWithFormat:@"%@/%@", bundlePath, name];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)isBeingDebugged {
    size_t size = sizeof(struct kinfo_proc);
    struct kinfo_proc info;
    int ret = 0, name[4];
    memset(&info, 0, sizeof(struct kinfo_proc));
    
    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID; name[3] = getpid();
    
    if (ret == (sysctl(name, 4, &info, &size, NULL, 0))) {
        return ret != 0;
    }
    return (info.kp_proc.p_flag & P_TRACED) ? YES : NO;
}

+ (AppDelegate *)appDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (void)hideKeyboard {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

+ (void)call:(NSString *)phone {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]]];
}

+ (void)openURLString:(NSString *)URLString {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
}


+ (void)showToast:(NSString *)text {
    [UIApplication showToast:text hideAfterDelay:1.5f];
}

+ (void)showToastInAppWindow:(NSString *)text {
    [UIApplication showToast:text inView:[UIApplication appDelegate].window hideAfterDelay:1.5f];
}

+ (void)showToast:(NSString *)text hideAfterDelay:(NSTimeInterval)delay {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [UIApplication showToast:text inView:window hideAfterDelay:delay];
}

+ (void)showToast:(NSString *)text
           inView:(UIView *)view
   hideAfterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.center = [UIApplication appDelegate].window.center;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud hide:YES afterDelay:delay];
}

@end
