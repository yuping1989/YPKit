//
//  YPTagCloudView.h
//  NBD2
//
//  Created by 喻平 on 16/4/18.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPTagCloudView : UIView

@property (nonatomic, copy) NSArray<NSString *> *titles;

@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, assign) NSInteger minFontSize;
@property (nonatomic, assign) NSInteger maxFontSize;
@property (nonatomic, assign) NSInteger minSpacing;

/**
 *  颜色数组，默认为:
 [UIColor blackColor],
 [UIColor cyanColor],
 [UIColor purpleColor],
 [UIColor orangeColor],
 [UIColor redColor],
 [UIColor yellowColor],
 [UIColor lightGrayColor],
 [UIColor grayColor],
 [UIColor greenColor],
 ]
 */
@property (nonatomic, copy) NSArray<UIColor *> *colors;

@property (nonatomic, copy) void (^tagClickBlock)(NSString *title, NSInteger index);

- (void)setLabelHorizontalPadding:(NSInteger)horizontalPadding
                  verticalPadding:(NSInteger)verticalPadding;

- (void)setLabelBoarderWith:(CGFloat)width
               boarderColor:(UIColor *)color
               cornerRadius:(CGFloat)radius;

- (void)reloadData;
@end
