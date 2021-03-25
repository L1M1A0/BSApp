
//
//  ZBHttpError.m
//  BSApp
//
//  Created by lizb on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "ZBHttpError.h"
#import "AFHTTPRequestOperation.h"

@implementation ZBHttpError



+(NSString *)failureMessage:(AFHTTPRequestOperation *)operation error:(NSError *)error{
    ZBHttpResult *res = [[ZBHttpResult alloc]init];
    res.operation = operation;
    res.error = error;
    NSString *message = [ZBHttpError failureMessage:res];
    return message;
}

+ (NSString *)failureMessage:(ZBHttpResult *)result{
    
    AFHTTPRequestOperation * operation = result.operation;
    NSError *error = result.error;
    
    //一:优先判断网络请求的返回值
    NSString *errorMessage = [self _errorMessageFromOperation:operation];
    
    //主要用于判断本地错误(在网络返回的operation为nil的情况下)
    if (errorMessage.length == 0) {
        errorMessage = [self _errorMessageFromError:error];
    }
    
    errorMessage = [self _changeErrorString:errorMessage];
    NSLog(@"errorMessage_%@",errorMessage);
    
    return errorMessage;
}





/** 一:优先判断网络请求的返回值, 如果返回数据为nil(如断网会发生或其他原因)则调用查看本地数据 */
+ (NSString *)_errorMessageFromOperation:(AFHTTPRequestOperation *)operation{
    
    NSString *errorMessage = @"";
    NSDictionary *dicOperation = (NSDictionary *)operation;
    id idMember = [dicOperation valueForKey:@"responseObject"];
    
    if(idMember != nil){
        
        if ([idMember isKindOfClass:[NSData class]]) {
            
            errorMessage = [[NSString alloc]initWithData:idMember encoding:NSUTF8StringEncoding];
            
            if ([errorMessage containsString:@"<html>"] == YES) {
                errorMessage = [self _errorMessageFromXml:errorMessage];
                
            }else{
                NSDictionary *jsonDic = [self dictionaryWithJsonString:errorMessage];
                errorMessage = [jsonDic valueForKey:@"message"];
            }
        }
        else if ([idMember isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseObject = (NSDictionary *)idMember;
            errorMessage = [responseObject valueForKey:@"message"];
        }else{
            
        }
        
    }
    else{
        //这里返回的数据与[self _errorMessageFromError:error]中取得的数据基本相同
        
        NSDictionary *dicResponseSerializationError = [dicOperation valueForKey:@"responseSerializationError"];
        NSDictionary *dicUserInfo = [dicResponseSerializationError valueForKey:@"userInfo"];
        errorMessage = [self _errorMessageFromUserInfo:dicUserInfo];
    }
    
    return errorMessage;
}
/** 主要用于判断本地错误(在网络返回的operation为nil的情况下) */
+ (NSString *)_errorMessageFromError:(NSError *)error{
    
    NSDictionary *dicUserInfo = [error userInfo];
    NSString *errorMessage = [self _errorMessageFromUserInfo:dicUserInfo];
    
    return errorMessage;
}

/** 从userInfo中获取错错误信息 */
+ (NSString *)_errorMessageFromUserInfo:(NSDictionary *)dicUserInfo{
    
    NSString *errorMessage = @"";
    if ([[dicUserInfo allKeys] containsObject:@"NSLocalizedDescription"]){
        errorMessage = [dicUserInfo valueForKey:@"NSLocalizedDescription"];
    }
    else if([[dicUserInfo allKeys] containsObject:@"NSUnderlyingError"]){
        NSError *underlyingError = [dicUserInfo objectForKey:@"NSUnderlyingError"];
        NSDictionary *dicUnderlyingError = [underlyingError userInfo];
        
        if ([[dicUnderlyingError allKeys] containsObject:@"NSLocalizedDescription"]){
            //优先获取详细@“com.alamofire.serialization.response.error.data”，其次获取@“NSLocalizedDescription”
            errorMessage = [self logDetailMessageFromCom_alamofire_serialization_response_error_data:dicUnderlyingError];
            if ([[errorMessage stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0) {
                errorMessage = [dicUnderlyingError objectForKey:@"NSLocalizedDescription"];
            }
        }
        
    }else{
        
    }
    
    return errorMessage;
}



/** 将可能出现的英文信息转换为中文 */
+ (NSString *)_changeErrorString:(NSString *)errorStr{
    
    if ([errorStr isEqualToString:@"The Internet connection appears to be offline."]){
        errorStr = @"连接网络失败";
    }else if ([errorStr isEqualToString:@"The request timed out."]){
        errorStr = @"请求超时";
    }else if ([errorStr isEqualToString:@"The data couldn’t be read because it isn’t in the correct format."]){
        errorStr = @"请求错误,请检查登录状态";
    }else if ([errorStr isEqualToString:@"Could not connect to the server."]){
        errorStr = @"连接服务器失败";
    }else if ([errorStr isEqualToString:@"cannot parse response"]){
        errorStr = @"无法解析响应";
    }
    //    else if ([errorStr isEqualToString:@"Request failed: internal server error (500)"]){
    //        errorStr = @"内部服务器错误";
    //    }
    //    else if ([errorStr isEqualToString:@"Request failed: not found (404)"]){
    //        errorStr = @"error:404, 无法找到文件";
    //    }
    else{
        errorStr = errorStr;
    }
    
    if (errorStr.length == 0) {
        errorStr = @"请求连接失败！";
    }
    
    return errorStr;
}

//json格式字符串转字典：

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
        
    }
    return dic;
    
}

//优先获取html中包含@“errorMessage”的值,否则获取“title”的
+ (NSString *)_errorMessageFromXml:(NSString *)errorMessage{
    
    if ([errorMessage containsString:@"\"errorMessage\">"] == YES) {
        NSArray *arr = [errorMessage componentsSeparatedByString:@"\"errorMessage\">"];
        if(arr.count > 1){
            errorMessage = [arr[1] componentsSeparatedByString:@"</td>"][0];
            NSArray *arr1 = [errorMessage componentsSeparatedByString:@">"];
            if (arr1.count>1) {
                errorMessage = [[arr1 lastObject] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"\n" withString:@""];//删除换行
                errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"\t" withString:@""];//删除制表符
            }
        }
        //        else{//无需重复赋值
        //            errorMessage = arr[0];
        //        }
    }
    else if ([errorMessage containsString:@"</head><body><h1>"] == YES) {
        NSArray *arrForHead = [errorMessage componentsSeparatedByString:@"</head><body><h1>"];
        errorMessage = arrForHead[1];
        errorMessage = [self errorMessageFromHead:errorMessage errorkey:@"<b>message</b>"];
        if ([[errorMessage stringByReplacingOccurrencesOfString:@" " withString:@""] length]==0) {
            errorMessage = arrForHead[1];
            errorMessage = [self errorMessageFromHead:errorMessage errorkey:@"<b>description</b>"];
        }
        
    }
    else{
        if ([errorMessage containsString:@"<title>"] == YES) {
            NSArray *arr = [errorMessage componentsSeparatedByString:@"<title>"];
            if(arr.count > 1){
                errorMessage = [arr[1] componentsSeparatedByString:@"</title>"][0];
                errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"\n" withString:@""];//删除换行
                errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"\t" withString:@""];//删除制表符
            }
        }
        
    }
    return errorMessage;
}
/* 用于处理这类格式数据
 <p><b>type</b> Status report</p>
 <p><b>message</b> <u></u></p>
 <p><b>description</b> <u>The requested resource is not available.</u></p>
 */
