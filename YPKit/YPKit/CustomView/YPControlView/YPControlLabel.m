//
//  YPControlLabel.m
//  NBD2
//
//  Created by 喻平 on 15/12/1.
//  Copyright © 2015年 NBD2. All rights reserved.
//

#import "YPControlLabel.h"
@interface YPControlLabel ()
@property (nonatomic, strong) UIColor *normalBackgroundlColor;
@property (nonatomic, strong) YPCompletionBlock clickedHanlder;
@end
@implementation YPControlLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib {
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = YES;
}
- (void)setOnClickedHandler:(void (^)(void))clickedHanlder {
    self.clickedHanlder = clickedHanlder;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.highlightBackgroundColor) {
        self.normalBackgroundlColor = self.backgroundColor;
        self.backgroundColor = self.highlightBackgroundColor;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    if (self.clickedHanlder) {
        self.clickedHanlder();
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(controlLabeldidClicked:)]) {
        [self.delegate controlLabeldidClicked:self];
    }
    self.backgroundColor = self.normalBackgroundlColor;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
    self.backgroundColor = self.normalBackgroundlColor;
}

@end
