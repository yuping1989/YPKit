//
//  YPTestTextView.h
//  YPKit
//
//  Created by 喻平 on 14-6-17.
//  Copyright (c) 2014年 com.yp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YPTestTextView;
@protocol YPTestTextViewDelegate <UITextViewDelegate>
@optional
- (void)yp_textView:(YPTestTextView *)textView didContentHeightChanged:(NSInteger)heightOffset;
@end

@interface YPTestTextView : UITextView {

}

@property(nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, assign) NSInteger maxHeight;

@property(nonatomic, assign) id<YPTestTextViewDelegate> delegate;
@end
