//
//  YPCheckBox.h
//  ;;
//
//  Created by 喻平 on 13-12-20.
//  Copyright (c) 2013年 com.huoqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YPCheckBox;
@protocol YPCheckBoxDelegate <NSObject>
@optional
- (void)ypCheckBox:(YPCheckBox *)checkBox stateDidChanged:(BOOL)checked;

@end

@interface YPCheckBox : UIButton
@property(nonatomic, assign) BOOL checked;
@property(nonatomic, assign) IBOutlet id<YPCheckBoxDelegate> delegate;

+ (id)checkBoxWithFrame:(CGRect)frame;
@end
