//
//  YPImagePicker.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-4.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPImagePicker : NSObject
+ (YPImagePicker *)shared;
- (void)pickImageWithMaxNumber:(int)maxNumber
                  inController:(UIViewController *)controller
               completionBlock:(void (^)(NSArray *images))completionBlock;
- (void)pickSingleImageInController:(UIViewController *)controller
                       allowEditing:(BOOL)allowEditing
                    completionBlock:(void (^)(UIImage *image))completionBlock;
@end
