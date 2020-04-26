//
//  NSData+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/6/15.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (YPKit)

- (nullable NSString *)yp_md5String;
- (nullable NSString *)yp_base64EncodedString;
+ (nullable NSData *)yp_dataWithBase64EncodedString:(NSString *)base64EncodedString;
- (nullable id)yp_jsonObject;

@end

NS_ASSUME_NONNULL_END
