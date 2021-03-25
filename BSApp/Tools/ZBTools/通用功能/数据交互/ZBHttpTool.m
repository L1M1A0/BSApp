//
//  ZBHttpTool.m
//  BSApp
//
//  Created by lizb on 2017/11/10.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import "ZBHttpTool.h"


@interface ZBHttpTool ()
{
    
}



@end

@implementation ZBHttpTool
-(ZBHttpResult *)result{
    if (!_result) {
        _result = [[ZBHttpResult alloc]init];
    }
    return _result;
}


- (instancetype)initWithSerializer{//二进制流
    if (self = [super init]) {
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}


-(AFHTTPRequestOperationManager *)manager{
    if (!_manager) {
        _manager = [self httpManager];
    }
    return _manager;
}

-(AFHTTPRequestOperationManager *)httpManager{
    return [ZBHttpTool httpManager];
}


+ (AFHTTPRequestOperationManager *)httpManager{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval=30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    //响应的类型是二进制，返回二进制流
    //manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript",@"image/jpeg", nil];
    
    //Https模式
    if (kIsHttpsModel == YES) {
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        [manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"header-platform"];
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy.validatesDomainName = NO;
        //manager.securityPolicy.validatesCertificateChain = NO;
    }
    return manager;
}

- (NSDictionary *)getParameters:(id)parameters urlStr:(NSString *)urlStr{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if(parameters != nil){
        //使用字符串类型安全参数，直接拼接在url后面。
        if([parameters isEqualToDictionary:@{}]){
            NSString *paraS = [BSSafetyParameter parameterStr];//parameters;
            urlStr = [NSString stringWithFormat:@"%@?%@",urlStr,paraS];
            
            
            //[dic addEntriesFromDictionary:parameters];
            
        }
        else{//使用json类型安全参数，写在请求体里面
            dic = [BSSafetyParameter parameterDic];
            [dic addEntriesFromDictionary:parameters];
        }
    }
    //    else{
    //        dic = parameters;
    //    }
    
    //dic可能为空引发崩溃
    NSDictionary *para = @{@"parameters":dic,@"urlStr":urlStr};
    
    return para;
    
}

#pragma mark - PUT

+(void)put:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure
{
    
    ZBHttpTool *tool = [[ZBHttpTool alloc]init];
    [tool put:URLString parameters:parameters success:^(ZBHttpResult *result) {
        
        success(result);
    } failure:^(ZBHttpResult *result) {
        
        failure(result);
    }];
    
}

- (void)put:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure{
    
    //    ZBHttpTool * tool=[[ZBHttpTool alloc]init];
    NSDictionary *dic = [self getParameters:parameters urlStr:URLString];
    NSDictionary *para;
    if (parameters != nil){
        para = [dic valueForKey:@"parameters"];
        URLString = [dic valueForKey:@"urlStr"];
    }else{
        para = parameters;
    }
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", nil];
    ZBHttpResult *result = [[ZBHttpResult alloc]init];
    [self.manager PUT:URLString parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        result.operation = operation;
        result.responseObject = responseObject;
        
        [self isRequstError:responseObject yes:^(NSString *errorMessage) {
            
            result.message = errorMessage;
            self.result = result;
            if (failure) {
                failure(result);
            }
            
        } no:^{
            
            if (success) {
                id object = [self successResponseObject:responseObject];
                result.object = object;
                self.result = result;
                success(result);
            }
        }];
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        result.operation = operation;
        result.error     = error;
        NSString *mess   = [ZBHttpError failureMessage:result];
        result.message   = mess;
        
        self.result = result;
        if (failure) {
            failure(result);
        }
    }];
    
}


#pragma mark - GET
+(void)get:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure{
    
    ZBHttpTool * tool=[[ZBHttpTool alloc]init];
    
    [tool get:URLString parameters:parameters success:^(ZBHttpResult *result) {
        success(result);
    } failure:^(ZBHttpResult *result) {
        failure(result);
    }];
    
    
}


- (void)get:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure{
    
    NSDictionary *dic = [self getParameters:parameters urlStr:URLString];
    NSDictionary *para;
    if (parameters != nil){
        para = [dic valueForKey:@"parameters"];
        URLString = [dic valueForKey:@"urlStr"];
        
    }else{
        para = parameters;
    }
    
    //创建请求管理者
    //    AFHTTPRequestOperationManager *mgr = [self httpManager];
    //    mgr.requestSerializer= [AFHTTPRequestSerializer serializer];
    //    mgr.responseSerializer= [AFHTTPResponseSerializer serializer];
    
    ZBHttpResult *result = [[ZBHttpResult alloc]init];
    
    [self.manager GET:URLString parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        result.operation = operation;
        result.responseObject = responseObject;
        
        [self isRequstError:responseObject yes:^(NSString *errorMessage) {
            
            result.message = errorMessage;
            self.result = result;
            
            if (failure) {
                failure(result);
            }
            
        } no:^{
            
            if (success) {
                id object = [self successResponseObject:responseObject];
                result.object = object;
                self.result = result;
                
                success(result);
            }
        }];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        result.operation = operation;
        result.error     = error;
        NSString *mess   = [ZBHttpError failureMessage:result];
        
        result.message   = mess;
        self.result = result;
        
        if (failure) {
            failure(result);
        }
    }];
    
}



