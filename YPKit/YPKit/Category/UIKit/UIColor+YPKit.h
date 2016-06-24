//
//  UIColor+YPKit.h
//  NBD2
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  通过RGB颜色值返回UIColor
 */
#define RGB(RED,GREEN,BLUE) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:1.0f]
#define RGBA(RED,GREEN,BLUE,ALPHA) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA]

@interface UIColor (YPKit)

@end
