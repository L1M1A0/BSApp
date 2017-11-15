//
//  NSString+URLEncodeString.h
//  BROnlineLearning
//
//  Created by forr on 14-11-26.
//  Copyright (c) 2014年 Bori Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncodeString)

- (NSString *)URLEncodedString;
- (NSString*)URLDecodedString;

-(NSString *)urlReplaceWithString:(NSString *)urlStr;//替换url字符中{}

-(id)deleteLineFeedWithString:(NSString *)str;//解析数据时，去除换行、回车后字符转对象用

/** 字典转url参数 */
- (NSString *)urlParamsConversionFromDictionary:(NSDictionary *)params
                                          supplemental:(BOOL)supplemental;
/** url参数转 */
- (NSDictionary *)paramsConversionFromUrlParams:(NSString *)urlParams;

@end
