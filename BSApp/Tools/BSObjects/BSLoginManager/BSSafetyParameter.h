//
//  BSSafetyParameter.h
//  BSApp
//
//  Created by lizb on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBEncryption.h"

@interface BSSafetyParameter : NSObject

///** 获取登录请求的安全参数(登录时使用) */
+(NSDictionary *)loginSafetyParameters;

/** 登录成功后，获取安全参数--字典类型  */
+ (NSMutableDictionary *)parameterDic;

/** 登录成功后，获取安全参数——字符串类型 */
+ (NSString *)parameterStr;


#pragma mark - 加密工具

/** 获取加密的密码 */
+ (NSString *)rsaEncryptPassWord:(NSString *)password;


/** 获取密码token */
- (NSString *)BRSS_token:(NSString *)passWord;



@end
