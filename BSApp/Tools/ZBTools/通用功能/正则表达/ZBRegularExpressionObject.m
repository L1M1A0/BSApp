//
//  ZBRegularExpressionObject.m
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "ZBRegularExpressionObject.h"

@implementation ZBRegularExpressionObject

/** 移除字符串中的指定字符,与下方这个同样用于移除字符串的方法不同，此方法主要用于不连续的字符的删除，下方方法只能删除连续的
 @"- (NSString *)stringByReplacingOccurrencesOfString: withString:"
 如 patternStr = @”a-zA-Z.-“ 即移除掉mainStr中的所有小写字母，大写字母，以及@"."和@"-"
 */
+ (NSString *)_removesTheSpecifiedCharacter:(NSString *)patternStr mainStr:(NSString *)mainStr{
    //例子
    //NSString *baseStr = @"a.123-45b78";
    //regularExpressionStr = @"[a-zA-Z.-]"
    
    NSString *regularExpressionStr = [NSString stringWithFormat:@"[%@]",patternStr];
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regularExpressionStr options:0 error:NULL];
    NSString *result = [regular stringByReplacingMatchesInString:mainStr options:0 range:NSMakeRange(0, [mainStr length]) withTemplate:@""];
    NSLog(@"%@", result);
    
    
    return result;
}

/** 是否是数字 NSScanner方式 */
+ (BOOL)_isPureNumberByNSScanner:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/** 是否是纯数字 NSRegularExpression方式*/
+ (BOOL)_isPureNumberByNSRegularExpression:(NSString *)string isAllowDecimalPoint:(BOOL)isAllowDecimalPoint{
    //ZBRegularExpressionObject *obj = [[ZBRegularExpressionObject alloc]init];
    NSInteger tNumMatchCount = [self _countNumberByNSRegularExpression:string isAllowDecimalPoint:isAllowDecimalPoint];
    if (tNumMatchCount == string.length)
    {
        //全部符合數字，表示沒有英文,
        //return ConfirmPasswordResult_HaveNoChar;
        NSLog(@"全是数字，!!!有可能会包含小数点，在需要纯数字的情况下，需要将 isAllowDecimalPoint 设置为 NO");
        return YES;
    }else{
        return NO;
    }
}

+ (NSInteger)_countNumberByNSRegularExpression:(NSString *)string isAllowDecimalPoint:(BOOL)isAllowDecimalPoint{
    
    
    //數字條件
    NSString *pattern = @"[0-9]";
    if (isAllowDecimalPoint == YES) {
        //(包含小数点)
        pattern = @"[0-9.]";
    }
    
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合數字條件的有幾個字元
    NSInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:string
                                                                      options:NSMatchingReportProgress
                                                                        range:NSMakeRange(0, string.length)];
    return tNumMatchCount;
}

+ (BOOL)_isPureEnglishLetter:(NSString *)string{
    //符合英文字條件的有幾個字元
    NSInteger tLetterMatchCount = [self _countEnglishLetterByNSRegularExpression:string];
    
    if (tLetterMatchCount == string.length)
    {
        //全部符合英文，表示沒有數字
        //return ConfirmPasswordResult_HaveNoNum;
        NSLog(@"全是英文");
        return YES;
    }
    else{
        return NO;
    }
}

+ (NSInteger)_countEnglishLetterByNSRegularExpression:(NSString *)string{
    //英文字條件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字條件的有幾個字元
    NSInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:string
                                                                            options:NSMatchingReportProgress
                                                                              range:NSMakeRange(0, string.length)];
    return tLetterMatchCount;
}


+ (BOOL)_doesItIncludeSpecialCharacters:(NSString *)string{
    
    //string中如果没有包含以下字符, 就表示是特殊字符
    NSString *strType1 = @"abcdefghijklmnopqrstuvwxyz";
    NSString *strType2 = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString *strType3 = @"0123456789";
    NSString *mainStr = [NSString stringWithFormat:@"%@%@%@",strType1,strType2,strType3];
    
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:mainStr] invertedSet];
    NSRange userNameRange = [string rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        NSLog(@"包含特殊字符");
        return YES;
    }else{
        return NO;
    }
    
}



