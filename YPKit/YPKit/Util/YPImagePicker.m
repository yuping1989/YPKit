//
//  YPImagePicker.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-4.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPImagePicker.h"
#import "QBImagePickerController.h"
@interface YPImagePicker ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, QBImagePickerControllerDelegate>
{
    YPCompletionBlockWithData _singleBlock;
    YPCompletionBlockWithData _multiBlock;
}
@end
@implementation YPImagePicker
+ (YPImagePicker *)shared
{
    static YPImagePicker *imagePicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imagePicker = [[YPImagePicker alloc] init];
    });
    return imagePicker;
}

- (void)pickImageWithMaxNumber:(NSInteger)maxNumber
                  inController:(UIViewController *)controller
               completionBlock:(void (^)(NSArray *images))completionBlock
{
    _multiBlock = completionBlock;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    [actionSheet showInView:controller.view
      withCompletionHandler:^(NSInteger buttonIndex) {
          if (buttonIndex == 0) {
              UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
              if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
              } else {
                  [YPNativeUtil showToast:@"您的设备不支持相机"];
                  return;
              }
              
              imagePickerController.delegate = self;
              [controller presentViewController:imagePickerController animated:YES completion:nil];
          } else if (buttonIndex == 1) {
              QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
              imagePickerController.delegate = self;
              imagePickerController.allowsMultipleSelection = YES;
              imagePickerController.showsCancelButton = YES;
              imagePickerController.maximumNumberOfSelection = maxNumber;
              UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
              [controller presentViewController:navController animated:YES completion:nil];
          }
      }];
}

- (void)pickSingleImageInController:(UIViewController *)controller
                       allowEditing:(BOOL)allowEditing
        completionBlock:(void (^)(UIImage *image))completionBlock
{
    _singleBlock = completionBlock;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    [actionSheet showInView:controller.view
      withCompletionHandler:^(NSInteger buttonIndex) {
          if (buttonIndex == 2) {
              return;
          }
          UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
          if (buttonIndex == 0) {
              if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
              } else {
                  [YPNativeUtil showToast:@"您的设备不支持相机"];
                  return;
              }
          } else {
              imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
          }
          imagePickerController.delegate = self;
          imagePickerController.allowsEditing = allowEditing;
          [controller presentViewController:imagePickerController animated:YES completion:nil];
      }];
}

- (void)pickSingleImageInController:(UIViewController *)controller
                         sourceType:(UIImagePickerControllerSourceType)sourceType
                       allowEditing:(BOOL)allowEditing
                    completionBlock:(void (^)(UIImage *image))completionBlock
{
    _singleBlock = completionBlock;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [YPNativeUtil showToast:@"您的设备不支持相机"];
            return;
        }
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = sourceType;
    
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = allowEditing;
    [controller presentViewController:imagePickerController animated:YES completion:nil];
}

- (UIViewController *)lastPresentedController:(UIViewController *)firstController
{
    if (firstController.presentedViewController == nil) {
        return firstController;
    } else {
        return [self lastPresentedController:firstController.presentedViewController];
    }
}
- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    @autoreleasepool {
        
        UIImage *image;
        if (picker.allowsEditing) {
            image = info[UIImagePickerControllerEditedImage];
        } else {
            image = [info[UIImagePickerControllerOriginalImage] fixOrientation];
        }
        NSLog(@"image size-->%@", NSStringFromCGSize(image.size));
        if (_singleBlock) {
            _singleBlock(image);
        }
        if (_multiBlock) {
            _multiBlock(@[image]);
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
        _singleBlock = nil;
        _multiBlock = nil;
    }
}


- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    @autoreleasepool {
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 0; i < assets.count; i++) {
            ALAsset *asset = assets[i];
            ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
            [images addObject:[UIImage imageWithCGImage:[assetRepresentation fullScreenImage]]];
        }
        if (_multiBlock) {
            _multiBlock(images);
        }
        [imagePickerController dismissViewControllerAnimated:YES completion:nil];
        _singleBlock = nil;
        _multiBlock = nil;
    }
}
@end
