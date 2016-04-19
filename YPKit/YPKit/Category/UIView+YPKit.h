//
//  UIView+UIViewEXT.h
//  CanXinTong
//
//  Created by 喻平 on 13-2-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface UIView (YPKit)
@property (nonatomic, strong) YPCompletionBlock clickedHandler;
@property (nonatomic, strong) CALayer *topLineLayer;
@property (nonatomic, strong) CALayer *bottomLineLayer;

/**
 *  根据nib name返回UIView
 */
+ (instancetype)viewWithNibName:(NSString *)name;
/**
 *  设置点击事件的handler
 */
- (void)setOnClickedHandler:(YPCompletionBlock)clickedHandler;
/**
 *  设置点击事件的target和action
 */
- (void)setTapGestureTarget:(id)target action:(SEL)action;
/**
 *  设置View的大小和位置属性
 */
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setSize:(CGSize)size;
- (CGSize)size;
- (void)setOrigin:(CGPoint)point;
- (CGPoint)origin;

- (CGFloat)height;
- (CGFloat)width;
- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)maxY;
- (CGFloat)maxX;
/**
 *  根据传入的width来水平居中
 */
- (void)horizontalCenterWithWidth:(CGFloat)width;
/**
 *  根据传入的height来竖直居中
 */
- (void)verticalCenterWithHeight:(CGFloat)height;
- (void)verticalCenterInSuperView;
- (void)horizontalCenterInSuperView;
/**
 *  设置边框宽度和颜色
 */
- (void)setBoarderWith:(CGFloat)width color:(UIColor *)color;
- (void)setCornerRadius:(CGFloat)radius;

/**
 *  添加一个SubLayer
 */
- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(UIColor *)color;
/**
 *  设置UIView的顶部和底部边线，一般用在设置界面
 */
- (void)setTopFillLineWithColor:(UIColor *)color;
- (void)setTopLineWithColor:(UIColor *)color paddingLeft:(float)paddingLeft;
- (void)setBottomFillLineWithColor:(UIColor *)color;
- (void)setBottomLineWithColor:(UIColor *)color paddingLeft:(float)paddingLeft;
- (void)setTopAndBottomLineWithColor:(UIColor *)color;


/**
 *  截图
 */
- (UIImage *)capture;
/**
 *  设置UIView的顶部和底部边线，一般用在设置界面，当界面采用AutoLayout时使用
 */
- (UIView *)setTopLineViewWithColor:(UIColor *)color paddingLeft:(CGFloat)left;
- (UIView *)setBottomLineViewWithColor:(UIColor *)color paddingLeft:(CGFloat)left;
- (UIView *)addSubviewWithColor:(UIColor *)color constraints:(void(^)(MASConstraintMaker *make))block;

/**
 *  主要用于UITableView，UIScrollView，UICollectionView等列表类的View，
 *  在数据为空时，显示一个提示性的图像和文字
 */
- (void)setTipsViewWithImageName:(NSString *)imageName
                            text:(NSString *)text
                       textColor:(UIColor *)textColor;
- (void)removeTipsView;
@end
