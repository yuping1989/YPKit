//
//  YPControlView.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/4/16.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "YPControlView.h"
@interface YPControlView ()

@property (nonatomic, copy) YPCompletionBlock clickedHandler;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) UIColor *normalBackgroundlColor;
@end

@implementation YPControlView
- (void)awakeFromNib {
    self.highlightBackgroundColor = RGB(220, 220, 220);
    self.normalBackgroundlColor = self.backgroundColor;
}


- (void)setOnClickedHandler:(void (^)(void))clickedHandler
{
//    if (self.tapRecognizer == nil) {
//        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
//        _tapRecognizer.numberOfTapsRequired = 1;
//        [self addGestureRecognizer:_tapRecognizer];
//    }
    self.clickedHandler = clickedHandler;
}

- (void)handleSingleTap
{
    if (self.clickedHandler) {
        self.clickedHandler();
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    if (self.clickedHandler) {
        self.normalBackgroundlColor = self.backgroundColor;
        self.backgroundColor = self.highlightBackgroundColor;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    if (self.clickedHandler) {
        self.backgroundColor = self.normalBackgroundlColor;
        self.clickedHandler();
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHandler) {
        self.backgroundColor = self.normalBackgroundlColor;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
    if (self.clickedHandler) {
        self.backgroundColor = self.normalBackgroundlColor;
    }
}
@end
