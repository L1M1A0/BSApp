//
//  ZBTimestamp.m
//  giseGnmGkapp
//
//  Created by baothink on 16/4/23.
//  Copyright © 2016年 baothink. All rights reserved.
//

#import "ZBTimestamp.h"
#import "ZBTimeObject.h"
#import "ZBTime.h"
@implementation ZBTimestamp

//获取系统当前的时间戳    (*1000代表毫秒级)
+ (NSString *)currentTimeStampIs1000:(BOOL)is1000
{
    NSInteger a = 1;
    if (is1000 == YES) {
        a = 1000;
    }
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970] * a;
    return [NSString stringWithFormat:@"%llu",recordTime];
}


#pragma mark - 时间戳转正常时间
+(NSString *)timestamp:(NSInteger)timestamp format:(NSString *)format isX1000:(BOOL)isX1000{
   
    //时间戳
    //NSString *str= [NSString stringWithFormat:@"%lu",timestamp];
    //NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *date;
    if (isX1000 == NO) {
        date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    }else{
        date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    //[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    //[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;

}


+ (NSString *)timeForTimestamp:(NSInteger)timestamp{
    
    NSString *dateString = [self timestamp:timestamp format:@"yyyy-MM-dd HH:mm:ss" isX1000:NO];
    NSArray *timeArr = [self splitTimeStringToArray:dateString];
    
    NSInteger int_Year   = [timeArr[0] integerValue];
    NSInteger int_Month  = [timeArr[1] integerValue];
    NSInteger int_Date   = [timeArr[2] integerValue];
    //NSInteger int_Hour   = (NSInteger)timeArr[3];
    //NSInteger int_Minute = (NSInteger)timeArr[4];
    //NSInteger int_second = (NSInteger)timeArr[5];
    
    
    NSArray *currentTimeArr = [self splitCurrentTimeToArray];
    NSInteger cur_Year   = [currentTimeArr[0] integerValue];
    NSInteger cur_Month  = [currentTimeArr[1] integerValue];
    NSInteger cur_Date   = [currentTimeArr[2] integerValue];
    //NSInteger cur_Hour   = (NSInteger)currentTimeArr[3];
    //NSInteger cur_Minute = (NSInteger)currentTimeArr[4];
    //NSInteger cur_second = (NSInteger)currentTimeArr[5];
    
    //NSLog(@"\n_time__%ld,%ld,%ld",int_Year,int_Month,int_Date);
    //NSLog(@"\n_tim2__%ld,%ld,%ld",cur_Year,cur_Month,cur_Date);
    
    NSString *showTime = @"";
    
    if (cur_Year - int_Year>0) {
        //年+月+日+时 分秒 年外
        showTime = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@:%@",timeArr[0],timeArr[1],timeArr[2],timeArr[3],timeArr[4],timeArr[5]];
    }
    else if(cur_Year - int_Year == 0 && cur_Month - int_Month > 0){
        //月+日+时+分+秒 月外
        showTime = [NSString stringWithFormat:@"%@月%@日 %@:%@:%@",timeArr[1],timeArr[2],timeArr[3],timeArr[4],timeArr[5]];
        
    }
    else if(cur_Year - int_Year == 0 && cur_Month - int_Month == 0 && cur_Date - int_Date != 0){
        
        if (cur_Date - int_Date == 1){
            //昨天+时+分+秒
            showTime = [NSString stringWithFormat:@"昨天 %@:%@:%@",timeArr[3],timeArr[4],timeArr[5]];
        }
        else{//cur_Date - int_Date > 1
            //月+日+时+分+秒 月内
            showTime = [NSString stringWithFormat:@"%@月%@日 %@:%@:%@",timeArr[1],timeArr[2],timeArr[3],timeArr[4],timeArr[5]];
        }
    }
    else{//年-年=0,月-月=0,日-日=0
        //今天+时+分+秒
        showTime = [NSString stringWithFormat:@"今天 %@:%@:%@",timeArr[3],timeArr[4],timeArr[5]];
        
    }
    
    return showTime;
}

/** 获取当前的时间,拆分成每个单独元素，组成数组*/
+ (NSArray *)splitCurrentTimeToArray{
  
    NSString *timeStr = [ZBTime currentTimeWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSArray  *timeArr = [self splitTimeStringToArray:timeStr];
    return timeArr;
}


/**
 拆分时间 将完整的是将截取成数组

 @param dateString 正确输入格式是：1999-12-10 18:12:23
 @return 时间数组
 */
+ (NSArray *)splitTimeStringToArray:(NSString *)dateString{

    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    NSArray *date = [arr[0] componentsSeparatedByString:@"-"];
    NSArray *time = [arr[1] componentsSeparatedByString:@":"];

//    NSString *year   = date[0];
//    NSString *month  = date[1];
//    NSString *day    = date[2];
//    NSString *hour   = time[0];
//    NSString *minute = time[1];
    NSString *second = @"00";
    if([time count] == 3){
        second = time[2];
    }
    NSArray * timeArr = @[date[0],date[1],date[2],time[0],time[1],second];
    return timeArr;
}


/**
 将某一时间字符串如：@"1992-05-21 13:08:08"，转化成时间戳
 输入的日期字符串形如：@"1992-05-21 13:08:08"
 */
+ (NSInteger)timestampWithTimeString:(NSString *)dateString format:(NSString *)dateFormat{
    
    //将 NSString 转换成 NSDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    if ([dateFormat isEqualToString:@"yyyy-MM-dd HH:mm:ss"]) {
        //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    }
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSInteger timestamp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timestamp;
}




/**
 格式如：1时39分09秒，数字显示颜色
 
 @param timestamp 时间戳（非毫秒级（1000））
 @param color 数字的颜色
 @isShow0 是否在数值小于0的时候，修改为0
 @return 1时39分09秒，数字显示颜色
 */
+ (NSMutableAttributedString *)attributedStringWithTimestamp:(NSInteger)timestamp color:(UIColor *)color isShow0:(BOOL)isShow0{
    NSInteger hour = 0;
    NSInteger min  = 0;
    NSInteger miao = 0;
    
    hour = timestamp/3600;
    min  = (timestamp-hour*3600)/60;
    miao = timestamp % 60;
    //NSLog(@"计算时分秒——%ld,%ld,%ld,%ld",self.currtime,hour,min,miao);
    
    if (isShow0 == YES) {
        if (hour <= 0) {
            hour = 0;
            if (min <= 0) {
                min = 0;
                if (miao < 0) {
                    miao = 0;
                }
            }
        }
    }
    
    
    NSMutableAttributedString *astr = [ZBAttributedString attributedStr:[NSString stringWithFormat:@"%ld时",hour] rColor:color start:0 end:1];
    NSMutableAttributedString *bstr = [ZBAttributedString attributedStr:[NSString stringWithFormat:@"%ld分",min] rColor:color start:0 end:1];
    NSMutableAttributedString *cstr = [ZBAttributedString attributedStr:[NSString stringWithFormat:@"%ld秒",miao] rColor:color start:0 end:1];
    [astr appendAttributedString:bstr];
    [astr appendAttributedString:cstr];
    
    return astr;
    
}

@end
