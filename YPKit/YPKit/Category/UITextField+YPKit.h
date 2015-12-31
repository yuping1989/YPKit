//
//  UITextField+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-6.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YPKit)
- (void)setContentPaddingLeft:(CGFloat)width;
- (void)setText:(NSString *)text attributeString:(void(^)(NSMutableAttributedString *attrString))block;
- (void)hideInputAssistantItem;
@end
