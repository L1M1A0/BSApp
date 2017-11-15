//
//  ZBTime.m
//  BSApp
//
//  Created by 李振彪 on 2017/8/31.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "ZBTime.h"

@interface ZBTime (){
    
}

@end




@implementation ZBTime

#pragma mark - time


/** 根据传入格式，获取当前时间 */
+ (NSString *)currentTimeWithDateFormat:(NSString *)dateFormat{

    return [self timeWithDate:[NSDate date] dateFormat:dateFormat];
}

/**
 根据date，返回指定格式的日期字符串

 @param date 日期
 @param dateFormat 日期格式
 @return <#return value description#>
 */
+ (NSString *)timeWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    NSString *str = [formatter stringFromDate:date];
    return str;
}


/**
 根据输入的时间字符串以及其格式，将 NSString 转换成 NSDate
 输入的日期字符串形如：@"1992-05-21 13:08:08"
 */
+ (NSDate *)dateWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    return destDate;
}

#pragma mark - timeStamp

/** 时间戳转时间__createDate = 1460187597000 */
- (NSString *)timeFromTimestamp:(NSInteger )timestamp dateFormat:(NSString *)dateFormat{
    NSString *str= [NSString stringWithFormat:@"%lu",timestamp];
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}


#pragma mark - time object

/**
 获取自指定日期date起，指定天数的日期。
 
 @param date 指定日期
 @param interval 指定天数（时间间隔）0：当日，1：次日，2：后日
 @param dateFormat 时间格式
 @return 指定日期
 */
+ (NSString *)dateAfterDate:(NSDate *)date interval:(NSInteger)interval dateFormat:(NSString *)dateFormat{
    
    if (!date) {
        date = [NSDate date];//获取当前日期
    }
    
    NSString *dateStr = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:dateFormat];
    
    //如果等于0,说明返回的是今天的日期,如果反回的>0,返回的是今天之后的日期
    if (interval == 0){
        
        dateStr = [dateFormatter stringFromDate:date];
    }
    else if (interval > 0) {
        NSDate *nextdate = [NSDate dateWithTimeInterval:24*60*60*interval sinceDate:date];
        dateStr = [dateFormatter stringFromDate:nextdate];
    }else{
        
    }
    
    return dateStr;
}



/**
 根据日期，获取星期日数，如：星期一

 @param date 指定日期
 @param key  日期前缀，如@"星期"、@"周"
 @return grg
 */
+ (NSString*)weekDayWithDate:(NSDate *)date key:(NSString *)key{
    
      NSArray *weekDays = [NSArray arrayWithObjects:[NSNull null],
                           [self str1:key str2:@"日"],
                           [self str1:key str2:@"一"],
                           [self str1:key str2:@"二"],
                           [self str1:key str2:@"三"],
                           [self str1:key str2:@"四"],
                           [self str1:key str2:@"五"],
                           [self str1:key str2:@"六"],nil];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    return [weekDays objectAtIndex:theComponents.weekday];
}

+(NSString *)str1:(NSString *)str1 str2:(NSString *)str2{
    return [NSString stringWithFormat:@"%@%@",str1,str2];
}

/**(未完成)
 *  根据传入的时间,获取某指定范围的时间域
 *  type取值: 一周范围
 *
 *  @return 时间域
 */
+ (NSDictionary *)weekRangeWithDate:(NSDate *)newDate firstWeekday:(NSInteger)firstWeekday{
    if (newDate == nil) {
        newDate = [NSDate date];
    }
    NSDictionary * dic = [[NSDictionary alloc]init];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设定周一为周首日
    [calendar setFirstWeekday:firstWeekday];//1
    //分别修改range为 NSMonthCalendarUnit NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    

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
/** 根据日期，获取对应农历日期 */
+ (NSString *)lunarCalendar:(NSDate *)date{
    
    if (!date) {
        //当日
        date = [NSDate new];
    }
    //农历 NSCalendarIdentifierChinese
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSCalendar *chinese_cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    [chinese_cal setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+16:00"]];//GMT+8,虽然GMT+8是北京所在的时区,但是这里GMT+16才是正确的时间

    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [chinese_cal components:unitFlags fromDate:date];
    NSDate *china_now = [cal dateFromComponents:comps];
    NSString *str_lunar = [NSString stringWithFormat:@"%@",china_now];
    NSLog(@"农历：%@，lunar_%@",china_now,str_lunar);

    return str_lunar;
}

/**
 根据日期，获取对应农历汉语日期

 @param date 指定日期
 @return <#return value description#>
 */
+ (NSString*)lunarCalendarInChineseWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子",@"乙丑",@"丙寅",@"丁卯",@"戊辰",@"己巳",@"庚午",@"辛未",@"壬申",@"癸酉",
                             @"甲戌",@"乙亥",@"丙子",@"丁丑",@"戊寅",@"己卯",@"庚辰",@"辛己",@"壬午",@"癸未",
                             @"甲申",@"乙酉",@"丙戌",@"丁亥",@"戊子",@"己丑",@"庚寅",@"辛卯",@"壬辰",@"癸巳",
                             @"甲午",@"乙未",@"丙申",@"丁酉",@"戊戌",@"己亥",@"庚子",@"辛丑",@"壬寅",@"癸丑",
                             @"甲辰",@"乙巳",@"丙午",@"丁未",@"戊申",@"己酉",@"庚戌",@"辛亥",@"壬子",@"癸丑",
                             @"甲寅",@"乙卯",@"丙辰",@"丁巳",@"戊午",@"己未",@"庚申",@"辛酉",@"壬戌",@"癸亥",nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:@"正月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"冬月",@"腊月",nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                          @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                          @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@_%@_%@",y_str,m_str,d_str];
    NSLog(@"农历：%zd_%zd_%zd,%@",localeComp.year,localeComp.month,localeComp.day,chineseCal_str);

    return chineseCal_str;
}

/** 获取农历 返回数字模式 如:12月29日 */
+ (NSString *)lunarForNumberStr{
    
    NSString *str_lunar = [self lunarCalendar:nil];
    NSRange range_yue = NSMakeRange(5,2);
    NSRange range_ri  = NSMakeRange(8,2);
    
    NSString *yue = [str_lunar substringWithRange:range_yue];
    NSString *ri  = [str_lunar substringWithRange:range_ri];
    str_lunar = [NSString stringWithFormat:@"%@月%@日",yue,ri];
    NSLog(@"str_lunar_number = %@",str_lunar);
    return str_lunar;
}



@end
