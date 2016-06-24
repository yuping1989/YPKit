//
//  YPImagePicker.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-4.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPImagePicker.h"
#import "QBImagePickerController.h"
#import <objc/runtime.h>

@interface YPImagePicker () <
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
QBImagePickerControllerDelegate>

@property (nonatomic, copy) void (^singleBlock)(UIImage *image);
@property (nonatomic, copy) void (^multiBlock)(NSArray *images);

@end

@implementation YPImagePicker

+ (instancetype)shared {
    static YPImagePicker *imagePicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imagePicker = [[YPImagePicker alloc] init];
    });
    return imagePicker;
}

+ (void)pickImageWithMaxNumber:(NSInteger)maxNumber
               completionBlock:(void (^)(NSArray *images))completionBlock {
    [[YPImagePicker shared] pickImageWithMaxNumber:maxNumber
                                   completionBlock:completionBlock];
}

+ (void)pickSingleImageAllowEditing:(BOOL)allowEditing
                    completionBlock:(void (^)(UIImage *image))completionBlock {
    [[YPImagePicker shared] pickSingleImageAllowEditing:allowEditing
                                        completionBlock:completionBlock];
}

+ (void)pickSingleImageWithSourceType:(UIImagePickerControllerSourceType)sourceType
                         allowEditing:(BOOL)allowEditing
                      completionBlock:(void (^)(UIImage *image))completionBlock {
    [[YPImagePicker shared] pickSingleImageWithSourceType:sourceType
                                             allowEditing:allowEditing
                                          completionBlock:completionBlock];
}

- (void)pickImageWithMaxNumber:(NSInteger)maxNumber
               completionBlock:(void (^)(NSArray *images))completionBlock {
    self.multiBlock = completionBlock;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [actionSheet showInView:window
      withCompletionBlock:^(NSInteger buttonIndex) {
          if (buttonIndex == 0) {
              UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
              if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
              } else {
                  [UIApplication showToast:@"您的设备不支持相机"];
                  return;
              }
              
              imagePickerController.delegate = self;
              [window.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
          } else if (buttonIndex == 1) {
              QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
              imagePickerController.delegate = self;
              imagePickerController.allowsMultipleSelection = YES;
              imagePickerController.showsCancelButton = YES;
              imagePickerController.maximumNumberOfSelection = maxNumber;
              UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
              [window.rootViewController presentViewController:navController animated:YES completion:nil];
          }
      }];
}

- (void)pickSingleImageAllowEditing:(BOOL)allowEditing
        completionBlock:(void (^)(UIImage *image))completionBlock {
    self.singleBlock = completionBlock;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [actionSheet showInView:window
        withCompletionBlock:^(NSInteger buttonIndex) {
          if (buttonIndex == 2) {
              return;
          }
          UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
          if (buttonIndex == 0) {
              if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
              } else {
                  [UIApplication showToast:@"您的设备不支持相机"];
                  return;
              }
          } else {
              imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
          }
          imagePickerController.delegate = self;
          imagePickerController.allowsEditing = allowEditing;
          [window.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
      }];
}

- (void)pickSingleImageWithSourceType:(UIImagePickerControllerSourceType)sourceType
                           allowEditing:(BOOL)allowEditing
                        completionBlock:(void (^)(UIImage *image))completionBlock {
    self.singleBlock = completionBlock;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [UIApplication showToast:@"您的设备不支持相机"];
            return;
        }
    }
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = allowEditing;
    [window.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    @autoreleasepool {
        
        UIImage *image;
        if (picker.allowsEditing) {
            image = info[UIImagePickerControllerEditedImage];
        } else {
            image = [info[UIImagePickerControllerOriginalImage] imageByFixOrientation];
        }
        NSLog(@"image size-->%@", NSStringFromCGSize(image.size));
        if (self.singleBlock) {
            self.singleBlock(image);
        }
        if (self.multiBlock) {
            self.multiBlock(@[image]);
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.singleBlock = nil;
        self.multiBlock = nil;
    }
}


- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets {
    @autoreleasepool {
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 0; i < assets.count; i++) {
            ALAsset *asset = assets[i];
            ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
            [images addObject:[UIImage imageWithCGImage:[assetRepresentation fullScreenImage]]];
        }
        if (self.multiBlock) {
            self.multiBlock(images);
        }
        [imagePickerController dismissViewControllerAnimated:YES completion:nil];
        self.singleBlock = nil;
        self.multiBlock = nil;
    }
}

@end
