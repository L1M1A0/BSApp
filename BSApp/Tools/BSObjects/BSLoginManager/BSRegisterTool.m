//
//  BSRegisterTool.m
//  BSApp
//
//  Created by 李振彪 on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSRegisterTool.h"
#import "ZBEncryptionRSA.h"
#import <CommonCrypto/CommonDigest.h>
@implementation BSRegisterTool
{
    
}


/**
 *  获取手机短信验证码
 *
 *  @param phone        手机号码
 *  @param businessCode @"10"为注册，@"20"为找回密码
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 */
+ (void)getVerifyCodeWithPhone:(NSString *)phone
                  businessCode:(NSString *)businessCode
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [BSHttpTool httpManager];
    
    //mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:[NSString stringWithFormat:@"application/json;charset=utf-8"]];
    //CSBasicRequest * request=[[CSBasicRequest alloc]init];
    
    NSDictionary * para=@{@"phone":phone,@"businessCode":businessCode};
    
    //NSDictionary * parameters =[request addSafetyParametersToOtherParas:para];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",KBaseUrl(@"verifycode")];
    [mgr POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}


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
                  failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [BSHttpTool httpManager];
    //CSBasicRequest * request=[[CSBasicRequest alloc]init];
    
    BSSafetyParameter *scq = [[BSSafetyParameter alloc]init];
    
    NSString * pwd=[scq BRSS_token:password];
    
    NSDictionary * para=@{@"phone":phone,@"userId":userId,@"checkCode":checkCode,@"password":pwd,@"token":token,@"userType":@"20"};
    
    //NSDictionary * parameters =[request addSafetyParametersToOtherParas:para];
    
    [mgr POST:KBaseUrl(@"register") parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

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
                          failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [BSHttpTool httpManager];
    
    
    NSString * pwd = [[[BSSafetyParameter alloc]init] BRSS_token:password];
    
    NSDictionary * para=@{@"phone":phone,@"checkCode":checkCode,@"password":pwd,@"token":token};
    
    //NSDictionary * parameters =[request addSafetyParametersToOtherParas:para];
    
    [mgr PUT:KBaseUrl(@"password") parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}


/**
 *  修改密码
 *
 *  @param oldWord      旧密码
 *  @param newWord      新密码
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 */

+(void)resetPassWordOld:(NSString *)oldWord
                newWord:(NSString *)newWord
                success:(void (^)(ZBHttpResult *))success
                failure:(void (^)(ZBHttpResult *))failure{
    
//    AFHTTPRequestOperationManager *mgr = [BSHttpTool httpManager];
    
    
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *pwd_old = [ZBEncryptionRSA encryptString:oldWord publicKeyWithContentsOfFile:public_key_path];//password
    NSString *pwd_new = [ZBEncryptionRSA encryptString:newWord publicKeyWithContentsOfFile:public_key_path];//password
    
    
    NSDictionary * para=@{@"oldPassword":pwd_old,
                          @"newPassword":pwd_new};
    
    NSString *parameters =[BSSafetyParameter parameterStr];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",KBaseUrl(@"password"),parameters];

    [BSHttpTool put:urlStr parameters:para success:^(ZBHttpResult *result) {
        
        success(result);
        
    } failure:^(ZBHttpResult *result) {
        failure(result);
    }];

}



@end