/**
 <#Description#>
 
 @param string 目标数据
 @param tagSting 符合要求的字符
 @return
 */
+ (BOOL)_isStringIncludeSpecialCharacters:(NSString *)string tagSting:(NSString *)tagSting{
    
    //string中如果没有包含以下字符, 就表示是特殊字符
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:tagSting] invertedSet];
    NSRange userNameRange = [string rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        NSLog(@"包含特殊字符");
        return YES;
    }else{
        return NO;
    }
    
}

+ (BOOL)_doesItIncludeChinese:(NSString *)string{
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}


+ (NSInteger)countTypeInString:(NSString *)string{
    NSInteger a = [ZBRegularExpressionObject _countNumberByNSRegularExpression:string isAllowDecimalPoint:NO];
    NSInteger b = [ZBRegularExpressionObject _countEnglishLetterByNSRegularExpression:string];
    
    NSInteger count = 0;
    
    if (a == string.length){
        //NSLog(@"纯数字, 失败");
        //c1 = 0;
        count = 1;//允许纯数字
    }
    else if (b == string.length){
        //NSLog(@"纯英文, 失败");
        //c2 = 0;
        count = 1;//允许纯英文
    }
    else if (a == 0 && b == 0){
        NSLog(@"纯字符(不含数字也不含字母, 另外的属于特殊字符)");
        count = 1;
    }
    else if (a == 0 && b<string.length && b > 0){
        NSLog(@"数字为0, 字母数比总量少, 剩下的是其他字符, 一种以上类型, 成功");
        count = 2;
    }
    else if (b == 0 && a<string.length && a > 0){
        NSLog(@"数字比总量少, 字母数为0, 剩下的是其他字符, 一种以上类型, 成功");
        count = 2;
    }
    else if (a>0 && b>0 && (a+b) <= string.length){
        NSLog(@"数字和字母加起来的数量小于总数, (有两种或以上字符类型), 成功");
        count = 3;
    }else{
        count = 0;
    }

    NSLog(@"当前字符串中包含 %ld 种字符类型",count);
    return count;
    
}


+ (NSInteger)_checkPassWordAndCountType:(NSString *)string{
    NSInteger a = [ZBRegularExpressionObject _countNumberByNSRegularExpression:string isAllowDecimalPoint:NO];
    NSInteger b = [ZBRegularExpressionObject _countEnglishLetterByNSRegularExpression:string];
    
    NSInteger c1 = 0;
    NSInteger c2 = 0;
    NSInteger c3 = 0;
    NSInteger c4 = 0;
    NSInteger c5 = 0;
    NSInteger c6 = 0;
    NSInteger sum = 0;
    
    if (a == string.length){
        NSLog(@"纯数字, 失败");
        c1 = 0;
    }
    else if (b == string.length){
        NSLog(@"纯英文, 失败");
        c2 = 0;
    }
    else if (a == 0 && b == 0){
        NSLog(@"纯字符(不含数字也不含字母, 另外的属于特殊字符)");
        c3 = 0;
    }
    else if (a == 0 && b<string.length){
        NSLog(@"数字为0, 字母数比总量少, 剩下的是其他字符, 一种以上类型, 成功");
        c4 = 1;
    }
    else if (a<string.length && b == 0){
        NSLog(@"数字比总量少, 字母数为0, 剩下的是其他字符, 一种以上类型, 成功");
        c5 = 1;
    }
    else if (a>0 && b>0 && (a+b)<=string.length){
        NSLog(@"数字和字母加起来的数量小于总数, (有两种以上字符类型), 成功");
        c6 = 1;
    }
    sum = c1+c2+c3+c4+c5+c6;
    NSLog(@"abcsum_%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld",a,b,c1,c2,c3,c4,c5,c6,sum);
    return sum;
    
}
@end
