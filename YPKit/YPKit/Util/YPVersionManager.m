//
//  YPVersionManager.m
//  HuoQiuJiZhang-network
//
//  Created by 喻平 on 2017/12/9.
//  Copyright © 2017年 com.huoqiu. All rights reserved.
//

#import "YPVersionManager.h"

@interface YPVersionManager ()

@property (nonatomic, strong) NSMutableArray *versionNames;

@end

@implementation YPVersionManager

+ (instancetype)sharedManager {
    static YPVersionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YPVersionManager alloc] init];
    });
    return manager;
}

@end
