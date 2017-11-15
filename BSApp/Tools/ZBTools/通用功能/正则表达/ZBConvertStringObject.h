//
//  ZBConvertStringObject.h
//  Marketing
//
//  Created by 李振彪 on 15/12/24.
//  Copyright © 2015年 forr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBConvertStringObject : NSObject

/** 转化阿拉伯数字月份为中文农历时间 _月份 */
- (NSString *)_transformArabicNumeralsToChinese_Month:(NSString *)string;

/** 月份汉语转数字 类型如:"一月" -> "01"*/
- (NSString *)_transChineseMonthToNumber:(NSString *)month;


/** 转化阿拉伯数字为中文农历时间 _日期 */
- (NSString *)_transformArabicNumeralsToChinese_Day:(NSString *)string;

/** 给10一下的个位数前面添加0 如:"1"->"01" */
- (NSString *)_transNumberByInsert0ToSingleDigit:(NSString *)string;
/** 将"星期几"格式转化为"周几"格式 */
- (NSString *)_transXingQiJiToZhouJi:(NSString *)string;

/** 将meettingNum转换成汉字形式 如:"1"->"第一次" */
- (NSString *)_transformArabicNumeralsToChineseCounter:(NSString *)number;

/** 将中文计数类型转化成数字 如:"第一次" -> "1" */
- (NSString *)_transChineseCounterToNumber:(NSString *)number;

/** 判断字符串的元素是否全是数字 */
- (BOOL)_ifTheElementsInTheStringIsAllNumbers:(NSString *)string;


@end
