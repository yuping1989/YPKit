//
//  YPKitMacro.h
//  YPKit
//
//  Created by 喻平 on 16/7/5.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pthread.h>

#ifndef YPKitMacro_h
#define YPKitMacro_h

#define YP_UD [NSUserDefaults standardUserDefaults]
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

/**
 循环引用解决方案简写
 
 示例:
 @weakify(self)
 [self doSomething^{
    @strongify(self)
    if (!self) return;
    ...
 }];
 
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

/**
 快捷实现Category里面定义的 retain 类型的对象属性

 示例:
 @interface NSObject (YPKit)
 @property (nonatomic, strong) UIColor *color;
 @end
 
 @implementation NSObject (YPKit)
 YP_DYNAMIC_PROPERTY_RETAIN(color, setColor, UIColor *)
 @end
 */
#ifndef YP_DYNAMIC_PROPERTY_RETAIN
#define YP_DYNAMIC_PROPERTY_RETAIN(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

/**
 快捷实现Category里面定义的 copy 类型的对象属性
 
 示例:
 @interface NSObject (YPKit)
 @property (nonatomic, copy) NSString *string;
 @end
 
 @implementation NSObject (YPKit)
 YP_DYNAMIC_PROPERTY_COPY(string, setString, NSString *)
 @end
 */
#ifndef YP_DYNAMIC_PROPERTY_COPY
#define YP_DYNAMIC_PROPERTY_COPY(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_COPY_NONATOMIC); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

/**
 快捷实现Category里面定义的CType属性
 
 示例:
 @interface NSObject (YPKit)
 @property (nonatomic, assign) CGSize size;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (YPKit)
 YP_DYNAMIC_PROPERTY_CTYPE(size, setSize, CGSize)
 @end
 */
#ifndef YP_DYNAMIC_PROPERTY_CTYPE
#define YP_DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    _type_ cValue = { 0 }; \
    NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
    [value getValue:&cValue]; \
    return cValue; \
}
#endif

/**
 快捷实现NSUserDefaults存取属性的方法，Object
 
 示例:
 @interface NSObject (YPKit)
 @property (nonatomic, strong) NSArray *names;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (YPKit)
 YP_USER_DEFAULTS_PROPERTY_OBJECT(names, setNames, @"kNames")
 @end
 */
#ifndef YP_USER_DEFAULTS_PROPERTY_OBJECT
#define YP_USER_DEFAULTS_PROPERTY_OBJECT(_getter_, _setter_, _key_) \
- (void)_setter_ : (id)object { \
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:_key_]; \
    [[NSUserDefaults standardUserDefaults] synchronize]; \
} \
- (id)_getter_ { \
    return [[NSUserDefaults standardUserDefaults] objectForKey:_key_]; \
}
#endif


/**
 快捷实现NSUserDefaults存取属性的方法，NSInteger
 
 示例:
 @interface NSObject (YPKit)
 @property (nonatomic, assign) NSInteger count;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (YPKit)
 YP_USER_DEFAULTS_PROPERTY_INTEGER(count, setCount, @"kCount")
 @end
 */
#ifndef YP_USER_DEFAULTS_PROPERTY_INTEGER
#define YP_USER_DEFAULTS_PROPERTY_INTEGER(_getter_, _setter_, _key_) \
- (void)_setter_ : (NSInteger)value { \
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:_key_]; \
    [[NSUserDefaults standardUserDefaults] synchronize]; \
} \
- (NSInteger)_getter_ { \
    return [[NSUserDefaults standardUserDefaults] integerForKey:_key_]; \
}
#endif

/**
 快捷实现NSUserDefaults存取属性的方法，BOOL
 
 示例:
 @interface NSObject (YPKit)
 @property (nonatomic, assign) BOOL on;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (YPKit)
 YP_USER_DEFAULTS_PROPERTY_BOOL(on, setOn, @"kOn")
 @end
 */
