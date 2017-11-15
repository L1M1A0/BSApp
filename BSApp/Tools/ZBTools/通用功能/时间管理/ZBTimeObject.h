//
//  ZBTimeObject.h
//  Marketing
//
//  Created by 李振彪 on 15/12/24.
//  Copyright © 2015年 forr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBTimeObject : NSObject


#pragma mark - 算日期

/** 获取当前时间
 yyyyMMddHHmmss      -> 20160114133420
 yyyy-MM-dd HH:mm:ss -> 2016-01-14 13:34:20
 yyyy-MM-dd          -> 2016-01-14
 yyyy年MM月dd日       -> 2016年12月13日
 */
+ (NSString *)currentTimeFormatter:(NSString *)dateFormat;

/**
 将 NSString 转换成 NSDate
 输入的日期字符串形如：@"1992-05-21 13:08:08"
 */
+ (NSDate *)dateStingToNSDate:(NSString *)dateString dateFormat:(NSString *)dateFormat;


/** 获取自今天起n天后的日期,如今天:0,明天:1,后天:2,大后天:3,...依此类推 */
+ (NSString *)dateForOtherDayAfterToday:(NSInteger)number;

/**
 *  获取输入的日期得到今天是星期几
 *  如"2016-01-11" -> "周一"
 */
+ (NSString*)weekTimesFromDate:(NSDate *)inputDate;

/**
 *  根据传入的时间, 获取某指定范围的时间域
 *  type取值: 一周范围
 *
 *  @return 时间域
 */
+ (NSDictionary *)weekRangeBeginAndEnd:(NSDate *)newDate;




#pragma mark - 农历
/** 获取农历 */
+ (NSString *)chineseCalendar;

/** 获取农历 返回中文格式 如: 腊月廿九 二月初七 */
+ (NSString *)lunarTimeForChinese;

/** 获取农历 返回数字模式 如:12月29日 */
+ (NSString *)lunarTimeForNumberStr;

@end