#pragma mark - POST

+ (void)post:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure
{
    
    ZBHttpTool *tool = [[ZBHttpTool alloc]init];
    [tool post:URLString parameters:parameters success:^(ZBHttpResult *result) {
        success(result);
    } failure:^(ZBHttpResult *result) {
        failure(result);
    }];
    
}

- (void)post:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure{
    
    NSDictionary *dic = [self getParameters:parameters urlStr:URLString];
    NSDictionary *para;
    if (parameters != nil){
        para = [dic valueForKey:@"parameters"];
        URLString = [dic valueForKey:@"urlStr"];
        
    }else{
        para = parameters;
    }
    
    ZBHttpResult *result = [[ZBHttpResult alloc]init];
    // 创建请求管理者
    [self.manager POST:URLString parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        result.operation = operation;
        result.responseObject = responseObject;
        
        [self isRequstError:responseObject yes:^(NSString *errorMessage) {
            
            result.message = errorMessage;
            self.result = result;
            
            if (failure) {
                failure(result);
            }
            
        } no:^{
            
            if (success) {
                id object = [self successResponseObject:responseObject];
                result.object = object;
                self.result = result;
                
                success(result);
            }
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        result.operation = operation;
        result.error     = error;
        NSString *mess   = [ZBHttpError failureMessage:result];
        
        result.message   = mess;
        self.result = result;
        
        if (failure) {
            failure(result);
        }
    }];
}

+ (void)downloadFile:(NSString*)URLString
          parameters:(NSDictionary *)parameters
           savedPath:(NSString*)savedPath
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure
            progress:(void (^)(float progress))progress
{
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        //        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    [operation start];
    
}


#pragma mark - 扩展方法 数据整理 方法 1

- (id)successResponseObject:(id)responseObject{
    
    //NSLog(@"responseObject_class_%@",[responseObject superclass]);
    
    if ([responseObject isKindOfClass:[NSData class]]) {
        
        
        //Json序列化
        id response=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        return response;
        //ZBHttpTool * tool=[[ZBHttpTool alloc]init];
        //        id responseData;
        //        if ([response isKindOfClass:[NSDictionary class]]) {
        //
        //            responseData = [tool changeNullObjectWithDict:response];
        //
        //        }else if([response isKindOfClass:[NSArray class]]){
        //
        //            responseData = [tool changeNullObjectWithArray:response];
        //        }else{
        //
        //            responseData = response;
        //        }
        //        return responseData;
    }else{
        return responseObject;
    }
    
}



//+ (NSDictionary *)changeNullObjectWithDict:(NSDictionary *)dict{
//    ZBHttpTool *tool = [[ZBHttpTool alloc]init];
//    return [tool changeNullObjectWithDict:dict];
//}

//把字典值为null的转为@“”，（字典里包含一个数组也作处理）
- (NSDictionary *)changeNullObjectWithDict:(NSDictionary *)dict
{
    //    if ([[array firstObject] isKindOfClass:[NSArray class]]) {
    //        return array;
    //    }
    
    NSMutableDictionary * dic=[NSMutableDictionary dictionary];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id object = obj;
        if ([obj isKindOfClass:[NSNull class]]) {
            object = @"";
        }
        else if ([obj isKindOfClass:[NSArray class]]){
            
            
            if (![[obj firstObject] isKindOfClass:[NSArray class]]) {
                
                NSMutableArray * array=[NSMutableArray array];
                /***/
                if ([[obj firstObject] isKindOfClass:[NSDictionary class]]) {
                    for (NSDictionary * item in obj) {
                        NSMutableDictionary * dict=[NSMutableDictionary dictionary];
                        [item enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key1, id  _Nonnull obj1, BOOL * _Nonnull stop) {
                            id object1=obj1;
                            if ([obj1 isKindOfClass:[NSNull class]]) {
                                
                                //这样做的话会让 dic = @""(将字符串赋给字典,不正常)
                                object1=@"";
                                
                            }
                            [dict addEntriesFromDictionary:@{key1:object1}];
                        }];
                        [array addObject:dict];
                    }
                    object=array;
                }
                
            }
            
        }
        
        [dic addEntriesFromDictionary:@{key:object}];
        
    }];
    
    return dic;
}

