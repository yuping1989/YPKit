//
//  YPControlLabel.h
//  NBD2
//
//  Created by 喻平 on 15/12/1.
//  Copyright © 2015年 NBD2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YPControlLabel;
@protocol YPControlLabelDelegate <NSObject>

- (void)controlLabeldidClicked:(YPControlLabel *)label;

@end

@interface YPControlLabel : UILabel
@property (nonatomic, strong) UIColor *highlightTextColor;
@property (nonatomic, strong) UIColor *highlightBackgroundColor;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) id<YPControlLabelDelegate> delegate;


- (void)setOnClickedHandler:(void (^)(void))clickedHanlder;
@end
