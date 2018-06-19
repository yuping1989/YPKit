//
//  UIBarButtonItem+YPKit.m
//  YPAlbum
//
//  Created by 喻平 on 2018/6/3.
//  Copyright © 2018年 com.yp. All rights reserved.
//

#import "UIBarButtonItem+YPKit.h"
#import <objc/runtime.h>

static const int block_key;

@interface _YPUIBarButtonItemBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _YPUIBarButtonItemBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}

@end

@implementation UIBarButtonItem (YPKit)

- (void)setActionBlock:(void (^)(UIBarButtonItem *))block {
    _YPUIBarButtonItemBlockTarget *target = [[_YPUIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(UIBarButtonItem *))actionBlock {
    _YPUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
}

@end