#ifndef YP_USER_DEFAULTS_PROPERTY_BOOL
#define YP_USER_DEFAULTS_PROPERTY_BOOL(_getter_, _setter_, _key_) \
- (void)_setter_ : (BOOL)value { \
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:_key_]; \
    [[NSUserDefaults standardUserDefaults] synchronize]; \
} \
- (BOOL)_getter_ { \
    return [[NSUserDefaults standardUserDefaults] boolForKey:_key_]; \
}
#endif

/**
 快捷实现NSUserDefaults存取属性的方法，float
 
 示例:
 @interface NSObject (YPKit)
 @property (nonatomic, assign) float amount;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (YPKit)
 YP_USER_DEFAULTS_PROPERTY_FLOAT(amount, setAmount, @"kAmount")
 @end
 */
#ifndef YP_USER_DEFAULTS_PROPERTY_FLOAT
#define YP_USER_DEFAULTS_PROPERTY_FLOAT(_getter_, _setter_, _key_) \
- (void)_setter_ : (float)value { \
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:_key_]; \
    [[NSUserDefaults standardUserDefaults] synchronize]; \
} \
- (float)_getter_ { \
    return [[NSUserDefaults standardUserDefaults] floatForKey:_key_]; \
}
#endif

/**
 快捷实现NSUserDefaults存取属性的方法，double
 
 示例:
 @interface NSObject (YPKit)
 @property (nonatomic, assign) double amount;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (YPKit)
 YP_USER_DEFAULTS_PROPERTY_DOUBLE(amount, setAmount, @"kAmount")
 @end
 */
#ifndef YP_USER_DEFAULTS_PROPERTY_DOUBLE
#define YP_USER_DEFAULTS_PROPERTY_DOUBLE(_getter_, _setter_, _key_) \
- (void)_setter_ : (double)value { \
    [[NSUserDefaults standardUserDefaults] setDouble:value forKey:_key_]; \
    [[NSUserDefaults standardUserDefaults] synchronize]; \
} \
- (double)_getter_ { \
    return [[NSUserDefaults standardUserDefaults] doubleForKey:_key_]; \
}
#endif

// A == 0
#ifndef F_EQUAL_ZERO
#define F_EQUAL_ZERO(A) ((fabs(A)) <= FLT_EPSILON)
#endif

// A == B
#ifndef F_EQUAL
#define F_EQUAL(A, B) ((fabs((A) - (B))) < FLT_EPSILON)
#endif

// A > B
#ifndef F_GREATER_THAN
#define F_GREATER_THAN(A, B) ((A) - (B) > FLT_EPSILON && (!(F_EQUAL(A, B))))
#endif

// A >= B
#ifndef F_GREATER_THAN_OR_EQUAL
#define F_GREATER_THAN_OR_EQUAL(A, B) (F_GREATER_THAN(A, B) || F_EQUAL(A,B))
#endif

// A < B
#ifndef F_LESS_THAN
#define F_LESS_THAN(A, B) ((A) - (B) < FLT_EPSILON && (!(F_EQUAL(A, B))))
#endif

// A <= B
#ifndef F_LESS_THAN_OR_EQUAL
#define F_LESS_THAN_OR_EQUAL(A, B) (F_LESS_THAN(A, B) || F_EQUAL(A, B))
#endif

#define YP_ADD_NOTI(_name_, _selector_) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_selector_) name:_name_ object:nil]

#define YP_POST_NOTI(_name_, _obj_) [[NSNotificationCenter defaultCenter] postNotificationName:_name_ object:_obj_];

#endif /* YPKitMacro_h */


static inline void yp_gcd_after(NSTimeInterval second, dispatch_block_t block) {
    if (!block) return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

static inline void yp_gcd_main_async(dispatch_block_t block) {
    if (!block) return;
    dispatch_async(dispatch_get_main_queue(), block);
}

static inline void yp_gcd_bg_async(dispatch_block_t block) {
    if (!block) return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}
