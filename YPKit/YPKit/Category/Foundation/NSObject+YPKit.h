//
//  NSObject+YPKit.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const YPNightModelSwitchedNotification;

@interface NSObject (YPKit)

#pragma mark - Swap method (Swizzling)
/**
 *  交换对象方法实现
 */
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

/**
 *  交换类方法实现
 */
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

#pragma mark - Associate value

- (void)setAssociateValue:(nullable id)value withKey:(void *)key;
- (void)setAssociateWeakValue:(nullable id)value withKey:(void *)key;
- (void)setAssociateCopyValue:(id)value withKey:(void *)key;
- (nullable id)getAssociatedValueForKey:(void *)key;
- (void)removeAssociatedValues;

#pragma mark - KVO

- (void)addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id _Nonnull obj, _Nullable id oldVal, _Nullable id newVal))block;
- (void)removeObserverBlocksForKeyPath:(NSString*)keyPath;
- (void)removeObserverBlocks;

#pragma mark - Others

+ (NSString *)className;
- (NSString *)className;

- (nullable id)deepCopy;
- (nullable id)deepCopyWithArchiver:(Class)archiver unarchiver:(Class)unarchiver;

/**
 *  添加夜间模式切换的监听
 */
- (void)addNightModelSwitchedObserver;
- (void)removeNightModelSwitchedObserver;
- (void)nightModelSwitched:(nullable NSNotification *)notification;

+ (NSString *)stringByReplaceUnicode:(NSString *)string;

/**
 *  清除掉NSArray或者NSDictionary里面的NSNull对象
 */
- (id)removeNullObjects;

- (nullable NSArray *)yp_arrayForKey:(id)key;
- (nullable NSDictionary *)yp_dictionaryForKey:(id)key;
- (nullable NSString *)yp_stringForKey:(id)key;
- (nullable NSNumber *)yp_numberForKey:(id)key;
- (NSInteger)yp_integerForKey:(id)key;
- (BOOL)yp_boolForKey:(id)key;
- (CGFloat)yp_floatForKey:(id)key;

- (nullable id)yp_objectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
