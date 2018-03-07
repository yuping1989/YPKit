//
//  UIControl+YPKit.h
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (YPKit)

/**
 *  移除所有的target
 */
- (void)removeAllTargets;

/**
 *  设置点击事件的target
 */
- (void)addTouchUpInsideTarget:(id)target action:(SEL)action;

/**
 *  此方法与addTarget的区别是：它会移除之前已为传入的controlEvents设置的targets
 */
- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  为controlEvents添加一个block回调
 */
- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/**
 *  为UIControlEventTouchUpInside添加block回调
 */
- (void)addTouchUpInsideEventBlock:(void (^)(id sender))block;

/**
 *  为controlEvents设置一个block回调，它会移除之前已为传入的controlEvents设置的blocks
 */
- (void)setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/**
 *  为UIControlEventTouchUpInside设置block回调，之前的会被删除
 */
- (void)setTouchUpInsideEventBlock:(void (^)(id sender))block;

/**
 *  移除所有的为传入的controlEvents添加的blocks
 */
- (void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;

/**
 *  返回所有的Block Targets
 */
- (nullable NSArray *)allBlockTargets;

@end

NS_ASSUME_NONNULL_END

