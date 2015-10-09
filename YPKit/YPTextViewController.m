//
//  YPTextViewController.m
//  YPKit
//
//  Created by 喻平 on 15/8/14.
//  Copyright (c) 2015年 YPKit. All rights reserved.
//

#import "YPTextViewController.h"
#import "YPTextView.h"

@interface YPTextViewController ()<YPTextViewDelegate>
@property (nonatomic, weak) IBOutlet UIView *bgView;
@property (nonatomic, weak) IBOutlet YPTextView *textView;
@end

@implementation YPTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _textView.placeholder = @"请输入";
    [_textView setCornerRadius:5];
    [_textView setBoarderWith:0.5f color:[UIColor grayColor].CGColor];
    _textView.delegate = self;
//    _textView.dataDetectorTypes = UIDataDetectorTypeAll;
//    _textView.textContainerInset = UIEdgeInsetsMake(8, 0, 0, 0);
    NSLog(@"content size-->%@", NSStringFromCGSize(_textView.contentSize));
    NSLog(@"content offset--->%@", NSStringFromCGPoint(_textView.contentOffset));
    NSLog(@"container--->%@", NSStringFromUIEdgeInsets(_textView.textContainerInset));
//    _textView.maxHeight = 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)yp_textView:(YPTextView *)textView didContentHeightChanged:(NSInteger)heightOffset {
    NSLog(@"height--->%f", textView.contentSize.height);
    textView.height += heightOffset;
    _bgView.frame = CGRectMake(0, _bgView.y - heightOffset, _bgView.width, _bgView.height + heightOffset);

}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"url--->%@", URL.absoluteString);
    return NO;
}
@end
