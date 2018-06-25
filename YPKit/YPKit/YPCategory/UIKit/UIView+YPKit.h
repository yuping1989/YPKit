//
//  UIView+UIViewEXT.h
//  CanXinTong
//
//  Created by 喻平 on 13-2-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YPViewLine) {
    YPViewLineTypeTop,
    YPViewLineTypeLeft,
    YPViewLineTypeBottom,
    YPViewLineTypeRight,
};

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

@property (nonatomic) CGFloat yp_x;
@property (nonatomic) CGFloat yp_y;
@property (nonatomic) CGFloat yp_width;
@property (nonatomic) CGFloat yp_height;
@property (nonatomic) CGFloat yp_centerX;
@property (nonatomic) CGFloat yp_centerY;

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

#pragma mark - Line

- (UIView *)addLine:(YPViewLine)type color:(UIColor *)color;
- (UIView *)addLine:(YPViewLine)type
        paddingLead:(CGFloat)paddingLead
       paddingTrail:(CGFloat)paddingTrail
          thickness:(CGFloat)thickness
              color:(UIColor *)color;
- (UIView *)lineForType:(YPViewLine)type;

- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(UIColor *)color;

#pragma mark - Others

/**
 *  返回它所在的ViewController
 */
- (UIViewController *)viewController;

@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 *  设置边框宽度和颜色
 */
- (void)setBoarderWith:(CGFloat)width color:(UIColor *)color;

/**
 *  设置圆角
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 *  生成快照图像
 */
- (UIImage *)snapshotImage;

/**
 *  生成快照PDF
 */
- (NSData *)snapshotPDF;

@end
