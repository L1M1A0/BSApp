//
//  ZBEncryptionRSA.h
//  BSApp
//
//  Created by lizb on 2017/6/10.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

//-------- RSA非对称加密
//参考：http://www.jianshu.com/p/74a796ec5038
//

#import <Foundation/Foundation.h>

@interface ZBEncryptionRSA : NSObject


/**
 根据RSA证书名字获取文件路径

 @param cerName RSA证书名字
 @return <#return value description#>
 */
+ (NSString *)publicKeyPath:(NSString *)cerName;
#pragma mark - 方式1 * 证书方式

/**
 *  加密方法
 *
 *  @param str   需要加密的字符串
 *  @param path  '.der'格式的公钥文件路径
 */
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;

/**
 *  解密方法
 *
 *  @param str       需要解密的字符串
 *  @param path      '.p12'格式的私钥文件路径
 *  @param password  私钥文件密码
 */
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;

#pragma mark - 方式2 * 密钥码形式

/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;


/**
 *  使用示例
 */
+ (void)_rsaTest;
@end
