//
//  YPTextView.h
//  YPKit
//
//  Created by 喻平 on 15/12/3.
//  Copyright © 2015年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPPlaceHolderTextView.h"

@class YPTextView;

@protocol YPTextViewDelegate <UITextViewDelegate>

@optional

- (void)textView:(YPTextView *)textView didContentHeightChanged:(CGFloat)height;

@end


@interface YPTextView : YPPlaceHolderTextView

@property (nonatomic, assign) IBInspectable BOOL dynamicHeightEnabled;
@property (nonatomic, assign) IBInspectable CGFloat maxHeight;
@property (nonatomic, assign) IBInspectable CGFloat heigthChangedAnimateDuration;

@property (nonatomic, weak) id<YPTextViewDelegate> delegate;

@end
