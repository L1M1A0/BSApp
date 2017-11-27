//
//  BSSafetyParameter.m
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSSafetyParameter.h"
#import <CommonCrypto/CommonDigest.h>
#import "BSLoginManager.h"
#import "ZBEncryptionRSA.h"

@implementation BSSafetyParameter



/** 登录成功后，获取请求的安全参数  */
+(NSMutableDictionary *)parameterDic
{
    BSSafetyParameter * tool = [[BSSafetyParameter alloc]init];
    BSUserModel * model  = [BSLoginManager getCurrentUserInfo];
    NSString *userId            = model.empCode;//用户id
    NSString *loginId           = model.loginId;
    NSString *guid              = [ZBEncryption UUID];
    NSString *BRSS_timestamp    = [ZBEncryption timeStamp];
    
    NSDictionary *paras         = @{@"BRSS_PtId":kPtId,
                                    @"BRSS_UserId":userId,
                                    @"BRSS_Version":@"1.0",
                                    @"BRSS_LoginId":loginId,
                                    @"BRSS_Nonce":guid,
                                    @"BRSS_Timestamp":BRSS_timestamp};
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[tool _getPhoneModel]];
    
    [dictionary addEntriesFromDictionary:paras];
    
    return dictionary;
}


/** 获取字符串类型安全参数 */
+ (NSString *)parameterStr
{
    
    BSSafetyParameter * tool=[[BSSafetyParameter alloc]init];
    BSUserModel * model = [BSLoginManager getCurrentUserInfo];
    
    NSString *versionNum      = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"]];//1.0
    NSString *iosVerson       = [NSString stringWithFormat:@"%lf",[[[UIDevice currentDevice] systemVersion] doubleValue]];//ios8
    NSString *phoneModel      = [[UIDevice currentDevice] model];//iphone6+
    
    NSString *userId          = model.empCode;
    NSString *loginId         = model.loginId;
    NSString *guid            = [ZBEncryption UUID];
    NSString *BRSS_timestamp  = [ZBEncryption timeStamp];
    
    
    //固定的安全字符串，我们直接写，不是固定的，我们传参数
    NSString *paraString = [NSString stringWithFormat:@"BRSS_LoginId=%@&BRSS_Nonce=%@&BRSS_PtId=%@&BRSS_Timestamp=%@&BRSS_UserId=%@&BRSS_Version=1.0&BTIP_APPVersion=%@&BTIP_Brand=%@&BTIP_DeviceId=test&BTIP_OSVersion=%@&BTIP_SWVersion=Xcode7.1",loginId,guid,kPtId,BRSS_timestamp,userId,versionNum,phoneModel,iosVerson];
    
    return paraString;
}


/** 获取登录请求的安全参数(登录时使用) */
+(NSDictionary *)loginSafetyParameters
{
    BSSafetyParameter * tool = [[BSSafetyParameter alloc]init];
    
    NSString *guid           = [ZBEncryption UUID];
    NSString *BRSS_timestamp = [ZBEncryption timeStamp];
    //    password                 = [self _rsaEncryptPassWord:password];
    
    //,@"password":password,@"empType":@"empType",@"BRSS_UserId":username
    NSDictionary *paras      = @{@"BRSS_PtId":kPtId,
                                 @"BRSS_Version":@"1.0",
                                 @"BRSS_Nonce":guid,
                                 @"BRSS_Timestamp":BRSS_timestamp};//@"BRSS_Signature":BRSS_Signature,@"BRSS_Token":BRSS_token
    
    //拼接以上的字典返回给服务器
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[tool _getPhoneModel]];
    //NSMutableDictionary还提供一个整体拼接字典的方法
    [dictionary addEntriesFromDictionary:paras];
    
    
    return dictionary;
}

- (NSDictionary *)_getPhoneModel{
    
    NSString *versionNum = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"]];//1.0
    NSString *iosVerson  = [NSString stringWithFormat:@"%lf",[[[UIDevice currentDevice] systemVersion] doubleValue]];//ios8
    NSString *phoneModel = [[UIDevice currentDevice] model];//iphone6+
    
    NSDictionary *para = @{@"BTIP_DeviceId":@"test",@"BTIP_APPVersion":versionNum,@"BTIP_Brand":phoneModel,@"BTIP_OSVersion":iosVerson,@"BTIP_SWVersion":@"Xcode9.1"};
    return para;
}


#pragma mark - 加密工具

//保存加密的密码
+ (NSString *)rsaEncryptPassWord:(NSString *)password{
    //md5
    //NSString *BRSS_token = [tool getBRSS_token:password];//password
    
    //rsa
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *BRSS_token = [ZBEncryptionRSA encryptString:password publicKeyWithContentsOfFile:public_key_path];
    
    return BRSS_token;
}




//md5加密
- (NSString *)BRSS_token:(NSString *)passWord
{
    NSString *result = @"";
    result = [result stringByAppendingString:passWord];
    result = [[ZBEncryption MD5:result] lowercaseString];
    return result;
}


@end
