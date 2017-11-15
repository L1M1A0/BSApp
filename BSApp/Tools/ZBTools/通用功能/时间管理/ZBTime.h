//
//  ZBTime.h
//  BSApp
//
//  Created by 李振彪 on 2017/8/31.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBTime : NSObject
/**
 根据输入的时间字符串以及其格式，将 NSString 转换成 NSDate
 输入的日期字符串形如：@"1992-05-21 13:08:08"
 */
+ (NSDate *)dateWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat;
+ (NSDictionary *)weekRangeWithDate:(NSDate *)newDate firstWeekday:(NSInteger)firstWeekday;
@end
