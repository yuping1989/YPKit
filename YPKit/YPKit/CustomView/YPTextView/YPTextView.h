//
//  YPTextView.h
//  YPKit
//
//  Created by 喻平 on 15/12/3.
//  Copyright © 2015年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPTextView : UITextView
@property(nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, assign) CGFloat minHeight;
@end
