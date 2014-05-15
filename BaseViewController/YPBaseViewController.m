//
//  YPBaseViewController.m
//  CanXinTong
//
//  Created by 喻平 on 13-1-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import "YPBaseViewController.h"
#import "AppDelegate.h"
@interface YPBaseViewController ()
{
    
}
@end

@implementation YPBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7_AND_LATER) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewInBackground]) {
        NSLog(@"%@-->didReceiveMemoryWarning", [[self class] description]);
        self.view = nil;
    }
}

- (BOOL)isViewInBackground
{
    return [self isViewLoaded] && self.view.window == nil;
}
- (void)showProgressWithText:(NSString *)text
{
    [self showProgressOnView:self.view text:text userInteractionEnabled:YES];
}

- (void)showProgressOnWindowWithText:(NSString *)text
{
    [self showProgressOnView:self.view.window text:text userInteractionEnabled:YES];
}

- (void)showProgressOnView:(UIView *)view text:(NSString *)text userInteractionEnabled:(BOOL)enabled
{
    if (_progressHUD == nil) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:_progressHUD];
        _progressHUD.delegate = self;
        [_progressHUD show:YES];
    }
    _progressHUD.labelText = text;
    NSLog(@"show");
    _progressHUD.userInteractionEnabled = enabled;
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (_progressHUD == nil) {
        return;
    }
    [_progressHUD removeFromSuperview];
    _progressHUD = nil;
    NSLog(@"hide");
}

- (void)hideProgress
{
    if (_progressHUD == nil) {
        return;
    }
    [_progressHUD hide:YES];
}
@end