+ (NSString *)errorMessageFromHead:(NSString *)errorMessage errorkey:(NSString *)errorkey{
    if ([errorMessage componentsSeparatedByString:errorkey]) {
        NSArray *arrForMessage = [errorMessage componentsSeparatedByString:errorkey];
        errorMessage = arrForMessage[1];
        if ([errorMessage containsString:@"</p>"]) {
            NSArray *arrForP = [errorMessage componentsSeparatedByString:@"</p>"];
            errorMessage = arrForP[0];
        }
        errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"\n" withString:@""];//删除换行
        errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"\t" withString:@""];//删除制表符
        errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"<u>" withString:@""];//
        errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"</u>" withString:@""];//
        
        //        if ([errorMessage containsString:@"</u>"]) {
        //            NSArray *arrForU = [errorMessage componentsSeparatedByString:@"</u>"];
        //            errorMessage = arrForU[0];
        //            errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"<u>" withString:@""];//删除制表符
        //        }
    }
    return errorMessage;
}


+ (NSString *)logDetailMessageFromCom_alamofire_serialization_response_error_data:(NSDictionary *)dicUnderlyingError{
    NSData *data = [dicUnderlyingError objectForKey:@"com.alamofire.serialization.response.error.data"] ;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    //GBK格式接收数据并进行转换
    NSString * retStr = [[NSString alloc]initWithData:data encoding:enc];
    NSData * jsonData = [retStr dataUsingEncoding:enc];
    NSString * xmlStr = [[NSString alloc]initWithData:jsonData encoding:enc];
    
    
    if ([xmlStr containsString:@"</head><body><h1>"] == YES) {
        NSArray *arr = [xmlStr componentsSeparatedByString:@"</head><body><h1>"];
        
        if (arr.count>1) {
            xmlStr = arr[1];
        }
    }else  if ([xmlStr containsString:@"<html>"] == YES) {
        xmlStr = [self _errorMessageFromXml:xmlStr];
    }else{
        
    }
    
    xmlStr = [self _errorMessageFromXml:xmlStr];
    // 打印 NSDictionary
    NSLog(@"详细请求错误xml中的信息_%@", xmlStr);
    return xmlStr;
}


@end
