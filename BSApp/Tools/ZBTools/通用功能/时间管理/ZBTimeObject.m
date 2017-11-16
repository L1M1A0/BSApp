//
//  ZBTimeObject
//  Marketing
//
//  Created by 李振彪 on 15/12/24.
//  Copyright © 2015年 forr. All rights reserved.
//

#import "ZBTimeObject.h"
#import "ZBConvertStringObject.h"
@implementation ZBTimeObject

#pragma mark - 算日期



/** 获取自今天起n天后的日期,如今天:0,明天:1,后天:2,大后天:3,...依此类推 */
+ (NSString *)dateForOtherDayAfterToday:(NSInteger)number{
    //获取当前日期
    NSDate *  date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM月dd日"];//这里是返回的数据的格式,可以填其他的
    NSString *dateStr;
    //如果等于0,说明返回的是今天的日期, 如果反回的>0,返回的是今天之后的日期
    if (number == 0){
        dateStr = [dateFormatter stringFromDate:date];
    }
    if (number > 0) {
        NSDate *nextdate = [NSDate dateWithTimeInterval:24*60*60*number sinceDate:date];
        dateStr = [dateFormatter stringFromDate:nextdate];
    }
    return dateStr;
}


/**
 *  获取输入的日期得到今天是星期几
 *  如"2016-01-11" -> "周一"
 */
+ (NSString*)weekTimesFromDate:(NSDate *)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}


/**
 *  根据传入的时间, 获取某指定范围的时间域
 *  type取值: 一周范围
 *
 *  @return 时间域
 */
+ (NSDictionary *)weekRangeBeginAndEnd:(NSDate *)newDate{
    if (newDate == nil) {
        newDate = [NSDate date];
    }
    NSDictionary * dic = [[NSDictionary alloc]init];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设定周一为周首日
    [calendar setFirstWeekday:1];
    //分别修改range为 NSMonthCalendarUnit NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    
    //    if (ok) {
    //        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    //    }else {
    //        return;
    //    }
    //    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    //    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    //    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    //    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
        [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *beginString = [myDateFormatter stringFromDate:beginDate];
        NSString *endString = [myDateFormatter stringFromDate:endDate];
        
        dic = @{@"first":beginString,
                @"last" :endString
                };
    }
    return dic;
}



@end
