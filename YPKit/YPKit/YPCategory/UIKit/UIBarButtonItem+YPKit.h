//
//  UIBarButtonItem+YPKit.h
//  YPAlbum
//
//  Created by 喻平 on 2018/6/3.
//  Copyright © 2018年 com.yp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YPKit)

@property (nullable, nonatomic, copy) void (^actionBlock)(UIBarButtonItem *item);

@end
