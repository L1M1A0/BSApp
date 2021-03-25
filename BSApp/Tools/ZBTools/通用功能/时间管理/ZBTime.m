//
//  ZBTime.m
//  BSApp
//
//  Created by lizb on 2017/8/31.
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
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 second(秒)
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






@end
