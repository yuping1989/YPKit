//
//  YPBadgeView.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-10-21.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPBadgeView : UIView
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, assign) CGFloat padding;

- (void)setBadgeFont:(UIFont *)font textColor:(UIColor *)color;

@property (nonatomic, assign) NSInteger badge;
- (void)setBackgroundImageName:(NSString *)imageName;
@end
