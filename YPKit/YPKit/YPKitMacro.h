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

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

/**
 Synthsize a weak or strong reference.
 
 Example:
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

#ifndef YP_DYNAMIC_RETAIN
#define YP_DYNAMIC_RETAIN(_getter_, _setter_, _type_) \
- (void)_setter_:(_type_)object { \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

#ifndef YP_DYNAMIC_COPY
#define YP_DYNAMIC_COPY(_getter_, _setter_, _type_) \
- (void)_setter_:(_type_)object { \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_COPY_NONATOMIC); \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif


#endif /* YPKitMacro_h */