//把数组里的字典值为null的转为@“”，（数组里包含字典，字典里包含一层数组也已经作处理）
-(NSArray *)changeNullObjectWithArray:(NSArray *)array
{
    if ([[array firstObject] isKindOfClass:[NSArray class]]) {
        NSMutableArray * resultArray=[NSMutableArray array];
        for (NSArray * arr in array) {
            
            NSMutableArray * result=[NSMutableArray array];
            for (id obj in arr) {
                if ([obj isKindOfClass:[NSNull class]]) {
                    [result addObject:@""];
                }else{
                    [result addObject:obj];
                }
                
            }
            
            [resultArray addObject:result];
            
        }
        return resultArray;
    }
    
    NSMutableArray * resultArray=[NSMutableArray array];
    for (NSDictionary * dict in array) {
        
        NSMutableDictionary * dic=[NSMutableDictionary dictionary];
        
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            id object=obj;
            if ([obj isKindOfClass:[NSNull class]]) {
                object=@"";
            }else if ([obj isKindOfClass:[NSArray class]]){
                NSMutableArray * array=[NSMutableArray array];
                for (NSDictionary * item in obj) {
                    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
                    [item enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key1, id  _Nonnull obj1, BOOL * _Nonnull stop) {
                        id object1=obj1;
                        if ([obj1 isKindOfClass:[NSNull class]]) {
                            object1=@"";
                        }
                        [dict addEntriesFromDictionary:@{key1:object1}];
                    }];
                    [array addObject:dict];
                }
                object=array;
            }
            
            [dic addEntriesFromDictionary:@{key:object}];
            
        }];
        
        [resultArray addObject:dic];
    }
    
    return resultArray;
}



#pragma mark - 扩展方法 数据整理 方法 2

+ (void)isRequstError:(id)object yes:(void (^)(NSString *))yes no:(void (^)(void))no{
    
    [[[ZBHttpTool alloc]init] isRequstError:object yes:^(NSString *errorMessage) {
        yes(errorMessage);
    } no:^{
        no();
    }];
}
- (void)isRequstError:(id)object yes:(void (^)(NSString *))yes no:(void (^)(void))no{
    
    id data;
    //判断返回的数据的类型
    if ([object isKindOfClass:[NSData class]]) {
        
        data = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingMutableContainers error:nil];
    }else if([object isKindOfClass:[NSDictionary class]]){
        
        data = object;
    }
    else{
        data = object;
    }
    
    //    NSLog(@"dataa,__%@",[object class]);
    //获取数据的大致结构，如果包含@“errorMsg”key，就表明是失败的，但却在成功中回调
    if ([data isKindOfClass:[NSDictionary class]]) {
        //NSLog(@"data_allKeys_%@",[data allKeys]);
        
        if ([[data allKeys] containsObject:@"errorMsg"] == YES) {
            
            yes(data[@"errorMsg"]);
        }else{
            no();
        }
    }else{
        yes(kUnknowDataType);
    }
}


#pragma mark - https
//
//
///**
// 将以下代码复制到 AFN的<AFURLConnectionOperation.m>下的替换以下的方法
// - (void)connection:(NSURLConnection *)connection
// willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
//
// @param challenge <#challenge description#>
// */
//+ (void)httpsConnectionWillSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
//    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
//    NSLog(@"thePath===========%@",thePath);
//    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
//    CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;
//
//    SecIdentityRef identity = NULL;
//    // extract the ideneity from the certificate
//    [self extractIdentity:inPKCS12Data :&identity];
//
//    SecCertificateRef certificate = NULL;
//    SecIdentityCopyCertificate (identity, &certificate);
//
//    const void *certs[] = {certificate};
//    //                        CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
//    // create a credential from the certificate and ideneity, then reply to the challenge with the credential
//    //NSLog(@"identity=========%@",identity);
//    NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity certificates:nil persistence:NSURLCredentialPersistencePermanent];
//
//    //           credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
//
//    [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
//}
//+ (OSStatus)extractIdentity:(CFDataRef)inP12Data :(SecIdentityRef*)identity {
//    OSStatus securityError = errSecSuccess;
//
//    CFStringRef password = CFSTR("bskj1234");
//    const void *keys[] = { kSecImportExportPassphrase };
//    const void *values[] = { password };
//
//    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
//
//    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
//    securityError = SecPKCS12Import(inP12Data, options, &items);
//
//    if (securityError == 0)
//    {
//        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
//        const void *tempIdentity = NULL;
//        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
//        *identity = (SecIdentityRef)tempIdentity;
//    }
//
//    if (options) {
//        CFRelease(options);
//    }
//
//    return securityError;
//}
//
@end
