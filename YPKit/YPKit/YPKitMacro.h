//
//  YPKitMacro.h
//  YPKit
//
//  Created by 喻平 on 16/7/5.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef YPKitMacro_h
#define YPKitMacro_h

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
 快捷实现NSUserDefaults存取属性的方法
 
 示例:
 @interface NSObject (YPKit)
 @property (nonatomic, strong) NSArray *names;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (YPKit)
 YP_USER_DEFAULTS_PROPERTY(names, setNames, @"kNames")
 @end
 */
#ifndef YP_USER_DEFAULTS_PROPERTY
#define YP_USER_DEFAULTS_PROPERTY(_getter_, _setter_, _key_) \
- (void)_setter_ : (id)object { \
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:_key_]; \
    [[NSUserDefaults standardUserDefaults] synchronize]; \
} \
- (id)_getter_ { \
    return [[NSUserDefaults standardUserDefaults] objectForKey:_key_]; \
}
#endif

#endif /* YPKitMacro_h */
