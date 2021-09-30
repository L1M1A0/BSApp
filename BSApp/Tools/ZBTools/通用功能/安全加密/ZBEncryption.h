//
//  ZBEncryption.h
//  BSApp
//
//  Created by lizb on 2017/6/10.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

//---加密：常用加密方法


#import <Foundation/Foundation.h>

@interface ZBEncryption : NSObject

/**
 生成SHA1 加密数据
 
 @param string 原数据
 @return 安全哈希算法 Secure Hash Algorithm
 */
+ (NSString *)SHA1:(NSString *)string;

/**
 生成系统当前的时间戳
 
 @return (*1000代表毫秒级)
 */
+ (NSString *)timeStamp;

/**
 生成UUID
 
 @return 全球唯一标识符 Universally Unique Identifier
 */
+ (NSString *)UUID;

/**
 生成MD5数据
 
 @param string 原数据
 @return Message-Digest Algorithm 5（信息-摘要算法5）
 */
+ (NSString *)MD5:(NSString *)string;
+ (NSString *)MD5:(NSString *)string bitLength:(NSInteger)bitLength;

/**
 生成token
 
 @param string 源数据
 @return token
 */
+ (NSString *)token:(NSString *)string;


/** 转换成Base64编码授权字符串 */
+ (NSString *)base64Encoded:(NSString *)authString;

/** 将Base64 类型字符转换成普通字符 */
+ (NSString *)base64Decoded:(NSString*)base64String;


@end
