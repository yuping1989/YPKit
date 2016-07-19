//
//  NSDictionary+YPKit.m
//  NBD2
//
//  Created by 喻平 on 14-8-5.
//  Copyright (c) 2014年 NBD2. All rights reserved.
//

#import "NSDictionary+YPKit.h"
#import <objc/runtime.h>

@implementation NSDictionary (YPKit)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(description)), class_getInstanceMethod([self class], @selector(replaceDescription)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:)), class_getInstanceMethod([self class], @selector(replaceDescriptionWithLocale:)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:indent:)), class_getInstanceMethod([self class], @selector(replaceDescriptionWithLocale:indent:)));
}

- (NSString *)replaceDescription {
    return [NSObject stringByReplaceUnicode:[self replaceDescription]];
}

- (NSString *)replaceDescriptionWithLocale:(nullable id)locale {
    return [NSObject stringByReplaceUnicode:[self replaceDescriptionWithLocale:locale]];
}

- (NSString *)replaceDescriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [NSObject stringByReplaceUnicode:[self replaceDescriptionWithLocale:locale indent:level]];
}

- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
+ (NSDictionary *)dictionaryWithPlistFile:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}


@end
