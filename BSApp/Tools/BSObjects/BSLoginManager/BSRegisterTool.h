//
//  BSRegisterTool.h
//  BSApp
//
//  Created by 李振彪 on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface BSRegisterTool : NSObject
//请求超时时间都设置了10秒
//方法里已经包含了密码加密，传入未加密的密码即可
//返回的结果里，如果row>0说明操作成功，否则操作失败

/**
 *  获取手机短信验证码
 *
 *  @param phone        手机号码
 *  @param businessCode @"10"为注册，@"20"为找回密码
 *  @param success      请求成功的回调，result_id在用户注册和密码找回提交时要带上
 *  @param failure      请求失败的回调
 */
+ (void)getVerifyCodeWithPhone:(NSString *)phone
                  businessCode:(NSString *)businessCode
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

/**
 *  注册新用户
 *
 *  @param phone        手机号码
 *  @param userId       用户名
 *  @param checkCode    短信验证码
 *  @param password     密码
 *  @param token        获取短信验证码时返回的result_id
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 */
+ (void)registerWithPhone:(NSString *)phone
                   userId:(NSString *)userId
                checkCode:(NSString *)checkCode
                 password:(NSString *)password
                    token:(NSString *)token
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  找回密码
 *
 *  @param phone        手机号码
 *  @param checkCode    短信验证码
 *  @param password     密码
 *  @param token        获取短信验证码时返回的result_id
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 */
+ (void)retrievePasswordWithPhone:(NSString *)phone
                        checkCode:(NSString *)checkCode
                         password:(NSString *)password
                            token:(NSString *)token
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;


/**
 *  修改密码
 *
 *  @param oldWord      旧密码
 *  @param newWord      新密码
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 */
//+ (void)resetPassWordOld:(NSString *)oldWord
//                 newWord:(NSString *)newWord
//                 success:(void (^)(id responseObject))success
//                 failure:(void (^)(NSError *error))failure;
+ (void)resetPassWordOld:(NSString *)oldWord
                 newWord:(NSString *)newWord
                 success:(void (^)(ZBHttpResult * result))success
                 failure:(void (^)(ZBHttpResult * result))failure;
@end
