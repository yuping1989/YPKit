//
//  AppDelegate.m
//  YPKit
//
//  Created by 喻平 on 15/8/13.
//  Copyright (c) 2015年 YPKit. All rights reserved.
//

#import "AppDelegate.h"
#import "RootController.h"
#import "YPTestTextView.h"
#import "YPSettingItem.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[RootController alloc] init]];
    
    [[YPTestTextView appearance] setPlaceholderColor:[UIColor redColor]];
    
    [[YPSettingItem appearance] setPaddingLeft:15];
    [[YPSettingItem appearance] setPaddingRight:10];
    [[YPSettingItem appearance] setTitleColor:[UIColor darkGrayColor]];
    [[YPSettingItem appearance] setTextColor:RGB(175, 168, 159)];
    [[YPSettingItem appearance] setTitleFont:[UIFont systemFontOfSize:20]];
    [[YPSettingItem appearance] setTextFont:[UIFont systemFontOfSize:17]];
    [[YPSettingItem appearance] setArrowImage:[UIImage imageNamed:@"icon_arrow_light"]];
    [[YPSettingItem appearance] setLeftImageWidth:30];
    [[YPSettingItem appearance] setLineColor:[UIColor lightGrayColor]];
    
    [self.window makeKeyAndVisible];
    
    [[YPHttpUtil shared] GET:@"http://api.nbd.com.cn/2/columns/375/articles.json?count=15&app_key=f4af4864997a00ddff7e1765e643f9ec&client_key=iPhone"
                      params:nil
                  controller:nil
                     success:^(id successData, NSURLSessionDataTask *task) {
                         
                     }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
