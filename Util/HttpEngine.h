//
//  HttpEngine.h
//  iCarsClub
//
//  Created by 喻平 on 13-11-13.
//  Copyright (c) 2013年 iCarsclub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"
#import "YPBaseViewController.h"

#define HttpMethodPost     @"POST"
#define HttpMethodGet      @"GET"
#define HttpMethodPut      @"PUT"
#define HttpMethodDelete   @"DELETE"
typedef void (^ApiRequestSuccessedBlock)(id successedData);
typedef BOOL (^ApiRequestFailedBlock)(id failedData);
typedef void (^UploadDownloadFinishedBlock)(MKNetworkOperation *operation);

@class ApiRequest;
@interface HttpEngine : NSObject
@property (nonatomic, strong) MKNetworkEngine *mkNetworkEngine;
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, strong) NSString *hostName;
+ (HttpEngine *)shared;
- (BOOL)isReachable;
- (void)startWithPath:(NSString *)path
               params:(NSMutableDictionary *)params
           httpMethod:(NSString *)method
           controller:(YPBaseViewController *)controller
            successed:(ApiRequestSuccessedBlock)successed;

- (void)startWithPath:(NSString *)path
               params:(NSMutableDictionary *)params
           httpMethod:(NSString *)method
           controller:(YPBaseViewController *)controller
            successed:(ApiRequestSuccessedBlock)successed
               failed:(ApiRequestFailedBlock)failed;

- (void)startWithURLString:(NSString *)urlString
                    params:(NSMutableDictionary *)params
                httpMethod:(NSString *)method
                controller:(YPBaseViewController *)controller
                 successed:(ApiRequestSuccessedBlock)successed
                    failed:(ApiRequestFailedBlock)failed;

- (void)startApiRequest:(ApiRequest *)request
             controller:(YPBaseViewController *)controller
              successed:(ApiRequestSuccessedBlock)successed
                 failed:(ApiRequestFailedBlock)failed;

- (void)downloadFileWithUrlString:(NSString *)urlString
                     toFileAtPath:(NSString *)filePath
                  progressChanged:(MKNKProgressBlock)progressChanged
                       controller:(YPBaseViewController *)controller
                        successed:(UploadDownloadFinishedBlock)successed
                           failed:(UploadDownloadFinishedBlock)failed;

- (void)uploadFileWithUrlString:(NSString *)urlString
                         params:(NSMutableDictionary *)params
                     uploadData:(NSData *)data
                progressChanged:(MKNKProgressBlock)progressChanged
                     controller:(YPBaseViewController *)controller
                      successed:(ApiRequestSuccessedBlock)successed
                         failed:(ApiRequestFailedBlock)failed;

// 显示提示信息
- (void)hideProgressAndShowErrorMsg:(NSString *)message controller:(YPBaseViewController *)controller;

/*
 子类需重写的方法，视情况而定
 */

// 根据path组装请求的url
- (NSString *)requestUrlWithPath:(NSString *)path;

// 请求失败时，获取错误信息
- (NSString *)getErrorMessage:(NSDictionary *)responseData;

// 请求成功的处理
- (void)operationSuccessed:(NSDictionary *)responseData
                controller:(YPBaseViewController *)controller
          successedHandler:(ApiRequestSuccessedBlock)successed
             failedHandler:(ApiRequestFailedBlock)failed;

// 请求失败的处理
- (void)operationFailed:(NSDictionary *)responseData
             controller:(YPBaseViewController *)controller
          failedHandler:(ApiRequestFailedBlock)failed;

@end
/*
 封装请求参数，一般用于下载，上传等比较复杂的情况
 */
@interface ApiRequest : NSObject
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSArray *uploadFilePaths;
@property (nonatomic, strong) NSArray *uploadFileDatas;
@property (nonatomic, strong) MKNKProgressBlock uploadProgressBlock;
@property (nonatomic, strong) MKNKProgressBlock downloadProgressBlock;

- (id)initWithUrlString:(NSString *)urlString
                 params:(NSMutableDictionary *)params
                 method:(NSString *)method;
@end
/*
 封装文件上传参数
 */
@interface UploadFile : NSObject
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *mimeType;
@property (nonatomic, strong) NSString *fileName;

- (id)initWithKey:(NSString *)key
             data:(NSData *)data
         mimeType:(NSString *)mimeType
         fileName:(NSString *)fileName;

- (id)initWithKey:(NSString *)key
         filePath:(NSString *)filePath
         mimeType:(NSString *)mimeType;
@end
