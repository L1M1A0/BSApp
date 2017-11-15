//
//  BSSecurityParameters.m
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSSecurityParameters.h"
#import <CommonCrypto/CommonDigest.h>
#import "BSLoginManager.h"
#import "ZBEncryptionRSA.h"

@implementation BSSecurityParameters



/** 登录成功后，获取请求的安全参数  */
+(NSMutableDictionary *)parameterDic
{
    BSSecurityParameters * tool = [[BSSecurityParameters alloc]init];
    BSUserModel * model  = [BSLoginManager getCurrentUserInfo];
    NSString *userId            = model.empCode;//用户id
    NSString *loginId           = model.loginId;
    NSString *guid              = [tool getUniqueStrByUUID];
    NSString *BRSS_timestamp    = [tool getTimeInterval];
    
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
    
    BSSecurityParameters * tool=[[BSSecurityParameters alloc]init];
    BSUserModel * model = [BSLoginManager getCurrentUserInfo];
    
    NSString *versionNum      = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"]];//1.0
    NSString *iosVerson       = [NSString stringWithFormat:@"%lf",[[[UIDevice currentDevice] systemVersion] doubleValue]];//ios8
    NSString *phoneModel      = [[UIDevice currentDevice] model];//iphone6+
    
    NSString *userId          = model.empCode;
    NSString *loginId         = model.loginId;
    NSString *guid            = [tool getUniqueStrByUUID];
    NSString *BRSS_timestamp  = [tool getTimeInterval];
    
    
    //固定的安全字符串，我们直接写，不是固定的，我们传参数
    NSString *paraString = [NSString stringWithFormat:@"BRSS_LoginId=%@&BRSS_Nonce=%@&BRSS_PtId=%@&BRSS_Timestamp=%@&BRSS_UserId=%@&BRSS_Version=1.0&BTIP_APPVersion=%@&BTIP_Brand=%@&BTIP_DeviceId=test&BTIP_OSVersion=%@&BTIP_SWVersion=Xcode7.1",loginId,guid,kPtId,BRSS_timestamp,userId,versionNum,phoneModel,iosVerson];
    
    return paraString;
}


/** 获取登录请求的安全参数(登录时使用) */
+(NSDictionary *)getLoginSecurityParameters
{
    BSSecurityParameters * tool = [[BSSecurityParameters alloc]init];
    
    NSString *guid           = [tool getUniqueStrByUUID];
    NSString *BRSS_timestamp = [tool getTimeInterval];
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
    
    NSDictionary *para = @{@"BTIP_DeviceId":@"test",@"BTIP_APPVersion":versionNum,@"BTIP_Brand":phoneModel,@"BTIP_OSVersion":iosVerson,@"BTIP_SWVersion":@"Xcode7.1"};
    return para;
}


//保存加密的密码
+ (NSString *)rsaEncryptPassWord:(NSString *)password{
    //md5
    //NSString *BRSS_token = [tool getBRSS_token:password];//password
    
    //rsa
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *BRSS_token = [ZBEncryptionRSA encryptString:password publicKeyWithContentsOfFile:public_key_path];
    
    return BRSS_token;
}



#pragma mark - 加密工具

//sha1（安全哈希算法）
- (NSString *)sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes,(unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

//获取系统当前的时间戳    (*1000代表毫秒级)
-(NSString *)getTimeInterval
{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%llu",recordTime];
}


+ (NSString *)getUniqueStrByUUID{
    return [[[BSSecurityParameters alloc]init] getUniqueStrByUUID];
}
//生成随机guid串  （全球唯一标识符）
- (NSString *)getUniqueStrByUUID
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    
    NSString    *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString ;
    
}

//md5加密
- (NSString *)getBRSS_token:(NSString *)passWord
{
    
    NSString *result = @"";
    result = [result stringByAppendingString:passWord];
    result = [[self md52:result] lowercaseString];
    return result;
}

-(NSString *)md52:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    //CC_MD5_DIGEST_LENGTH=16
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr,(unsigned int)strlen(cStr), result);
    
    // x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
    NSString *md5Str = [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15] ] lowercaseString];
    return md5Str;
}


@end
