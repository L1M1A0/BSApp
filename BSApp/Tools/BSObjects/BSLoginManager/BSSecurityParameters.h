//
//  BSSecurityParameters.h
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBEncryption.h"

@interface BSSecurityParameters : NSObject

///** 获取登录请求的安全参数(登录时使用) */
+(NSDictionary *)getLoginSecurityParameters;

/** 登录成功后，获取安全参数--字典类型  */
+ (NSMutableDictionary *)parameterDic;

/** 登录成功后，获取安全参数——字符串类型 */
+ (NSString *)parameterStr;


#pragma mark - 加密工具

/** 获取加密的密码 */
+ (NSString *)rsaEncryptPassWord:(NSString *)password;


/** MD5 加密 */
-(NSString *)md52:(NSString *)inPutText;

/** 获取密码token */
- (NSString *)getBRSS_token:(NSString *)passWord;

/** 安全哈希算法 */
- (NSString *)sha1:(NSString *)input;

/** 获取系统当前的时间戳    (*1000代表毫秒级) */
- (NSString *)getTimeInterval;

/** 生成随机guid串  （全球唯一标识符）*/
+ (NSString *)getUniqueStrByUUID;
- (NSString *)getUniqueStrByUUID;



@end
