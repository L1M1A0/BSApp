//
//  NSString+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NSString+Emojize.h"
//#import "HtmlMedia.h"

@interface NSString (Common)



/** 表情包 */
-(BOOL)containsEmoji;

- (NSString *)emotionMonkeyName;


/**
 将比特数据大小单位化，返回M、G等单位

 @param sizeOfByte 原数字
 @return @""
 */
+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte;

- (NSString *)trimWhitespace;
- (BOOL)isEmpty;
//判断是否为整形
- (BOOL)isPureInt;
//判断是否为浮点形
- (BOOL)isPureFloat;

/** 移除字符串开头前面的所有空格,中间和右边的保留原样 */
- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
/** 移除字符串最后位置的所有空格,中间和左边的保留原样 */
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;
/** 移除字符串开头的空格和最后位置的空格,中间的保留原样 */
+ (NSString *)stringByTrimmingLeftAndRightCharactersInSet:(NSString *)characterSet;

/** 是否包含中文 */
+(BOOL)IsChinese:(NSString *)str;
/** 是否是全是数字 或整型 */
+ (BOOL)isPureInt:(NSString *)string;
/** 将字符串转换成单个数组 */
+ (NSMutableArray *)stringToArray:(NSString *)string;

/**
 找出目标字符在原字符中出现的次数（仅限单个字符）
 
 @param string 原字符串
 @param tagString 目标字符
 @return 出现次数
 */
+ (NSInteger)occurrenceCountOfCharacter:(NSString *)string tagString:(NSString *)tagString;


/**
 使用目标字符，将原字符串中指定位置区间内的字符串替换掉

 @param leftIndex 开始下标
 @param rightIndex 结束下标
 @param hoder 替换后的字符
 @param hoderLength 替换字符长度，0表示不指定字符长度
 @param string 原字符串
 @return 被替换后的字符串
 */
+ (NSString *)placeholderStringAtIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex hoder:(NSString *)hoder hoderLength:(NSInteger)hoderLength string:(NSString *)string;


/**
 英文数字格式

 @param string 原数字
 @return 格式化后的数字
 */
+ (NSString *)positiveFormat:(NSString *)string;
@end
