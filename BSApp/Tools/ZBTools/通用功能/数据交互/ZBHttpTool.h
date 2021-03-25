//
//  ZBHttpTool.h
//  BSApp
//
//  Created by lizb on 2017/11/10.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBHttpResult.h"
#import "ZBHttpError.h"

@interface ZBHttpTool : NSObject
/*****
 
 安全参数类型：
 字符串类型的安全参数：                   para = @{}；
 json型的：                            para = @{@“a”:"b"}；
 不填安全参数或者其他类型的安全参数拼接方式， para = nil；
 
 */


/**
 执行成功后回调
 
 *  @ operation      operation信息
 *  @ responseObject AFN返回的原始数据
 *  @ object         本地处理过的数据
 */
typedef void(^successBlock)(ZBHttpResult *result);

/**
 执行失败后回调
 
 *  @ operation operation信息
 *  @ error     错误信息
 *  @ message   错误信息（抽取后的）
 */
typedef void(^failureBlock)(ZBHttpResult *result);


/** 请求管理者 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

/** 请求结果 */
@property (nonatomic, strong) ZBHttpResult *result;

/**
 会区分https
 
 @return AFHTTPRequestOperationManager 实例化对象
 */
+ (AFHTTPRequestOperationManager *)httpManager;

//初始化，已二进制流的方式返回数据
- (instancetype)initWithSerializer;


/**
 对成功返回的信息进行判断
 
 @param object 返回的数据
 @param yes 请求返回错误
 @param no  请求返回正常
 */
+ (void)isRequstError:(id)object yes:(void(^)(NSString *errorMessage))yes no:(void(^)(void))no;
- (void)isRequstError:(id)object yes:(void(^)(NSString *errorMessage))yes no:(void(^)(void))no;

/**
 *  发送get请求
 *
 *  @param URLString      请求的基本的url
 *  @param parameters     请求的参数字典(自动填充安全参数)
 *  @param success        请求成功的回调
 *  @param failure        请求失败的回调
 */
+ (void)get:(NSString *)URLString
 parameters:(id)parameters
    success:(successBlock)success
    failure:(failureBlock)failure;

- (void)get:(NSString *)URLString
 parameters:(id)parameters
    success:(successBlock)success
    failure:(failureBlock)failure;

/**
 *  发送post请求
 *
 *  @param URLString      请求的基本的url
 *  @param parameters     请求的参数字典(自动填充安全参数)
 *  @param success        请求成功的回调
 *  @param failure        请求失败的回调
 */
+ (void)post:(NSString *)URLString
  parameters:(id)parameters
     success:(successBlock)success
     failure:(failureBlock)failure;

- (void)post:(NSString *)URLString
  parameters:(id)parameters
     success:(successBlock)success
     failure:(failureBlock)failure;



/**
 *  发送put请求
 *
 *  @param URLString      请求的基本的url
 *  @param parameters     请求的参数字典(自动填充安全参数)
 *  @param success        请求成功的回调
 *  @param failure        请求失败的回调
 */

//+ (void)Put:(NSString *)URLString
// parameters:(id)parameters
//    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject, id object))success
//    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, NSString *message))failure;
+ (void)put:(NSString *)URLString
 parameters:(id)parameters
    success:(successBlock)success
    failure:(failureBlock)failure;

- (void)put:(NSString *)URLString
 parameters:(id)parameters
    success:(successBlock)success
    failure:(failureBlock)failure;

/**
 *  发送请求下载文件
 *
 *  @param parameters 请求的参数字典
 *  @param URLString  请求的基本的url
 *  @param savedPath  文件保存的路径
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *  @param progress   实时下载进度回调
 */
+ (void)downloadFile:(NSString*)URLString
          parameters:(NSDictionary *)parameters
           savedPath:(NSString*)savedPath
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure
            progress:(void (^)(float progress))progress;


//把字典值为null的转为@“”，（字典里包含一个数组也作处理）
//+ (NSDictionary *)changeNullObjectWithDict:(NSDictionary *)dict;


#pragma mark - Https 验证
//+ (void)httpsConnectionWillSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;

@end
