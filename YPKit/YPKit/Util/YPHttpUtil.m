//
//  YPHttpUtil.m
//  YPKit
//
//  Created by 喻平 on 15/10/27.
//  Copyright © 2015年 YPKit. All rights reserved.
//

#import "YPHttpUtil.h"

@interface YPHttpUtil ()
@property (nonatomic, strong, readwrite) AFHTTPRequestOperationManager *operationManager;
@property (nonatomic, strong, readwrite) AFURLSessionManager *sessionManager;
@end
@implementation YPHttpUtil
- (id)initWithBaseURL:(NSURL *)URL
{
    self = [super init];
    if (self) {
        self.baseURL = URL;
        self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:URL];
    }
    return self;
}

+ (YPHttpUtil *)shared
{
    static YPHttpUtil *httpUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpUtil = [[YPHttpUtil alloc] initWithBaseURL:nil];
    });
    return httpUtil;
}

- (void)setBaseURL:(NSURL *)baseURL {
    _baseURL = baseURL;
    self.operationManager = nil;
    self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
}

- (AFURLSessionManager *)sessionManager {
    if (!_sessionManager) {
        self.sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _sessionManager;
}

- (NSMutableDictionary *)requestParams:(NSDictionary *)params {
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionaryWithDictionary:params];
    return requestParams;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                          params:(NSDictionary *)params
                      controller:(UIViewController *)controller
                         success:(AFHttpRequestSuccessBlock)successBlock
                           error:(AFHttpRequestErrorBlock)errorBlock;
{
    NSLog(@"post url-->%@", [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]);
    return [self.operationManager POST:URLString
                            parameters:[self requestParams:params]
                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   [self processRequestOperation:operation
                                                      controller:controller
                                                    successBlock:successBlock
                                                      errorBlock:errorBlock];
                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   [self processRequestOperation:operation
                                                      controller:controller
                                                    successBlock:successBlock
                                                      errorBlock:errorBlock];
                               }];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                          params:(NSDictionary *)params
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))bodyBlock
                      controller:(UIViewController *)controller
                         success:(AFHttpRequestSuccessBlock)successBlock
                           error:(AFHttpRequestErrorBlock)errorBlock {
    return [self.operationManager POST:URLString
                            parameters:[self requestParams:params]
             constructingBodyWithBlock:bodyBlock
                               success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                                   [self processRequestOperation:operation
                                                      controller:controller
                                                    successBlock:successBlock
                                                      errorBlock:errorBlock];
                               }
                               failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                                   [self processRequestOperation:operation
                                                      controller:controller
                                                    successBlock:successBlock
                                                      errorBlock:errorBlock];
                               }];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                          params:(NSDictionary *)params
                      controller:(UIViewController *)controller
                         success:(AFHttpRequestSuccessBlock)successBlock {
    
    return [self POST:URLString
               params:params
           controller:controller
              success:successBlock
                error:nil];
}


- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                         params:(NSDictionary *)params
                     controller:(UIViewController *)controller
                        success:(AFHttpRequestSuccessBlock)successBlock
                          error:(AFHttpRequestErrorBlock)errorBlock {
    NSLog(@"get url-->%@", [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]);
    return [self.operationManager GET:URLString
                           parameters:[self requestParams:params]
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  [self processRequestOperation:operation
                                                     controller:controller
                                                   successBlock:successBlock
                                                     errorBlock:errorBlock];
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  [self processRequestOperation:operation
                                                     controller:controller
                                                   successBlock:successBlock
                                                     errorBlock:errorBlock];
                              }];
}

- (AFHTTPRequestOperation *)GET:(NSString *)path
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
    NSLog(@"download url-->%@", relativeURL.absoluteString);
    NSURLRequest *request = [NSURLRequest requestWithURL:relativeURL];
    NSProgress *progress = nil;
    NSURLSessionDownloadTask *downloadTask = [self.sessionManager downloadTaskWithRequest:request
                                                                                 progress:&progress
                                                                              destination:destination
                                                                        completionHandler:completionHandler];
    downloadTask.progressBlock = progressBlock;
    [progress addObserver:downloadTask
               forKeyPath:NSStringFromSelector(@selector(fractionCompleted))
                  options:NSKeyValueObservingOptionInitial
                  context:NULL];
    [downloadTask resume];
}

- (void)upload:(NSString *)URLString
        params:(NSDictionary *)params
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))bodyBlock
      progress:(AFHttpRequestProgressBlock)progressBlock
completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler {
    
    NSString *relativeURLString = [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
    NSLog(@"upload url-->%@", relativeURLString);
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:relativeURLString parameters:[self requestParams:params] constructingBodyWithBlock:bodyBlock error:nil];
    
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [self.sessionManager uploadTaskWithStreamedRequest:request
                                                                                   progress:&progress
                                                                          completionHandler:completionHandler];
    
    uploadTask.progressBlock = progressBlock;
    [progress addObserver:uploadTask
               forKeyPath:NSStringFromSelector(@selector(fractionCompleted))
                  options:NSKeyValueObservingOptionInitial
                  context:NULL];
    [uploadTask resume];
}


- (void)processRequestOperation:(AFHTTPRequestOperation *)operation
                     controller:(UIViewController *)controller
                   successBlock:(AFHttpRequestSuccessBlock)successBlock
                     errorBlock:(AFHttpRequestErrorBlock)errorBlock;
{
    NSInteger status = operation.response.statusCode;
    NSLog(@"request code--->%ld", status);
    NSError *error;
    id responseData;
    if (operation.responseData) {
        responseData = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                       options:NSJSONReadingMutableLeaves
                                                         error:&error];
    }
//    if (responseData == nil && operation.responseString != nil) {
//        responseData = @{@"responseString": operation.responseString};
//    }
    NSLog(@"controller--->%@", controller.class.description);
    if (responseData) {
        NSLog(@"result data--->%@", [responseData description]);
    } else {
        NSLog(@"result string--->%@", operation.responseString);
    }
    
    if (status == 200) {
        [self operationSuccess:operation
                   successData:responseData
                    controller:controller
                  successBlock:successBlock
                    errorBlock:errorBlock];
    } else {
        [self operationError:operation
                   errorData:responseData
                  controller:controller
                  errorBlock:errorBlock];
    }
}



- (void)operationSuccess:(AFHTTPRequestOperation *)operation
             successData:(id)successData
              controller:(UIViewController *)controller
            successBlock:(AFHttpRequestSuccessBlock)successBlock
              errorBlock:(AFHttpRequestErrorBlock)errorBlock
{
    if (successBlock) {
        successBlock(successData, operation);
    }
}

- (void)operationError:(AFHTTPRequestOperation *)operation
             errorData:(id)errorData
            controller:(UIViewController *)controller
            errorBlock:(AFHttpRequestErrorBlock)errorBlock
{
    if (errorBlock && errorBlock(errorData, operation))
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

@implementation NSURLSessionTask (YPKit)

- (void)setProgressBlock:(AFHttpRequestProgressBlock)progressBlock {
    objc_setAssociatedObject(self, @selector(progressBlock), progressBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AFHttpRequestProgressBlock)progressBlock{
    return objc_getAssociatedObject(self, @selector(progressBlock));
}

//- (void)setProgress:(NSProgress *)progress {
//    objc_setAssociatedObject(self, kProgress, progress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (NSProgress *)progress{
//    return objc_getAssociatedObject(self, kProgress);
//}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress *)object;
        NSLog(@"Progress is %f", progress.fractionCompleted);
        if (self.progressBlock) {
            self.progressBlock(progress);
        }
    }
}

@end
