//
//  UIGestureRecognizer+YPKit.h
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (YPKit)

- (instancetype)initWithActionBlock:(void (^)(id sender))block;
- (void)addActionBlock:(void (^)(id sender))block;
- (void)removeAllActionBlocks;

@end
