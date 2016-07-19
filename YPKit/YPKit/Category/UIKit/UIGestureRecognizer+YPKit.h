//
//  UIGestureRecognizer+YPKit.h
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (YPKit)

- (instancetype)initWithActionBlock:(void (^)(id sender))block;
- (void)addActionBlock:(void (^)(id sender))block;
- (void)removeAllActionBlocks;

@end

NS_ASSUME_NONNULL_END
