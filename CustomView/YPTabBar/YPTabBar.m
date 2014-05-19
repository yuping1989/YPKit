//
//  YPTabBar.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPTabBar.h"
#import "YPTabItem.h"

@implementation YPTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    float x = 0;
    float width = self.width / _titles.count;
    for (int i = 0; i < _titles.count; i++) {
        YPTabItem *item = [YPTabItem buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(x, 0, width, self.height);
        [item setTitle:_titles[i] forState:UIControlStateNormal];
        [item setBackgroundImage:_itemNormalBgImage forState:UIControlStateNormal];
        [item setBackgroundImage:_itemSelectedBgImage forState:UIControlStateSelected];
        
        [self addSubview:item];
        x += width;
    }
}
@end
