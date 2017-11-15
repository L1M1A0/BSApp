//
//  ZBConvertStringObject.m
//  Marketing
//
//  Created by 李振彪 on 15/12/24.
//  Copyright © 2015年 forr. All rights reserved.
//

#import "ZBConvertStringObject.h"

@implementation ZBConvertStringObject


/** 转化阿拉伯数字月份为中文农历时间_月分 */
- (NSString *)_transformArabicNumeralsToChinese_Month:(NSString *)string{
    if ([string isEqualToString:@"01"]||[string isEqualToString:@"1"]||[string isEqualToString:@"1月"]) {
        string = @"正月";
    }
    if ([string isEqualToString:@"02"]||[string isEqualToString:@"2"]||[string isEqualToString:@"2月"]) {
        string = @"二月";
    }
    if ([string isEqualToString:@"03"]||[string isEqualToString:@"3"]||[string isEqualToString:@"3月"]) {
        string = @"三月";
    }
    if ([string isEqualToString:@"04"]||[string isEqualToString:@"4"]||[string isEqualToString:@"4月"]) {
        string = @"四月";
    }
    if ([string isEqualToString:@"05"]||[string isEqualToString:@"5"]||[string isEqualToString:@"5月"]) {
        string = @"五月";
    }
    if ([string isEqualToString:@"06"]||[string isEqualToString:@"6"]||[string isEqualToString:@"6月"]) {
        string = @"六月";
    }
    if ([string isEqualToString:@"07"]||[string isEqualToString:@"7"]||[string isEqualToString:@"7月"]) {
        string = @"七月";
    }
    if ([string isEqualToString:@"08"]||[string isEqualToString:@"8"]||[string isEqualToString:@"8月"]) {
        string = @"八月";
    }
    if ([string isEqualToString:@"09"]||[string isEqualToString:@"9"]||[string isEqualToString:@"9月"]) {
        string = @"九月";
    }
    if ([string isEqualToString:@"10"]||[string isEqualToString:@"10月"]) {
        string = @"十月";
    }
    if ([string isEqualToString:@"11"]||[string isEqualToString:@"11月"]) {
        string = @"十一月";
    }
    if ([string isEqualToString:@"12"]||[string isEqualToString:@"12月"]) {
        string = @"腊月";
    }
    return string;
}

/** 月份汉语转数字 类型如:"一月" -> "01"*/
- (NSString *)_transChineseMonthToNumber:(NSString *)month
{
    if ([month isEqualToString:@"一月"]) {
        return @"01";
    }else if ([month isEqualToString:@"二月"]){
        return @"02";
    }else if ([month isEqualToString:@"三月"]){
        return @"03";
    }else if ([month isEqualToString:@"四月"]){
        return @"04";
    }else if ([month isEqualToString:@"五月"]){
        return @"05";
    }else if ([month isEqualToString:@"六月"]){
        return @"06";
    }else if ([month isEqualToString:@"七月"]){
        return @"07";
    }else if ([month isEqualToString:@"八月"]){
        return @"08";
    }else if ([month isEqualToString:@"九月"]){
        return @"09";
    }else if ([month isEqualToString:@"十月"]){
        return @"10";
    }else if ([month isEqualToString:@"十一月"]){
        return @"11";
    }else if ([month isEqualToString:@"十二月"]){
        return @"12";
    }
    return month;
}

////月份汉语转数字
//- (NSString *)transNum:(NSString *)month
//{
//    if ([month isEqualToString:@"一月"]) {
//        return @"01";
//    }else if ([month isEqualToString:@"二月"]){
//        return @"02";
//    }else if ([month isEqualToString:@"三月"]){
//        return @"03";
//    }else if ([month isEqualToString:@"四月"]){
//        return @"04";
//    }else if ([month isEqualToString:@"五月"]){
//        return @"05";
//    }else if ([month isEqualToString:@"六月"]){
//        return @"06";
//    }else if ([month isEqualToString:@"七月"]){
//        return @"07";
//    }else if ([month isEqualToString:@"八月"]){
//        return @"08";
//    }else if ([month isEqualToString:@"九月"]){
//        return @"09";
//    }else if ([month isEqualToString:@"十月"]){
//        return @"10";
//    }else if ([month isEqualToString:@"十一月"]){
//        return @"11";
//    }else if ([month isEqualToString:@"十二月"]){
//        return @"12";
//    }
//    return month;
//}




