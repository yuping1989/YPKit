//
//  HttpEngine.m
//  iCarsClub
//
//  Created by 喻平 on 13-11-13.
//  Copyright (c) 2013年 iCarsclub. All rights reserved.
//

#import "HttpEngine.h"
@implementation HttpEngine
- (id)init
{
    self = [super init];
    if (self) {
        self.mkNetworkEngine = [[MKNetworkEngine alloc] initWithHostName:nil];
        self.reachability = [Reachability reachabilityWithHostname:@"www.apple.com"];
        [_reachability startNotifier];
        
    }
    return self;
}

- (BOOL)isReachable
{
    return ([self.reachability currentReachabilityStatus] != NotReachable);
}

+ (HttpEngine *)shared
{
    static HttpEngine *httpEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpEngine = [[HttpEngine alloc] init];
    });
    return httpEngine;
}

- (void)startWithPath:(NSString *)path
               params:(NSMutableDictionary *)params
           httpMethod:(NSString *)method
           controller:(UIViewController *)controller
            successed:(ApiRequestSuccessedBlock)successed
{
    [self startWithPath:path
                 params:params
             httpMethod:method
             controller:controller
              successed:successed
                 failed:nil];
}

- (void)startWithPath:(NSString *)path
               params:(NSMutableDictionary *)params
           httpMethod:(NSString *)method
           controller:(UIViewController *)controller
            successed:(ApiRequestSuccessedBlock)successed
               failed:(ApiRequestFailedBlock)failed
{
    [self startWithURLString:[self requestUrlWithPath:path]
                      params:params
                  httpMethod:method
                  controller:controller
                   successed:successed
                      failed:failed];
}

- (void)startWithURLString:(NSString *)urlString
                    params:(NSMutableDictionary *)params
                httpMethod:(NSString *)method
                controller:(UIViewController *)controller
                 successed:(ApiRequestSuccessedBlock)successed
                    failed:(ApiRequestFailedBlock)failed
{
    
    NSLog(@"HttpEngine params-->%@", [params description]);
    MKNetworkOperation *op = [self.mkNetworkEngine operationWithURLString:urlString
                                                                   params:params
                                                               httpMethod:method];
    [self startWithOperation:op
                  controller:controller
                   successed:successed
                      failed:failed];
}

- (void)startWithOperation:(MKNetworkOperation *)operation
                controller:(UIViewController *)controller
                 successed:(ApiRequestSuccessedBlock)successed
                    failed:(ApiRequestFailedBlock)failed
{
    NSLog(@"HttpEngine url-->%@", operation.url);
    NSLog(@"HttpEngine method-->%@", operation.HTTPMethod);
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [self processRequestOperation:completedOperation
                           controller:controller
                     successedHandler:successed
                        failedHandler:failed];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self processRequestOperation:completedOperation
                           controller:controller
                     successedHandler:successed
                        failedHandler:failed];
    }];
    [self.mkNetworkEngine enqueueOperation:operation forceReload:YES];
}

- (void)startApiRequest:(ApiRequest *)request
             controller:(UIViewController *)controller
              successed:(ApiRequestSuccessedBlock)successed
                 failed:(ApiRequestFailedBlock)failed
{
    NSLog(@"HttpEngine url-->%@", request.urlString);
    NSLog(@"HttpEngine method-->%@", request.method);
    NSLog(@"HttpEngine params-->%@", request.params);
    MKNetworkOperation *op = [self.mkNetworkEngine operationWithURLString:request.urlString
                                                                   params:request.params
                                                               httpMethod:request.method];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [self processRequestOperation:completedOperation
                           controller:controller
                     successedHandler:successed
                        failedHandler:failed];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self processRequestOperation:completedOperation
                           controller:controller
                     successedHandler:successed
                        failedHandler:failed];
    }];
    
    if (request.uploadFileDatas) {
        for (UploadFile *file in request.uploadFileDatas) {
            NSLog(@"key-->%@  data length-->%d fileName-->%@  type-->%@", file.key, file.data.length, file.fileName, file.mimeType);
            [op addData:file.data
                 forKey:file.key
               mimeType:file.mimeType ? file.mimeType : @"application/octet-stream"
               fileName:file.fileName ? file.fileName : @"file"];
        }
    }
    if (request.uploadFilePaths) {
        for (UploadFile *file in request.uploadFilePaths) {
            NSLog(@"key-->%@  path-->%@ type-->%@", file.key, file.filePath, file.mimeType);
            [op addFile:file.filePath
                 forKey:file.key
               mimeType:file.mimeType ? file.mimeType : @"application/octet-stream"];
        }
    }
    
    if (request.uploadProgressBlock) {
        [op onUploadProgressChanged:request.uploadProgressBlock];
    }
    if (request.downloadProgressBlock) {
        [op onDownloadProgressChanged:request.downloadProgressBlock];
    }
    [self.mkNetworkEngine enqueueOperation:op forceReload:YES];
}

