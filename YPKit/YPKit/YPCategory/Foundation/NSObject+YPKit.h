//
//  NSObject+YPKit.h
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const YPNightModelSwitchedNotification;

typedef void (^YPKVOBlock)(__weak id obj, id oldVal, id newVal);
typedef void (^YPKeyboardBlock)(NSNotification *noti, CGRect rect, CGFloat duration);

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

#pragma mark - Properties

+ (NSArray *)yp_propertyNames;

#pragma mark - Associate value

- (void)setAssociateValue:(nullable id)value withKey:(void *)key;
- (void)setAssociateWeakValue:(nullable id)value withKey:(void *)key;
- (void)setAssociateCopyValue:(id)value withKey:(void *)key;
- (nullable id)getAssociatedValueForKey:(void *)key;
- (void)removeAssociatedValues;

#pragma mark - KVO

- (void)setObserverBlockForKeyPath:(NSString *)keyPath
                             block:(YPKVOBlock)block;
- (void)addObserverBlockForKeyPath:(NSString *)keyPath
                             block:(YPKVOBlock)block;
- (void)removeObserverBlocksForKeyPath:(NSString *)keyPath;
- (void)removeObserverBlocks;

- (void)setBlockObserver:(NSObject *)object
              forKeyPath:(NSString *)keyPath
                   block:(YPKVOBlock)block;
- (void)addBlockObserver:(NSObject *)object
              forKeyPath:(NSString *)keyPath
                   block:(YPKVOBlock)block;
- (void)removeBlockObserver:(NSObject *)object;
- (void)removeBlockObserver:(NSObject *)object
                 forKeyPath:(NSString *)keyPath;

- (void)removeAllObserverBlocks;

#pragma mark - Notification

- (void)setNotificationBlockForName:(NSString *)name block:(void (^)(NSNotification *notification))block;
- (void)addNotificationBlockForName:(NSString *)name block:(void (^)(NSNotification *notification))block;
- (void)removeNotificationBlocksForName:(NSString *)name;
- (void)removeNotificationBlocks;

#pragma mark - Keyboard Observer

- (void)setKeyboardShowBlock:(YPKeyboardBlock)showBlock
                   hideBlock:(YPKeyboardBlock)hideBlock;
- (void)removeKeyboardBlocks;

/**
 *  键盘通知
 */
- (void)addKeyboardObserver;
- (void)removeKeyboardObserver;

/**
 *  键盘通知回调事件，主要用于子类重写
 *
 *  @param keyboardRect 键盘rect
 *  @param duration     键盘弹出动画的时间
 */
- (void)keyboardWillShowWithRect:(CGRect)keyboardRect animationDuration:(CGFloat)duration;
- (void)keyboardWillHideWithRect:(CGRect)keyboardRect animationDuration:(CGFloat)duration;

#pragma mark - Others

+ (NSString *)className;
- (NSString *)className;

- (nullable id)deepCopy;
- (nullable id)deepCopyWithArchiver:(Class)archiver unarchiver:(Class)unarchiver;

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
- (float)yp_floatForKey:(id)key;

- (nullable id)yp_objectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