/** 转化阿拉伯数字为中文农历时间 _日 */
- (NSString *)_transformArabicNumeralsToChinese_Day:(NSString *)string{
    if ([string isEqualToString:@"01"]) {
        string = @"初一";
    }
    if ([string isEqualToString:@"02"]) {
        string = @"初二";
    } if ([string isEqualToString:@"03"]) {
        string = @"初三";
    } if ([string isEqualToString:@"04"]) {
        string = @"初四";
    } if ([string isEqualToString:@"05"]) {
        string = @"初五";
    } if ([string isEqualToString:@"06"]) {
        string = @"初六";
    } if ([string isEqualToString:@"07"]) {
        string = @"初七";
    } if ([string isEqualToString:@"08"]) {
        string = @"初八";
    } if ([string isEqualToString:@"09"]) {
        string = @"初九";
    } if ([string isEqualToString:@"10"]) {
        string = @"初十";
    } if ([string isEqualToString:@"11"]) {
        string = @"十一";
    } if ([string isEqualToString:@"12"]) {
        string = @"十二";
    } if ([string isEqualToString:@"13"]) {
        string = @"十三";
    } if ([string isEqualToString:@"14"]) {
        string = @"十四";
    } if ([string isEqualToString:@"15"]) {
        string = @"十五";
    } if ([string isEqualToString:@"16"]) {
        string = @"十六";
    } if ([string isEqualToString:@"17"]) {
        string = @"十七";
    } if ([string isEqualToString:@"18"]) {
        string = @"十八";
    } if ([string isEqualToString:@"19"]) {
        string = @"十九";
    } if ([string isEqualToString:@"20"]) {
        string = @"二十";
    } if ([string isEqualToString:@"21"]) {
        string = @"廿一";
    } if ([string isEqualToString:@"22"]) {
        string = @"廿二";
    } if ([string isEqualToString:@"23"]) {
        string = @"廿三";
    } if ([string isEqualToString:@"24"]) {
        string = @"廿四";
    } if ([string isEqualToString:@"25"]) {
        string = @"廿五";
    } if ([string isEqualToString:@"26"]) {
        string = @"廿六";
    } if ([string isEqualToString:@"27"]) {
        string = @"廿七";
    } if ([string isEqualToString:@"28"]) {
        string = @"廿八";
    } if ([string isEqualToString:@"29"]) {
        string = @"廿九";
    } if ([string isEqualToString:@"30"]) {
        string = @"三十";
    } if ([string isEqualToString:@"31"]) {
        string = @"三十一";
    }
    
    
    return string;
}
- (NSString *)_transNumberByInsert0ToSingleDigit:(NSString *)string{
    if([string isEqualToString:@"0"]){
        string = @"00";
    }
    if([string isEqualToString:@"1"]){
        string = @"01";
    }
    if([string isEqualToString:@"2"]){
        string = @"02";
    }
    if([string isEqualToString:@"3"]){
        string = @"03";
    }
    if([string isEqualToString:@"4"]){
        string = @"04";
    }
    if([string isEqualToString:@"5"]){
        string = @"05";
    }
    if([string isEqualToString:@"6"]){
        string = @"06";
    }
    if([string isEqualToString:@"7"]){
        string = @"07";
    }
    if([string isEqualToString:@"8"]){
        string = @"08";
    }
    if([string isEqualToString:@"9"]){
        string = @"09";
    }
    return string;
}


/** 将"星期几"格式转化为"周几"格式 */
- (NSString *)_transXingQiJiToZhouJi:(NSString *)string{
    if ([string isEqualToString:@"星期一"]) {
        string = @"周一";
    }
    if ([string isEqualToString:@"星期二"]) {
        string = @"周二";
    }
    if ([string isEqualToString:@"星期三"]) {
        string = @"周三";
    }
    if ([string isEqualToString:@"星期四"]) {
        string = @"周四";
    }
    if ([string isEqualToString:@"星期五"]) {
        string = @"周五";
    }
    if ([string isEqualToString:@"星期六"]) {
        string = @"周六";
    }
    if ([string isEqualToString:@"星期天"]) {
        string = @"周日";
    }
    return string;
}

//会议材料用到
/** 将meettingNum转换成汉字形式 如:"1"->"第一次" */
- (NSString *)_transformArabicNumeralsToChineseCounter:(NSString *)number{
    
    if ([number isEqualToString:@"1"]) {
        return number = @"第一次";
    }
    else if ([number isEqualToString:@"2"]){
        return number = @"第二次";
    }
    else if ([number isEqualToString:@"3"]){
        return number = @"第三次";
    }
    else if ([number isEqualToString:@"4"]){
        return number = @"第四次";
    }
    else if ([number isEqualToString:@"5"]){
        return number = @"第五次";
    }
    else if ([number isEqualToString:@"6"]){
        return number = @"第六次";
    }
    else if ([number isEqualToString:@"7"]){
        return number = @"第七次";
    }
    else if ([number isEqualToString:@"8"]){
        return number = @"第八次";
    }
    else if ([number isEqualToString:@"9"]){
        return number = @"第九次";
    }
    else if ([number isEqualToString:@"10"]){
        return number = @"第十次";
    }
    else if ([number isEqualToString:@"11"]){
        return number = @"第十一次";
    }
    else if ([number isEqualToString:@"12"]){
        return number = @"第十二次";
    }
    return number;
}

/** 将中文计数类型转化成数字 如:"第一次" -> "1" */
- (NSString *)_transChineseCounterToNumber:(NSString *)number{
    if ([number isEqualToString:@"第一次"]) {
        return number = @"1";
    }
    else if ([number isEqualToString:@"第二次"]){
        return number = @"2";
    }
    else if ([number isEqualToString:@"第三次"]){
        return number = @"3";
    }
    else if ([number isEqualToString:@"第四次"]){
        return number = @"4";
    }
    else if ([number isEqualToString:@"第五次"]){
        return number = @"5";
    }
    else if ([number isEqualToString:@"第六次"]){
        return number = @"6";
    }
    else if ([number isEqualToString:@"第七次"]){
        return number = @"7";
    }
    else if ([number isEqualToString:@"第八次"]){
        return number = @"8";
    }
    else if ([number isEqualToString:@"第九次"]){
        return number = @"9";
    }
    else if ([number isEqualToString:@"第十次"]){
        return number = @"10";
    }
    else if ([number isEqualToString:@"第十一次"]){
        return number = @"11";
    }
    else if ([number isEqualToString:@"第十二次"]){
        return number = @"12";
    }
    return number;
}

/** 判断字符串的元素是否全是数字 */
- (BOOL)_ifTheElementsInTheStringIsAllNumbers:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


@end
