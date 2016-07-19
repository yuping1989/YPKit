//
//  YPBaseViewController.m
//  CanXinTong
//
//  Created by 喻平 on 13-1-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import "YPBaseViewController.h"

@interface YPBaseViewController () {
    
}
@end

@implementation YPBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7_AND_LATER) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
#ifdef UDIsNightModel
    [self nightModelSwitched:nil];
#endif
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
