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

/*A* 获取当前时间 */
+ (NSString *)currentTimeFormatter:(NSString *)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    NSString *str = [formatter stringFromDate:[NSDate date]];
    return str;
}
/*A*
 将 NSString 转换成 NSDate
 输入的日期字符串形如：@"1992-05-21 13:08:08"
 */
+ (NSDate *)dateStingToNSDate:(NSString *)dateString dateFormat:(NSString *)dateFormat{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    return destDate;
}


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




#pragma mark - 农历相关
/** 获取农历 */
+ (NSString *)chineseCalendar{
    //农历 NSCalendarIdentifierChinese
    NSCalendar *cal = [NSCalendar currentCalendar];
    //NSLog(@"now is %@",[NSDate new]);
    NSCalendar *chinese_cal = [[NSCalendar alloc] initWithCalendarIdentifier:
                               NSCalendarIdentifierChinese];
    //GMT+8,虽然GMT+8是北京所在的时区,但是这里GMT+16才是正确的时间
    [chinese_cal setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+16"]];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay |\
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [chinese_cal components:unitFlags fromDate:[NSDate new]];
    NSDate *china_now = [cal dateFromComponents:comps];
    NSLog(@"china_now = %@",china_now);
    NSString *str_lunar = [NSString stringWithFormat:@"%@",china_now];
    return str_lunar;
}

#pragma mark 农历 中文
/** 获取农历 返回中文格式 如: 腊月廿九 二月初七 */
+ (NSString *)lunarTimeForChinese{
    ZBConvertStringObject *transString = [[ZBConvertStringObject alloc]init];
    
    NSString *str_lunar = [self chineseCalendar];
    NSRange range_yue = NSMakeRange(5, 2);
    NSRange range_ri  = NSMakeRange(8, 2);
    
    NSString *yue = [str_lunar substringWithRange:range_yue];
    yue = [NSString stringWithFormat:@"%@",[transString _transformArabicNumeralsToChinese_Month:yue]];
    NSString *ri  = [str_lunar substringWithRange:range_ri];
    ri  = [NSString stringWithFormat:@"%@",[transString _transformArabicNumeralsToChinese_Day:ri]];
    str_lunar = [NSString stringWithFormat:@"%@%@",yue,ri];
    NSLog(@"str_lunar_chinese = %@",str_lunar);
    return str_lunar;
}

/** 获取农历 返回数字模式 如:12月29日 */
+ (NSString *)lunarTimeForNumberStr{
    
    NSString *str_lunar = [self chineseCalendar];
    NSRange range_yue = NSMakeRange(5, 2);
    NSRange range_ri  = NSMakeRange(8, 2);
    
    NSString *yue = [str_lunar substringWithRange:range_yue];
    NSString *ri  = [str_lunar substringWithRange:range_ri];
    str_lunar = [NSString stringWithFormat:@"%@月%@日",yue,ri];
    NSLog(@"str_lunar_number = %@",str_lunar);
    return str_lunar;
}

@end
