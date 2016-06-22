//
//  UncaughtExceptionHandler.h
//  本类用于捕获和处理异常信息
//
//  Created by 喻平 on 16/5/5.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPUncaughtExceptionHandler : NSObject
/**
 *  是否将错误信息写入到Document文件夹下
 */
@property (nonatomic, assign) BOOL shouldWriteExceptionDataToDisk;

/**
 *  是否显示错误信息的提示Alert
 */
@property (nonatomic, assign) BOOL shouldShowExceptionAlert;

/**
 *  发生异常时的回调
 */
@property (nonatomic, copy) void (^exceptionHandler)(NSException *exception);

+ (NSString *)exceptionFilesDirectory;
@end
void HandleException(NSException *exception);
void SignalHandler(int signal);

/**
 *  异常捕获注册
 *
 *  @param shouldWriteExceptionDataToDisk 是否将异常信息写入到Document文件夹下
 *  @param ^exceptionHandler              发生错误时的回调
 */
void YPInstallUncaughtExceptionHandler(BOOL shouldWriteExceptionDataToDisk,
                                       BOOL shouldShowExceptionAlert,
                                       void (^exceptionHandler)(NSException *exception));
