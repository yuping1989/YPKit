//
//  UncaughtExceptionHandler.m
//  NBD2
//
//  Created by 喻平 on 16/5/5.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import "YPUncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

@implementation YPUncaughtExceptionHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldWriteExceptionDataToDisk = YES;
        _shouldShowExceptionAlert = YES;
    }
    return self;
}

+ (YPUncaughtExceptionHandler *)sharedHandler {
    static dispatch_once_t onceToken;
    static YPUncaughtExceptionHandler *handler;
    dispatch_once(&onceToken, ^{
        handler = [[YPUncaughtExceptionHandler alloc] init];
    });
    return handler;
}

+ (NSArray *)backtrace {
    void *callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = UncaughtExceptionHandlerSkipAddressCount;
         i < UncaughtExceptionHandlerSkipAddressCount + UncaughtExceptionHandlerReportAddressCount;
         i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtrace;
}

+ (NSString *)exceptionFilesDirectory {
    return [[YPFileUtil applicationDocumentsDirectory] stringByAppendingPathComponent:@"Exceptions"];
}

- (void)writeExceptionDataToDisk:(NSException *)exception {
    NSString *callStack = [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSString *exceptionDesc = [NSString stringWithFormat:@"=============异常崩溃报告=============\nApp : %@\nVersion : %@(%@)\nDevice : %@\nOS Version : %@ %@\nName : %@\nReason : %@\nCallStack : %@",
                               [UIApplication appBundleDisplayName],
                               [UIApplication appVersionName],
                               [UIApplication appShortVersionString],
                               [UIDevice currentDevice].machineModelName,
                               [UIDevice currentDevice].systemName,
                               [UIDevice currentDevice].systemVersion,
                               name,
                               reason,
                               callStack];
    NSLog(@"exceptionDesc-->%@", exceptionDesc);
    
    NSString *directoryPath = [YPUncaughtExceptionHandler exceptionFilesDirectory];
    [YPFileUtil createDirectoryAtPath:directoryPath];
    NSString *fileName = [YPDateUtil stringWithDate:[NSDate date] format:yyyyMMddHHmmss];
    NSString *exptionPath = [directoryPath stringByAppendingPathComponent:fileName];
    [exceptionDesc writeToFile:exptionPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)handleException:(NSException *)exception {
    if (self.shouldWriteExceptionDataToDisk) {
        [self writeExceptionDataToDisk:exception];
    }
    if (self.exceptionHandler) {
        self.exceptionHandler(exception);
    }
    
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"如果点击继续，程序有可能会出现其他的问题，建议您点击退出按钮并重新打开\n\n"
                                                                     @"异常原因如下:\n%@\n%@", nil),
                         [exception reason],
                         [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]];
    __block BOOL dismissed;
    if (self.shouldShowExceptionAlert) {
        [UIAlertView showAlertWithTitle:NSLocalizedString(@"抱歉，程序出现了异常", nil)
                                message:message
                      cancelButtonTitle:NSLocalizedString(@"退出", nil)
                      otherButtonTitles:@[NSLocalizedString(@"继续", nil)]
                             completion:^(NSInteger buttonIndex) {
                                 if (buttonIndex == 0) {
                                     dismissed = YES;
                                 } else if (buttonIndex==1) {
                                     NSLog(@"用户点击继续");
                                 }
                             }];
        CFRunLoopRef runLoop = CFRunLoopGetCurrent();
        CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
        
        while (!dismissed) {
            for (NSString *mode in (__bridge NSArray *)allModes) {
                CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
            }
        }
        
        CFRelease(allModes);
        
        NSSetUncaughtExceptionHandler(NULL);
        signal(SIGABRT, SIG_DFL);
        signal(SIGILL, SIG_DFL);
        signal(SIGSEGV, SIG_DFL);
        signal(SIGFPE, SIG_DFL);
        signal(SIGBUS, SIG_DFL);
        signal(SIGPIPE, SIG_DFL);
        
        if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName]) {
            kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
        } else {
            [exception raise];
        }
    }
}

@end

void HandleException(NSException *exception) {
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum) {
        return;
    }
    NSLog(@"HandleException");
    NSArray *callStack = [YPUncaughtExceptionHandler backtrace];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];

    NSException *mException = [NSException exceptionWithName:[exception name] reason:[exception reason] userInfo:userInfo];
    [[YPUncaughtExceptionHandler sharedHandler] performSelectorOnMainThread:@selector(handleException:)
                                                                 withObject:mException
                                                              waitUntilDone:YES];
}

void SignalHandler(int signal) {
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum) {
        return;
    }
    NSLog(@"SignalHandler");
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal]
                                                                       forKey:UncaughtExceptionHandlerSignalKey];
    NSArray *callStack = [YPUncaughtExceptionHandler backtrace];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];

    NSException *exception = [NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
                                                     reason:[NSString stringWithFormat:NSLocalizedString(@"Signal %d was raised.", nil), signal]
                                                   userInfo:userInfo];
    [[YPUncaughtExceptionHandler sharedHandler] performSelectorOnMainThread:@selector(handleException:)
                                                                 withObject:exception
                                                              waitUntilDone:YES];
}

void YPInstallUncaughtExceptionHandler(BOOL shouldWriteExceptionDataToDisk,
                                       BOOL shouldShowExceptionAlert,
                                       void (^exceptionHandler)(NSException *exception)) {
    NSSetUncaughtExceptionHandler(&HandleException);
    signal(SIGABRT, SignalHandler);
    signal(SIGILL, SignalHandler);
    signal(SIGSEGV, SignalHandler);
    signal(SIGFPE, SignalHandler);
    signal(SIGBUS, SignalHandler);
    signal(SIGPIPE, SignalHandler);
    
    if (!shouldWriteExceptionDataToDisk) {
        [YPUncaughtExceptionHandler sharedHandler].shouldWriteExceptionDataToDisk = shouldWriteExceptionDataToDisk;
    }
    if (!shouldShowExceptionAlert) {
        [YPUncaughtExceptionHandler sharedHandler].shouldShowExceptionAlert = shouldShowExceptionAlert;
    }
    if (exceptionHandler) {
        [YPUncaughtExceptionHandler sharedHandler].exceptionHandler = exceptionHandler;
    }
}
