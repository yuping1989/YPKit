//
//  UIButton+YPKit.m
//  PiFuKeYiSheng
//
//  Created by yuping on 14-6-4.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "UIButton+YPKit.h"

@implementation UIButton (YPKit)

- (void)setContentHorizontalCenterWithMarginTop:(CGFloat)marginTop spacing:(CGFloat)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font width:CGFLOAT_MAX];
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height - marginTop), 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(marginTop, - imageSize.width, - (totalHeight - titleSize.height), 0.0);
    
}

- (void)setContentHorizontalCenterWithSpacing:(CGFloat)spacing {
    [self setContentHorizontalCenterWithMarginTop:0 spacing:spacing];
}

@end
