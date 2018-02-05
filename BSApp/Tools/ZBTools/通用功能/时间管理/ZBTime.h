//
//  ZBTime.h
//  BSApp
//
//  Created by 李振彪 on 2017/8/31.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBTime : NSObject
/** 根据传入格式，获取当前时间 */
+ (NSString *)currentTimeWithDateFormat:(NSString *)dateFormat;
/**
 根据date，返回指定格式的日期字符串
 
 @param date 日期
 @param dateFormat 日期格式
 @return 指定格式的日期字符串
 */
+ (NSString *)timeWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 根据输入的时间字符串以及其格式，将 NSString 转换成 NSDate
 输入的日期字符串形如：@"1992-05-21 13:08:08"
 */
+ (NSDate *)dateWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat;



//+ (NSString *)currentTimeWithDateFormat:(NSString *)dateFormat；
//+ (NSString *)timeWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;
//+ (NSDate *)dateWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat;
- (NSString *)timeFromTimestamp:(NSInteger )timestamp dateFormat:(NSString *)dateFormat;
+ (NSString *)dateAfterDate:(NSDate *)date interval:(NSInteger)interval dateFormat:(NSString *)dateFormat;


@end
