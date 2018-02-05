//
//  ZBTimeLunarCalendar.h
//  BSApp
//
//  Created by 李振彪 on 2018/1/12.
//  Copyright © 2018年 李振彪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBTimeLunarCalendar : NSObject

/** 根据日期，获取对应农历日期 */
+ (NSString *)lunarCalendar:(NSDate *)date;


/**
 根据日期，获取对应农历汉语日期
 
 @param date 指定日期
 @return <#return value description#>
 */
+ (NSString*)lunarCalendarInChineseWithDate:(NSDate *)date;

/** 获取农历 返回数字模式 如:12月29日 */
+ (NSString *)lunarForNumberStr;
    

@end
