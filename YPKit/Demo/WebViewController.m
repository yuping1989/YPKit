//
//  WebViewController.m
//  YPKit
//
//  Created by yuping on 15/11/29.
//  Copyright © 2015年 YPKit. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
    NSString *content = [YPFileUtil readStringFromFile:path];
    NSLog(@"content--->%@", content);
    [self.webView loadHTMLString:content baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
