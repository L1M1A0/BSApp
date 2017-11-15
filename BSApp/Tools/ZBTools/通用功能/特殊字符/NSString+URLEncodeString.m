//
//  NSString+URLEncodeString.m
//  BROnlineLearning
//
//  Created by forr on 14-11-26.
//  Copyright (c) 2014年 Bori Information Technology Co., Ltd. All rights reserved.
//

#import "NSString+URLEncodeString.h"

#import <CommonCrypto/CommonDigest.h>
@implementation NSString (URLEncodeString)

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString*)URLDecodedString
{
    NSString *result = ( NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                              (CFStringRef)self,
                                                                              CFSTR(""),
                                                                              kCFStringEncodingUTF8));
    return result;
}

-(NSString *)urlReplaceWithString:(NSString *)urlStr{
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"{" withString:@"%7B"];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"}" withString:@"%7D"];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"=" withString:@"%3d"];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"-" withString:@"%2d"];
    return urlStr;
}

-(id)deleteLineFeedWithString:(NSString *)responseString{
    responseString = [responseString stringByReplacingOccurrencesOfString : @"\r\n" withString : @"" ];
    
    responseString = [responseString stringByReplacingOccurrencesOfString : @"\n" withString : @"" ];
    
    responseString = [responseString stringByReplacingOccurrencesOfString : @"\t" withString : @"" ];
    return [responseString mj_JSONObject];
}




/** 字典装url参数 */
- (NSString *)urlParamsConversionFromDictionary:(NSDictionary *)params
                                   supplemental:(BOOL)supplemental
{
    
    NSMutableString *urlParams = [NSMutableString string];
    int i = 0;
    for (NSString *key in params.keyEnumerator) {
        NSString *paraString = @"";
        if (i==0 && supplemental==NO)
        {
            paraString = [NSString stringWithFormat:@"?%@=%@",key,params[key]];
        }
        else
        {
           paraString = [NSString stringWithFormat:@"&%@=%@",key,params[key]];
        }
        [urlParams appendString:paraString];
        i++;
    }
    return urlParams;
}

/** url参数转 */
- (NSDictionary *)paramsConversionFromUrlParams:(NSString *)urlParams

{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSRange range = [urlParams rangeOfString:@"?"];
    //
    NSString *propertys = @"";
    if (range.location != NSNotFound)
    {
        propertys = [urlParams substringFromIndex:(int)(range.location + 1)];
        NSLog(@"url = %@",propertys);
    }
    
    NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
    NSLog(@"ggggg = %@",subArray);
    for (int i = 0; i < subArray.count; i++) {
        NSArray *dicArray = [subArray[i] componentsSeparatedByString:@"="];
        params[dicArray[0]] = dicArray[1];
    }
    NSLog(@"paras = %@",params);
    return params;
}

@end
