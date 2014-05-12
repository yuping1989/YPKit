//
//  YPBaseViewController.h
//  CanXinTong
//
//  Created by 喻平 on 13-1-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface YPBaseViewController : UIViewController <MBProgressHUDDelegate>
{
    MBProgressHUD *_progressHUD;
}

- (BOOL)isViewInBackground;

- (void)showProgressWithText:(NSString *)text;
- (void)showProgressOnWindowWithText:(NSString *)text;
- (void)showProgressOnView:(UIView *)view text:(NSString *)text userInteractionEnabled:(BOOL)enabled;
- (void)hideProgress;
@end
