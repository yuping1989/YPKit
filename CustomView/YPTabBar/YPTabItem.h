//
//  YPTabItem.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPTabItem : UIButton
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger badge;
+ (YPTabItem *)instance;
- (void)addDoubleTapTarget:(id)target action:(SEL)action;
@end
