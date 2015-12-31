//
//  YPHttpUtil.h
//  YPKit
//
//  Created by 喻平 on 15/10/27.
//  Copyright © 2015年 YPKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void (^AFHttpRequestSuccessBlock)(id successData, NSURLSessionDataTask *task);
typedef BOOL (^AFHttpRequestErrorBlock)(id errorData, NSURLSessionDataTask *task);
typedef void (^AFHttpRequestProgressBlock)(NSProgress *progress);

@interface YPHttpUtil : NSObject
/**
 *  基础URL，设置此URL后，调用POST，GET，upload，download等方法可以只传入相关的path即可
 */
@property (nonatomic, strong) NSURL *baseURL;
/**
 *  用于POST，GET等方法
 */
@property (nonatomic, strong, readonly) AFHTTPSessionManager *httpSessionManager;
/**
 *  用于upload，download等方法
 */
@property (nonatomic, strong, readonly) AFURLSessionManager *urlSessionManager;

/**
 *  返回YPHttpUtil单例
 */
+ (YPHttpUtil *)shared;

- (id)initWithBaseURL:(NSURL *)URL;



/**
 *  POST请求
 *
 *  @param URLString    如果设置了baseURL，可以只传入path
 *  @param params       POST参数
 *  @param block        设置FormData
 *  @param controller   关联的UIViewController，传入此参数后，如果请求错误，会自动关闭等待框，并且显示相应提示
 *  @param successBlock 请求成功的回调
 *  @param errorBlock   请求失败的回调
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                        params:(NSDictionary *)params
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))bodyBlock
                      progress:(void (^)(NSProgress *))uploadProgress
                    controller:(UIViewController *)controller
                       success:(AFHttpRequestSuccessBlock)successBlock
                         error:(AFHttpRequestErrorBlock)errorBlock;
// 同上
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                          params:(NSDictionary *)params
                      controller:(UIViewController *)controller
                         success:(AFHttpRequestSuccessBlock)successBlock
                           error:(AFHttpRequestErrorBlock)errorBlock;
// 同上
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                          params:(NSDictionary *)params
                      controller:(UIViewController *)controller
                         success:(AFHttpRequestSuccessBlock)successBlock;

// 同上
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                         params:(NSDictionary *)params
                     controller:(UIViewController *)controller
                        success:(AFHttpRequestSuccessBlock)successBlock
                          error:(AFHttpRequestErrorBlock)errorBlock;
// 同上
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                         params:(NSDictionary *)params
                     controller:(UIViewController *)controller
                        success:(AFHttpRequestSuccessBlock)successBlock;

/**
 *  下载一个文件
 *
 *  @param URLString         如果设置了baseURL，可以只传入path
 *  @param destination       设置目标路径
 *  @param progressBlock     下载进度的回调
 *  @param completionHandler 下载成功的回调
 */
- (void)download:(NSString *)URLString
     destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
        progress:(AFHttpRequestProgressBlock)progressBlock
completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

/**
 *  上传一个问题件
 *
 *  @param URLString         如果设置了baseURL，可以只传入path
 *  @param params            附加参数
 *  @param bodyBlock         设置FormData
 *  @param progressBlock     上传进度的回调
 *  @param completionHandler 上传成功的回调
 */
/*
- (void)upload:(NSString *)URLString
        params:(NSDictionary *)params
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))bodyBlock
      progress:(AFHttpRequestProgressBlock)progressBlock
completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler; 
 */

+ (void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block;

/**
 *
 *
 *  @param params 
 *
 *  @return
 */
- (NSMutableDictionary *)requestParams:(NSDictionary *)params;

/**
 *  请求的statusCode等于200时，执行此方法。有时候服务器会返回一些错误信息，可在此方法进行处理
 *
 *  @param operation    AFHTTPRequestOperation
 *  @param successData  成功数据
 *  @param controller
 *  @param successBlock 请求成功的回调
 *  @param errorBlock   出现错误的回调
 */
- (void)operationSuccess:(NSURLSessionDataTask *)task
             successData:(id)successData
              controller:(UIViewController *)controller
            successBlock:(AFHttpRequestSuccessBlock)successBlock
              errorBlock:(AFHttpRequestErrorBlock)errorBlock;
/**
 *  请求的statusCode不等于200时，执行此方法。
 *
 *  @param operation  AFHTTPRequestOperation
 *  @param errorData  错误数据
 *  @param controller
 *  @param errorBlock 错误的回调
 */
- (void)operationError:(NSURLSessionDataTask *)task
             errorData:(id)errorData
            controller:(UIViewController *)controller
            errorBlock:(AFHttpRequestErrorBlock)errorBlock;

/**
 *  通过此方法可以获得一条错误信息
 *
 *  @param errorData 请求结果
 *
 *  @return 错误信息
 */
- (NSString *)getErrorMessage:(id)errorData;
@end

@interface NSURLSessionTask (YPKit)
//@property (nonatomic, strong) NSProgress *progress;
@property (nonatomic, strong) AFHttpRequestProgressBlock progressBlock;
@end
