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

#pragma mark - Init

/**
 *  根据nib name返回UIView
 */
+ (instancetype)viewWithNibName:(NSString *)name;

/**
 *  根据nib创建一个view，nib name为ClassName
 */
+ (instancetype)viewFromNib;

#pragma mark - Frame

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

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

#pragma mark - Tap Gesture

/**
 *  添加点击事件，多次调用会持有多个UITapGestureRecognizer对象
 */
- (UITapGestureRecognizer *)addSingleTapGestureWithBlock:(void (^)(UITapGestureRecognizer *recognizer))block;

/**
 *  添加单击事件，多次调用只会持有一个UITapGestureRecognizer对象，之前的会被清除
 */
- (UITapGestureRecognizer *)setSingleTapGestureWithBlock:(void (^)(UITapGestureRecognizer *recognizer))block;
- (UITapGestureRecognizer *)setSingleTapGestureTarget:(id)target action:(SEL)action;

/**
 *  添加双击事件
 */
- (UITapGestureRecognizer *)addDoubleTapGestureWithBlock:(void (^)(UITapGestureRecognizer *recognizer))block;

#pragma mark - Top and bottom line

/**
 *  添加一个SubLayer
 */
- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(UIColor *)color;

/**
 *  设置UIView的顶部和底部边线，一般用在设置界面
 */

@property (nonatomic, strong) CALayer *topLineLayer;
@property (nonatomic, strong) CALayer *bottomLineLayer;

- (void)setTopFillLineWithColor:(UIColor *)color;
- (void)setTopLineWithColor:(UIColor *)color paddingLeft:(CGFloat)paddingLeft;
- (void)setBottomFillLineWithColor:(UIColor *)color;
- (void)setBottomLineWithColor:(UIColor *)color paddingLeft:(CGFloat)paddingLeft;
- (void)setTopAndBottomLineWithColor:(UIColor *)color;

/**
 *  设置UIView的顶部和底部边线，一般用在设置界面，当界面采用AutoLayout时使用
 */
- (UIView *)setTopLineViewWithColor:(UIColor *)color paddingLeft:(CGFloat)left;
- (UIView *)setBottomLineViewWithColor:(UIColor *)color paddingLeft:(CGFloat)left;
- (UIView *)addSubviewWithColor:(UIColor *)color constraints:(void(^)(MASConstraintMaker *make))block;

#pragma mark - Others

@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 *  设置边框宽度和颜色
 */
- (void)setBoarderWith:(CGFloat)width color:(UIColor *)color;

/**
 *  设置圆角
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 *  主要用于UITableView，UIScrollView，UICollectionView等列表类的View，
 *  在数据为空时，显示一个提示性的图像和文字
 */
- (void)setTipsViewWithImageName:(NSString *)imageName
                            text:(NSString *)text
                       textColor:(UIColor *)textColor;
- (void)removeTipsView;

/**
 *  生成快照图像
 */
- (UIImage *)snapshotImage;

/**
 *  生成快照PDF
 */
- (NSData *)snapshotPDF;


#pragma mark - Methods should be deprecated

@property (nonatomic, copy) YPCompletionBlock clickedHandler;

/**
 *  设置点击事件的handler
 */
- (void)setOnClickedHandler:(YPCompletionBlock)clickedHandler;

/**
 *  设置点击事件的target和action
 */
- (void)setTapGestureTarget:(id)target action:(SEL)action;

@end
