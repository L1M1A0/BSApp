//
//  ZBDataDetector.m
//  BSApp
//
//  Created by lizb on 2017/8/22.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "ZBDataDetector.h"

@implementation ZBDataDetector


+(void)detectorStr:(NSString *)str types:(NSTextCheckingTypes)checkingTypes result:(void (^)(NSTextCheckingResult *))resultData{
    
    
    NSError *error = nil;
    //根据检测的类型初始化NSDataDetector
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:checkingTypes error:&error];
    //需要检测的字符串
    //str = @"有一个网址：wwww.JohnnyLiu.com有一个电话：15310547654 还有一个地址：大屯路";
    
    
    //可以有多种方法检测匹配的数据
    //1.检测然后对每个检测到的数据进行操作
    //- (void)enumerateMatchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range usingBlock:(void (^)(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop))block;
    //2.检测获得检测得到的数组
    //- (NSArray *)matchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
    //3.获得检测得到的总数
    //- (NSUInteger)numberOfMatchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
    //4.第一个检测到的数据
    //- (NSTextCheckingResult *)firstMatchInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
    //5.第一检测到的数据的Range
    //- (NSRange)rangeOfFirstMatchInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
    
    [detector enumerateMatchesInString:str options:kNilOptions range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        //NSTextCheckingResult有很多属性，和检测的类型相匹配，如URL，phoneNumber，date，addressComponents等等
        //NSTextCheckingResult还有Range 和 NSTextCheckingType两个属性，方便进行操作
    
//        NSLog(@"result.range = %@",NSStringFromRange(result.range));
//    
//        if (result.URL) {
//            NSLog(@"url = %@",result.URL);
//        }
//        if (result.phoneNumber) {
//            NSLog(@"phone = %@",result.phoneNumber);
//            sttt = result.phoneNumber;
//        }
        
        resultData(result);

//        NSTextCheckingTypeOrthography           = 1ULL << 0,            // language identification
//        NSTextCheckingTypeSpelling              = 1ULL << 1,            // spell checking
//        NSTextCheckingTypeGrammar               = 1ULL << 2,            // grammar checking
//        NSTextCheckingTypeDate                  = 1ULL << 3,            // date/time detection
//        NSTextCheckingTypeAddress               = 1ULL << 4,            // address detection
//        NSTextCheckingTypeLink                  = 1ULL << 5,            // link detection
//        NSTextCheckingTypeQuote                 = 1ULL << 6,            // smart quotes
//        NSTextCheckingTypeDash                  = 1ULL << 7,            // smart dashes
//        NSTextCheckingTypeReplacement           = 1ULL << 8,            // fixed replacements, such as copyright symbol for (c)
//        NSTextCheckingTypeCorrection            = 1ULL << 9,            // autocorrection
//        NSTextCheckingTypeRegularExpression NS_ENUM_AVAILABLE(10_7, 4_0)  = 1ULL << 10,           // regular expression matches
//        NSTextCheckingTypePhoneNumber NS_ENUM_AVAILABLE(10_7, 4_0)        = 1ULL << 11,           // phone number detection
//        NSTextCheckingTypeTransitInformation NS_ENUM_AVAILABLE(10_7, 4_0) = 1ULL << 12            // transit (e.g. flight) info detection

    }];
}



@end
