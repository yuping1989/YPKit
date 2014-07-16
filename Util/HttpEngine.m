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
    NSLog(@"HttpEngine url-->%@", urlString);
    NSLog(@"HttpEngine method-->%@", method);
    NSLog(@"HttpEngine params-->%@", [params description]);
    MKNetworkEngine *engine = [HttpEngine shared].mkNetworkEngine;
    MKNetworkOperation *op = [engine operationWithURLString:urlString params:params httpMethod:method];
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
    [engine enqueueOperation:op forceReload:YES];
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
    NSLog(@"filrPath-->%@", filePath);
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
    
    if (controller && [controller isViewInBackground]) {
        return;
    }
    int status = operation.HTTPStatusCode;
    NSLog(@"request code--->%d", status);
//    NSLog(@"response string--->%@", operation.responseString);
    NSError *error;
    NSDictionary *responseDict;
    if (operation.responseData) {
        responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableLeaves error:&error];
    }
    if (responseDict == nil) {
        responseDict = @{@"responseString": operation.responseString};
    }
    NSLog(@"controller--->%@", controller.class.description);
    NSLog(@"result dict--->%@", responseDict.description);
    
    if (status == 200) {
        [self operationSuccessed:responseDict
                      controller:controller
                successedHandler:successed
                   failedHandler:failed];
    } else {
        [self operationFailed:responseDict controller:controller failedHandler:failed];
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

- (void)operationSuccessed:(NSDictionary *)responseData
                controller:(UIViewController *)controller
          successedHandler:(ApiRequestSuccessedBlock)successed
             failedHandler:(ApiRequestFailedBlock)failed
{
    if (successed) {
        successed(responseData);
    }
}

- (void)operationFailed:(NSDictionary *)responseData
             controller:(UIViewController *)controller
          failedHandler:(ApiRequestFailedBlock)failed
{
    if (failed && failed(responseData)) return;
    NSString *message = [self getErrorMessage:responseData];
    [self hideProgressAndShowErrorMsg:message controller:controller];
}

- (void)hideProgressAndShowErrorMsg:(NSString *)message controller:(UIViewController *)controller
{
    if (controller) {
        [controller hideProgress];
        if (message) {
            NSLog(@"message length-->%d", [message charLength]);
            if ([message charLength] < 30) {
                [NativeUtil showToast:message];
            } else {
                [UIAlertView showAlertWithTitle:message];
            }
        } else {
            [NativeUtil showToast:@"网络连接失败，请重试"];
        }
    } else {
        if (message) {
            [UIAlertView showAlertWithTitle:message];
        } else {
            [UIAlertView showAlertWithTitle:@"网络连接失败，请重试"];
        }
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
