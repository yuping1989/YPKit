//
//  YPTagCloudView.m
//  NBD2
//
//  Created by 喻平 on 16/4/18.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import "YPTagCloudView.h"

@interface YPTagCloudView ()

@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, assign) NSInteger labelTextVerticalPadding;
@property (nonatomic, assign) NSInteger labelTextHorizontalPadding;
@property (nonatomic, assign) CGFloat labelBorderWidth;
@property (nonatomic, strong) UIColor *labelBorderColor;
@property (nonatomic, assign) CGFloat labelCornerRadius;

@end

@implementation YPTagCloudView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labels = [NSMutableArray array];
    self.userInteractionEnabled = YES;
    self.minFontSize = 14;
    self.maxFontSize = 60;
    self.colors = @[
                    [UIColor blackColor],
                    [UIColor cyanColor],
                    [UIColor purpleColor],
                    [UIColor orangeColor],
                    [UIColor redColor],
                    [UIColor yellowColor],
                    [UIColor lightGrayColor],
                    [UIColor grayColor],
                    [UIColor greenColor]
                    ];
}

- (void)setLabelHorizontalPadding:(NSInteger)horizontalPadding verticalPadding:(NSInteger)verticalPadding {
    self.labelTextHorizontalPadding = horizontalPadding;
    self.labelTextVerticalPadding = verticalPadding;
}

- (void)setLabelBoarderWith:(CGFloat)width boarderColor:(UIColor *)color cornerRadius:(CGFloat)radius {
    self.labelBorderWidth = width;
    self.labelBorderColor = color;
    self.labelCornerRadius = radius;
}

- (UIColor *)randomColor {
    if (self.colors.count == 0) {
        return [UIColor blackColor];
    } else if (self.colors.count == 1) {
        return [self.colors firstObject];
    } else {
        return self.colors[rand() % self.colors.count];
    }
}

- (UIFont *)font {
    if (self.fontSize > 0) {
        return [UIFont systemFontOfSize:self.fontSize];
    } else {
        return [UIFont systemFontOfSize:rand() % self.maxFontSize + self.minFontSize];
    }
}

- (CGRect)randomFrameForLabel:(UILabel *)label {
    [label sizeToFit];
    CGFloat maxWidth = self.bounds.size.width - label.bounds.size.width - self.labelTextHorizontalPadding * 2;
    CGFloat maxHeight = self.bounds.size.height - label.bounds.size.height - self.labelTextVerticalPadding * 2;
    
    return CGRectMake(random() % (NSInteger)maxWidth,
                      random() % (NSInteger)maxHeight,
                      CGRectGetWidth(label.bounds) + self.labelTextHorizontalPadding * 2,
                      CGRectGetHeight(label.bounds) + self.labelTextVerticalPadding * 2);
}

- (BOOL)frameIntersects:(CGRect)frame {
    CGRect tmpFrame = frame;
    if (self.minSpacing > 0) {
        tmpFrame = CGRectMake(frame.origin.x - self.minSpacing,
                              frame.origin.y - self.minSpacing,
                              frame.size.width + self.minSpacing * 2,
                              frame.size.height + self.minSpacing * 2);
    }
    for (UILabel *label in self.labels) {
        if (CGRectIntersectsRect(tmpFrame, label.frame)) {
            return YES;
        }
    }
    return NO;
}

- (void)reloadData {
    [self.labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.labels removeAllObjects];
    
    int i = 0;
    for (NSString *title in self.titles) {
        assert([title isKindOfClass:[NSString class]]);
        
        UILabel *label = [[UILabel alloc] init];
        label.tag = i++;
        label.text = title;
        label.textColor = [self randomColor];
        label.font = [self font];
        label.layer.borderColor = self.labelBorderColor.CGColor;
        label.layer.borderWidth = self.labelBorderWidth;
        label.layer.cornerRadius = self.labelCornerRadius;
        label.textAlignment = NSTextAlignmentCenter;
        do {
            label.frame = [self randomFrameForLabel:label];
        } while ([self frameIntersects:label.frame]);
        
        [self.labels addObject:label];
        [self addSubview:label];
        
        UITapGestureRecognizer *tagGestue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [label addGestureRecognizer:tagGestue];
        label.userInteractionEnabled = YES;
    }
}

- (void)handleGesture:(UIGestureRecognizer*)gestureRecognizer {
    UILabel *label = (UILabel *)gestureRecognizer.view;
    if (self.tagClickBlock) {
        self.tagClickBlock(label.text,label.tag);
    }
}

@end