- (void)downloadFileWithUrlString:(NSString *)urlString
                     toFileAtPath:(NSString *)filePath
                  progressChanged:(MKNKProgressBlock)progressChanged
                       controller:(UIViewController *)controller
                        successed:(UploadDownloadFinishedBlock)successed
                           failed:(UploadDownloadFinishedBlock)failed
{
    NSLog(@"urlString-->%@", urlString);
    NSLog(@"filePath-->%@", filePath);
    MKNetworkOperation *op = [self.mkNetworkEngine operationWithURLString:urlString];
    [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath append:NO]];
    if (progressChanged) {
        [op onDownloadProgressChanged:progressChanged];
    }
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (successed) {
            successed(completedOperation);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (failed) {
            failed(completedOperation);
        }
    }];
    [self.mkNetworkEngine enqueueOperation:op forceReload:YES];
}

- (void)uploadFileWithUrlString:(NSString *)urlString
                         params:(NSMutableDictionary *)params
                     uploadData:(NSData *)data
                progressChanged:(MKNKProgressBlock)progressChanged
                     controller:(UIViewController *)controller
                      successed:(ApiRequestSuccessedBlock)successed
                         failed:(ApiRequestFailedBlock)failed
{
    NSLog(@"urlString-->%@", urlString);
    NSLog(@"data length-->%d", data.length);
    MKNetworkOperation *op = [self.mkNetworkEngine operationWithURLString:urlString params:params httpMethod:HttpMethodPost];
    [op setUploadStream:[NSInputStream inputStreamWithData:data]];
    if (progressChanged) {
        [op onUploadProgressChanged:progressChanged];
    }
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [self processRequestOperation:completedOperation
                           controller:controller
                     successedHandler:successed
                        failedHandler:failed];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self processRequestOperation:completedOperation
                           controller:controller
                     successedHandler:successed
                        failedHandler:failed];
    }];
    [self.mkNetworkEngine enqueueOperation:op forceReload:YES];
}

- (void)processRequestOperation:(MKNetworkOperation *)operation
                     controller:(UIViewController *)controller
               successedHandler:(ApiRequestSuccessedBlock)successed
                  failedHandler:(ApiRequestFailedBlock)failed;
{
    NSInteger status = operation.HTTPStatusCode;
    NSLog(@"request code--->%ld", status);
    NSError *error;
    id responseData;
    if (operation.responseData) {
        responseData = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableLeaves error:&error];
    }
    if (responseData == nil && operation.responseString != nil) {
        responseData = @{@"responseString": operation.responseString};
    }
    NSLog(@"controller--->%@", controller.class.description);
    NSLog(@"result dict--->%@", [responseData description]);
    
    if (status == 200) {
        [self operationSuccessed:operation
                    responseData:responseData
                      controller:controller
                successedHandler:successed
                   failedHandler:failed];
    } else {
        [self operationFailed:operation
                 responseData:responseData
                   controller:controller
                failedHandler:failed];
    }
}

- (NSString *)requestUrlWithPath:(NSString *)path
{
    return [NSString stringWithFormat:@"%@/%@", _hostName, path];
}

- (NSString *)getErrorMessage:(NSDictionary *)responseData
{
    return nil;
}

- (void)operationSuccessed:(MKNetworkOperation *)operation
              responseData:(id)responseData
                controller:(UIViewController *)controller
          successedHandler:(ApiRequestSuccessedBlock)successed
             failedHandler:(ApiRequestFailedBlock)failed
{
    if (successed) {
        successed(responseData, operation);
    }
}

- (void)operationFailed:(MKNetworkOperation *)operation
           responseData:(id)responseData
             controller:(UIViewController *)controller
          failedHandler:(ApiRequestFailedBlock)failed
{
    if (failed && failed(responseData, operation)) return;
    NSString *message = [self getErrorMessage:responseData];
    [self hideProgressAndShowErrorMsg:message controller:controller];
}

- (void)hideProgressAndShowErrorMsg:(NSString *)message controller:(UIViewController *)controller
{
    if (controller) {
        [controller hideProgress];
    }
    if (message) {
        NSLog(@"message length-->%d", [message charLength]);
        if ([message charLength] < 30) {
            [NativeUtil showToast:message];
        } else {
            [UIAlertView showAlertWithTitle:message];
        }
    } else {
        [NativeUtil showToast:@"网络连接不可用，请重试"];
    }
}

- (void)reachabilityChanged:(NSNotification *)note
{
    switch ([_reachability currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            break;
    }
}

@end

@implementation ApiRequest
- (id)initWithUrlString:(NSString *)urlString params:(NSMutableDictionary *)params method:(NSString *)method
{
    self = [super init];
    if (self) {
        self.urlString = urlString;
        self.params = params;
        self.method = method;
    }
    return self;
}
@end

@implementation UploadFile
- (id)initWithKey:(NSString *)key
             data:(NSData *)data
         mimeType:(NSString *)mimeType
         fileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
        self.key = key;
        self.data = data;
        self.mimeType = mimeType;
        self.fileName = fileName;
    }
    return self;
}
- (id)initWithKey:(NSString *)key
         filePath:(NSString *)filePath
         mimeType:(NSString *)mimeType
{
    self = [super init];
    if (self) {
        self.key = key;
        self.filePath = filePath;
        self.mimeType = mimeType;
    }
    return self;
}
@end
