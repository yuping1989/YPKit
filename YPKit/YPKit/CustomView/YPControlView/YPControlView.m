//
//  YPControlView.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/4/16.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "YPControlView.h"
@interface YPControlView ()

@property (nonatomic, strong) YPCompletionBlock clickedHanlder;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@end

@implementation YPControlView
- (void)awakeFromNib {
    self.highlightColor = rgb(220, 220, 220);
    self.normalColor = self.backgroundColor;
}

- (void)setOnClickedHandler:(void (^)(void))clickedHanlder
{
    if (self.tapRecognizer == nil) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        _tapRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:_tapRecognizer];
    }
    self.clickedHanlder = clickedHanlder;
}

- (void)handleSingleTap
{
    if (_clickedHanlder) {
        _clickedHanlder();
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = _highlightColor;
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = _normalColor;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = _normalColor;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = _normalColor;
    }
}
@end
