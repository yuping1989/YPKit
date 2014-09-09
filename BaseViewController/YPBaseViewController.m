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
    } else {
#ifdef NAV_BACK_IMAGE_NAME
        [self initLeftBarButtonItemWithImage:[UIImage imageNamed:NAV_BACK_IMAGE_NAME] target:self];
#endif
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    if ([self isViewInBackground]) {
//        NSLog(@"%@-->didReceiveMemoryWarning", [[self class] description]);
//        self.view = nil;
//    }
}
- (void)leftBarButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
