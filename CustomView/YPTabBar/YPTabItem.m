//
//  YPTabItem.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPTabItem.h"
@interface YPTabItem ()
@property (nonatomic, strong) UIButton *badgeButton;
@property (nonatomic, strong) UIView *doubleTapView;
@property (nonatomic, strong) UIView *pointView;
@end
@implementation YPTabItem

+ (YPTabItem *)instance
{
    YPTabItem *item = [YPTabItem buttonWithType:UIButtonTypeCustom];
    item.badgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [item.badgeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [item.badgeButton setBackgroundImage:[UIImage stretchableImageNamed:@"tabbar_notice_bg"] forState:UIControlStateNormal];
    item.badgeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    item.badgeButton.contentMode = UIViewContentModeCenter;
    item.badgeButton.userInteractionEnabled = NO;
    item.badgeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
    
    [item addSubview:item.badgeButton];
    item.adjustsImageWhenHighlighted = NO;
    item.badge = 0;
    return item;
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _badgeButton.frame = CGRectMake(45, 3, 16, 16);
    if (_doubleTapView) {
        _doubleTapView.frame = self.bounds;
    }
}

- (void)setBadge:(NSInteger)badge
{
    _badge = badge;
    if (badge == 0) {
        _badgeButton.hidden = YES;
    } else {
        _badgeButton.hidden = NO;
        NSString *badgeStr = @(badge).stringValue;
        _badgeButton.width = MAX(ceilf([badgeStr widthWithFont:self.titleLabel.font]) + 9, 16);
        [_badgeButton setTitle:badgeStr forState:UIControlStateNormal];
    }
}

- (void)setShowPoint:(BOOL)showPoint {
    if (_pointView == nil) {
        self.pointView = [[UIView alloc] initWithFrame:CGRectMake(55, 3, 8, 8)];
        [_pointView setCornerRadius:4];
        _pointView.backgroundColor = rgb(255, 59, 48);
        _pointView.clipsToBounds = NO;
        [self addSubview:_pointView];
    }
    _pointView.hidden = !showPoint;
}

- (void)centerImageAndTitle:(float)spacing {
    CGSize imageSize = self.imageView.frame.size;
    [self centerImageAndTitle:spacing withImageSize:CGSizeMake(25, 25)];
}

- (void)centerImageAndTitle:(float)spacing withImageSize:(CGSize)imageSize
{
    // get the size of the elements here for readability
    NSLog(@"size-->%@", NSStringFromCGSize(imageSize));
    CGSize titleSize = self.titleLabel.frame.size;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height) + 8, 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height) - 4, 0.0);
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (_doubleTapView) {
        _doubleTapView.hidden = !selected;
    }
}
- (void)addDoubleTapTarget:(id)target action:(SEL)action
{
    if (self.doubleTapView == nil) {
        self.doubleTapView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_doubleTapView];
    }
    UITapGestureRecognizer *doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    doubleRecognizer.numberOfTapsRequired = 2;
    [_doubleTapView addGestureRecognizer:doubleRecognizer];
}
@end
