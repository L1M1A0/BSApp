//
//  ZBEncryption.m
//  BSApp
//
//  Created by 李振彪 on 2017/6/10.
//  Copyright © 2017年 BaoThink. All rights reserved.
//



#import "ZBEncryption.h"
#import <CommonCrypto/CommonDigest.h>


@implementation ZBEncryption

/**
 生成SHA1 加密数据

 @param string 原数据
 @return 安全哈希算法 Secure Hash Algorithm
 */
+ (NSString *)SHA1:(NSString *)string
{
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes,(unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}



/**
 生成系统当前的时间戳
 @return (*1000代表毫秒级)
 */
+ (NSString *)timeStamp
{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%llu",recordTime];
}

/**
 生成UUID

 @return 全球唯一标识符 Universally Unique Identifier
 */
+ (NSString *)UUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    
    return uuidString ;
    
}



/**
 生成MD5数据

 @param string 原数据
 @return Message-Digest Algorithm 5（信息-摘要算法5）
 */
+ (NSString *)MD5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    //CC_MD5_DIGEST_LENGTH=16
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,(unsigned int)strlen(cStr), result);
    
    // x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
    NSString *md5Str = [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15] ] lowercaseString];
    return md5Str;
}



////32位MD5加密方式
//- (NSString *)getMd5_32Bit_String:(NSString *)srcString{
//    const char *cStr = [srcString UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    // CC_MD5( cStr, strlen(cStr), digest ); 这里的用法明显是错误的，但是不知道为什么依然可以在网络上得以流传。当srcString中包含空字符（\0）时
//    CC_MD5( cStr, (unsigned int)self.length, digest );//self是字符串
//    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [result appendFormat:@"%02x", digest[i]];
//
//    return result;
//}



/**
 生成token

 @param string 源数据
 @return token
 */
+ (NSString *)token:(NSString *)string
{
    
//    NSString *result = @"";
//    result = [result stringByAppendingString:string];
    NSString *result = [[ZBEncryption MD5:string] lowercaseString];
    return result;
}




/** 将Base64 类型字符转换成普通字符 */
+ (NSString *)base64Decoded:(NSString*)base64String {
    //解码成 data
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:0];
    //解码成 string
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

/** 转换成Base64编码授权字符串 */
+ (NSString *)base64Encoded:(NSString *)authString {
    //将字符串转换成二进制数局
    NSData *data = [authString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [data base64EncodedStringWithOptions:0];
    
    return str;
}

@end
