//
//  YPTextView.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-17.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YPTextView;
@protocol YPTextViewDelegate <UITextViewDelegate>
@optional
- (void)ypTextView:(YPTextView *)textView didContentHeightChanged:(int)height;
@end

@interface YPTextView : UITextView
{
    
}
@property (strong, nonatomic) NSString *placeholderText;
@property (strong, nonatomic) UIColor *placeholderColor;
@property (strong, nonatomic) UIImage *backgroundImage;
@property (nonatomic, assign) id<YPTextViewDelegate> delegate;
@property (nonatomic, assign) int maxHeight;
@property (nonatomic, assign) int minHeight;
- (void)resetHeight;
@end
