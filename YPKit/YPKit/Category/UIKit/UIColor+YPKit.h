//
//  UIColor+YPKit.h
//  NBD2
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  通过RGB颜色值返回UIColor，废弃
 */
#define RGB(RED,GREEN,BLUE) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:1.0f]
#define RGBA(RED,GREEN,BLUE,ALPHA) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA]

/**
 *  返回UIColor对象，示例：UIColorRGB(255, 255, 255)
 */
#define UIColorRGB(RED,GREEN,BLUE) UIColorRGBA(RED,GREEN,BLUE,1.0f)

/**
 *  返回UIColor对象，示例：UIColorRGBA(255, 255, 255, 0.8f)
 */
#define UIColorRGBA(RED,GREEN,BLUE,ALPHA) \
        [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA]

@interface UIColor (YPKit)

@end
