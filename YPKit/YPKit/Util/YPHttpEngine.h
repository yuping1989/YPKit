//
//  YPHttpEngine.h
//
//  Created by 喻平 on 13-11-13.
//  Copyright (c) 2013年 iCarsclub. All rights reserved.
//
//  此类库为封装MKNetworkKit的http请求库，但是由于MKNetworkKit长期没有维护，所以不建议使用

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"
#import "YPBaseViewController.h"

extern NSString *const HttpMethodPost;
extern NSString *const HttpMethodGet;
extern NSString *const HttpMethodPut;
extern NSString *const HttpMethodDelete;

typedef void (^ApiRequestSuccessedBlock)(id successedData, MKNetworkOperation *operation);
typedef BOOL (^ApiRequestFailedBlock)(id failedData, MKNetworkOperation *operation);
typedef void (^UploadDownloadFinishedBlock)(MKNetworkOperation *operation);

@class ApiRequest;
@interface YPHttpEngine : NSObject
@property (nonatomic, strong) MKNetworkEngine *mkNetworkEngine;
@property (nonatomic, strong) NSString *baseURLString;
+ (YPHttpEngine *)shared;
- (MKNetworkOperation *)startWithPath:(NSString *)path
               params:(NSMutableDictionary *)params
           httpMethod:(NSString *)method
           controller:(UIViewController *)controller
            successed:(ApiRequestSuccessedBlock)successed;

- (MKNetworkOperation *)startWithPath:(NSString *)path
               params:(NSMutableDictionary *)params
           httpMethod:(NSString *)method
           controller:(UIViewController *)controller
            successed:(ApiRequestSuccessedBlock)successed
               failed:(ApiRequestFailedBlock)failed;

- (MKNetworkOperation *)startWithURLString:(NSString *)urlString
                    params:(NSMutableDictionary *)params
                httpMethod:(NSString *)method
                controller:(UIViewController *)controller
                 successed:(ApiRequestSuccessedBlock)successed
                    failed:(ApiRequestFailedBlock)failed;

- (void)startWithOperation:(MKNetworkOperation *)operation
                controller:(UIViewController *)controller
                 successed:(ApiRequestSuccessedBlock)successed
                    failed:(ApiRequestFailedBlock)failed;

- (MKNetworkOperation *)startApiRequest:(ApiRequest *)request
             controller:(UIViewController *)controller
              successed:(ApiRequestSuccessedBlock)successed
                 failed:(ApiRequestFailedBlock)failed;

- (MKNetworkOperation *)downloadFileWithUrlString:(NSString *)urlString
                     toFileAtPath:(NSString *)filePath
                  progressChanged:(MKNKProgressBlock)progressChanged
                       controller:(UIViewController *)controller
                        successed:(UploadDownloadFinishedBlock)successed
                           failed:(UploadDownloadFinishedBlock)failed;

- (MKNetworkOperation *)uploadFileWithUrlString:(NSString *)urlString
                         params:(NSMutableDictionary *)params
                     uploadData:(NSData *)data
                progressChanged:(MKNKProgressBlock)progressChanged
                     controller:(UIViewController *)controller
                      successed:(ApiRequestSuccessedBlock)successed
                         failed:(ApiRequestFailedBlock)failed;

- (NSString *)requestURLStringWithPath:(NSString *)path;

// 显示提示信息
- (void)hideProgressAndShowErrorMsg:(NSString *)message controller:(UIViewController *)controller;

/*
 子类需重写的方法，视情况而定
 */


// 请求失败时，获取错误信息
- (NSString *)getErrorMessage:(NSDictionary *)responseData;

// 请求成功的处理
- (void)operationSuccessed:(MKNetworkOperation *)operation
              responseData:(id)responseData
                controller:(UIViewController *)controller
          successedHandler:(ApiRequestSuccessedBlock)successed
             failedHandler:(ApiRequestFailedBlock)failed;

// 请求失败的处理
- (void)operationFailed:(MKNetworkOperation *)operation
           responseData:(id)responseData
             controller:(UIViewController *)controller
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
