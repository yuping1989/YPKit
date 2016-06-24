//
//  YPImagePicker.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-4.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//  获取照片

#import <Foundation/Foundation.h>

@interface YPImagePicker : NSObject

/**
 *  获取多张照片
 *
 *  @param maxNumber       最大选择数量
 *  @param completionBlock 回调
 */
+ (void)pickImageWithMaxNumber:(NSInteger)maxNumber
               completionBlock:(void (^)(NSArray *images))completionBlock;

/**
 *  获取单张图片，包括拍照和从相册选择两种方式
 *
 *  @param allowEditing    获取后是否可以编辑
 *  @param completionBlock 回调
 */
+ (void)pickSingleImageAllowEditing:(BOOL)allowEditing
                    completionBlock:(void (^)(UIImage *image))completionBlock;

/**
 *  获取单张图片
 *
 *  @param sourceType      获取方式
 *  @param allowEditing    获取后是否可以编辑
 *  @param completionBlock 回调
 */
+ (void)pickSingleImageWithSourceType:(UIImagePickerControllerSourceType)sourceType
                       allowEditing:(BOOL)allowEditing
                    completionBlock:(void (^)(UIImage *image))completionBlock;
@end
