//
//  YPHttpUtil.m
//  YPKit
//
//  Created by 喻平 on 15/10/27.
//  Copyright © 2015年 YPKit. All rights reserved.
//

#import "YPHttpUtil.h"

@interface YPHttpUtil ()
@property (nonatomic, strong, readwrite) NSURL *baseURL;
@property (nonatomic, strong, readwrite) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, strong, readwrite) AFURLSessionManager *urlSessionManager;
@end
@implementation YPHttpUtil
- (instancetype)initWithBaseURL:(NSURL *)URL
{
    self = [super init];
    if (self) {
        self.baseURL = URL;
        self.httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
    }
    return self;
}

+ (instancetype)shared
{
    static YPHttpUtil *httpUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpUtil = [[self alloc] initWithBaseURL:nil];
    });
    return httpUtil;
}

- (AFURLSessionManager *)sessionManager {
    if (!_urlSessionManager) {
        self.urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _urlSessionManager;
}

- (NSMutableDictionary *)requestParams:(NSDictionary *)params {
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionaryWithDictionary:params];
    return requestParams;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                          params:(NSDictionary *)params
                      controller:(UIViewController *)controller
                         success:(AFHttpRequestSuccessBlock)successBlock
                           error:(AFHttpRequestErrorBlock)errorBlock;
{
    NSLog(@"post url-->%@", [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]);
    return [self.httpSessionManager POST:URLString
                              parameters:[self requestParams:params]
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     [self processRequestOperation:task
                                                    responseObject:responseObject
                                                        controller:controller
                                                      successBlock:successBlock
                                                        errorBlock:errorBlock];
                                 }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     [self processRequestOperation:task
                                                    responseObject:nil
                                                        controller:controller
                                                      successBlock:successBlock
                                                        errorBlock:errorBlock];
                                 }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                          params:(NSDictionary *)params
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))bodyBlock
                        progress:(AFHttpRequestProgressBlock)progressBlock
                      controller:(UIViewController *)controller
                         success:(AFHttpRequestSuccessBlock)successBlock
                           error:(AFHttpRequestErrorBlock)errorBlock {
    NSLog(@"post url-->%@", [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]);
    return [self.httpSessionManager POST:URLString
                              parameters:[self requestParams:params]
               constructingBodyWithBlock:bodyBlock
                                progress:progressBlock
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     [self processRequestOperation:task
                                                    responseObject:responseObject
                                                        controller:controller
                                                      successBlock:successBlock
                                                        errorBlock:errorBlock];
                                 }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     [self processRequestOperation:task
                                                    responseObject:nil
                                                        controller:controller
                                                      successBlock:successBlock
                                                        errorBlock:errorBlock];
                                 }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                          params:(NSDictionary *)params
                      controller:(UIViewController *)controller
                         success:(AFHttpRequestSuccessBlock)successBlock {
    
    return [self POST:URLString
               params:params
           controller:controller
              success:successBlock
                error:nil];
}


- (NSURLSessionDataTask *)GET:(NSString *)URLString
                         params:(NSDictionary *)params
                     controller:(UIViewController *)controller
                        success:(AFHttpRequestSuccessBlock)successBlock
                          error:(AFHttpRequestErrorBlock)errorBlock {
    NSLog(@"get url-->%@", [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]);
    return [self.httpSessionManager GET:URLString
                             parameters:[self requestParams:params]
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    [self processRequestOperation:task
                                                   responseObject:responseObject
                                                       controller:controller
                                                     successBlock:successBlock
                                                       errorBlock:errorBlock];
                                }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [self processRequestOperation:task
                                                   responseObject:nil
                                                       controller:controller
                                                     successBlock:successBlock
                                                       errorBlock:errorBlock];
                                }];
}

- (NSURLSessionDataTask *)GET:(NSString *)path
                         params:(NSDictionary *)params
                     controller:(UIViewController *)controller
                        success:(AFHttpRequestSuccessBlock)successBlock
{
    return [self GET:path
              params:params
          controller:controller
             success:successBlock
               error:nil];
}

- (void)download:(NSString *)URLString
     destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
        progress:(AFHttpRequestProgressBlock)progressBlock
completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    NSURL *relativeURL = [NSURL URLWithString:URLString relativeToURL:self.baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:relativeURL];
    NSURLSessionDownloadTask *downloadTask = [self.urlSessionManager downloadTaskWithRequest:request
                                                                                    progress:progressBlock
                                                                                 destination:destination
                                                                           completionHandler:completionHandler];
    [downloadTask resume];
 
}
/*
- (void)upload:(NSString *)URLString
        params:(NSDictionary *)params
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))bodyBlock
      progress:(AFHttpRequestProgressBlock)progressBlock
completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler {

    NSString *relativeURLString = [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
    NSLog(@"upload url-->%@", relativeURLString);
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:relativeURLString parameters:[self requestParams:params] constructingBodyWithBlock:bodyBlock error:nil];
    
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [self.urlSessionManager uploadTaskWithStreamedRequest:request
                                                                                   progress:&progress
                                                                          completionHandler:completionHandler];
    
    uploadTask.progressBlock = progressBlock;
    [progress addObserver:uploadTask
               forKeyPath:NSStringFromSelector(@selector(fractionCompleted))
                  options:NSKeyValueObservingOptionInitial
                  context:NULL];
    [uploadTask resume];
}
 */


- (void)processRequestOperation:(NSURLSessionDataTask *)task
                 responseObject:(id)responseObject
                     controller:(UIViewController *)controller
                   successBlock:(AFHttpRequestSuccessBlock)successBlock
                     errorBlock:(AFHttpRequestErrorBlock)errorBlock;
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSLog(@"request code--->%ld", response.statusCode);
    NSLog(@"url--->%@", response.URL.absoluteString);
    NSLog(@"controller--->%@", controller.class.description);
    NSLog(@"response-->%@ %@", [[responseObject class] description], responseObject);
    if (response.statusCode == 200) {
        [self operationSuccess:task
                   successData:responseObject
                    controller:controller
                  successBlock:successBlock
                    errorBlock:errorBlock];
    } else {
        [self operationError:task
                   errorData:responseObject
                  controller:controller
                  errorBlock:errorBlock];
    }
}



- (void)operationSuccess:(NSURLSessionDataTask *)task
             successData:(id)successData
              controller:(UIViewController *)controller
            successBlock:(AFHttpRequestSuccessBlock)successBlock
              errorBlock:(AFHttpRequestErrorBlock)errorBlock
{
    if (successBlock) {
        successBlock(successData, task);
    }
}

- (void)operationError:(NSURLSessionDataTask *)task
             errorData:(id)errorData
            controller:(UIViewController *)controller
            errorBlock:(AFHttpRequestErrorBlock)errorBlock
{
    if (errorBlock && errorBlock(errorData, task))
        return;
    NSString *message = [self getErrorMessage:errorData];
    [self hideProgressAndShowErrorMsg:message controller:controller];
}

- (NSString *)getErrorMessage:(id)errorData
{
    return nil;
}

- (void)hideProgressAndShowErrorMsg:(NSString *)message controller:(UIViewController *)controller
{
    if (controller) {
        [controller hideProgress];
    }
    if (message && ![message isKindOfClass:[NSNull class]]) {
        NSLog(@"message length-->%ld", [message charLength]);
        if ([message charLength] < 30) {
            [YPNativeUtil showToastInAppWindow:message];
        } else {
            [UIAlertView showAlertWithTitle:message];
        }
    } else {
        [YPNativeUtil showToastInAppWindow:@"网络请求错误，请稍后再试"];
    }
}

+ (void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:block];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end
