//
//  YPControlView.h
//  ChangQingQuan
//
//  Created by 喻平 on 15/4/16.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPControlView : UIView
@property (nonatomic, strong) UIColor *highlightBackgroundColor;
- (void)setOnClickedHandler:(void (^)(void))clickedHanlder;
@end
