//
//  ZBRegularExpressionObject.h
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBRegularExpressionObject : NSObject


#pragma mark - 数字区


/** 移除字符串中的指定字符,与下方这个同样用于移除字符串的方法不同，此方法主要用于不连续的字符的删除，下方方法只能删除连续的
 @"- (NSString *)stringByReplacingOccurrencesOfString: withString:"
 如 patternStr = @”a-zA-Z.-“ 即移除掉mainStr中的所有小写字母，大写字母，以及@"."和@"-"
 */
+ (NSString *)_removesTheSpecifiedCharacter:(NSString *)patternStr mainStr:(NSString *)mainStr;

/** 是否是纯数字 NSScanner方式 */
+ (BOOL)_isPureNumberByNSScanner:(NSString *)string;

/** 是否是纯数字 NSRegularExpression方式 （isAllowDecimalPoint，是否允许小数点, ）*/
+ (BOOL)_isPureNumberByNSRegularExpression:(NSString *)string isAllowDecimalPoint:(BOOL)isAllowDecimalPoint;

/** 计算当前字符串中包含多少个数字 （isAllowDecimalPoint，是否允许小数点） */
+ (NSInteger)_countNumberByNSRegularExpression:(NSString *)string isAllowDecimalPoint:(BOOL)isAllowDecimalPoint;


#pragma mark - 字母区
/** 是否是纯英文字母(单词) */
+ (BOOL)_isPureEnglishLetter:(NSString *)string;

/** 计算当前字符串中包含多少个英文字母 */
+ (NSInteger)_countEnglishLetterByNSRegularExpression:(NSString *)string;



#pragma mark - 特殊字符区
/**
 <#Description#>
 
 @param string 目标数据
 @param tagSting 符合要求的字符
 @return
 */
+ (BOOL)_isStringIncludeSpecialCharacters:(NSString *)string tagSting:(NSString *)tagSting;

/** 是否包含特殊字符 */
+ (BOOL)_doesItIncludeSpecialCharacters:(NSString *)string;

/** 是否包含中文 */
+ (BOOL)_doesItIncludeChinese:(NSString *)string;



#pragma mark - 用法集合
/** 统计字符中的字符类型数量,  1: 一种类型*/
+ (NSInteger)countTypeInString:(NSString *)string;

/** 判断密码中是否含有一种以上的字符类型,  0: 一种类型, 1:一种以上类型 */
+ (NSInteger)_checkPassWordAndCountType:(NSString *)string;

@end
