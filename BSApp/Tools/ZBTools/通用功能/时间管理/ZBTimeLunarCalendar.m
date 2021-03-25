//
//  ZBTimeLunarCalendar.m
//  BSApp
//
//  Created by lizb on 2018/1/12.
//  Copyright © 2018年 lizb. All rights reserved.
//

#import "ZBTimeLunarCalendar.h"

@implementation ZBTimeLunarCalendar
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
