//
//  YPBadgeView.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-10-21.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPBadgeView.h"

@implementation YPBadgeView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.badgeLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_bgImageView];
    [self addSubview:_badgeLabel];
    self.padding = 3;
}

- (void)setBackgroundImageName:(NSString *)imageName
{
    _bgImageView.image = [UIImage stretchableImageNamed:imageName];
}
- (void)setBadgeFont:(UIFont *)font textColor:(UIColor *)color
{
    _badgeLabel.font = font;
    _badgeLabel.textColor = color;
}

- (void)setBadge:(NSInteger)badge
{
    _badge = badge;
    if (badge == 0) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
        _badgeLabel.text = @(badge).stringValue;
    }
}

- (void)updateWidth {
    int width = [_badgeLabel.text widthWithFont:_badgeLabel.font];
    self.yp_width = MAX(width + self.padding * 2, self.yp_height);
    _bgImageView.frame = self.bounds;
    _badgeLabel.frame = self.bounds;
}

- (void)setPadding:(CGFloat)padding {
    _padding = padding;
    [self updateWidth];
}
@end
