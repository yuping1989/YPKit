//
//  UILabel+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YPKit)
- (void)setText:(NSString *)text attributeString:(void(^)(NSMutableAttributedString *attrString))block;
- (void)resizeToFitHeight;
- (void)resizeToFitWidth;
@end