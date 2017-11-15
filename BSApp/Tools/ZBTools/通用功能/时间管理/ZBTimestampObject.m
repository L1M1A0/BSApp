//
//  ZBTimestampObject.m
//  giseGnmGkapp
//
//  Created by baothink on 16/4/23.
//  Copyright © 2016年 baothink. All rights reserved.
//

#import "ZBTimestampObject.h"
#import "ZBTimeObject.h"
@implementation ZBTimestampObject

#pragma mark - 时间戳转正常时间
#pragma mark 方式 1
+ (NSString *)changeTimeToStringWithTimeString:(NSString *)time
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000 ];
    NSString * str=[formatter stringFromDate:date];
    return str;
}

#pragma mark 方式 2
/** 时间来源形式_时间戳：1460187597000 */
+ (NSString *)_getTimeFromLongStrng:(NSString *)strTime type:(NSInteger)type{
    NSString *time = @"";
    NSDate * updateDate= [NSDate dateWithTimeIntervalSince1970:[strTime integerValue]/1000];
    
    time = [NSString stringWithFormat:@"%@",updateDate];
    NSArray *arr = [time componentsSeparatedByString:@" "];
    
    if (type == 0){
        //返回形式：2016-04-14 09:10:22
        time = [NSString stringWithFormat:@"%@ %@",arr[0],arr[1]];
    }
    if (type == 1) {
        //返回形式：04-14
        time = [arr firstObject];
        arr = [time componentsSeparatedByString:@"-"];
        time = [NSString stringWithFormat:@"%@-%@",arr[1],arr[2]];
    }
    return time;
}
+(NSString *)timestamp:(NSInteger)timestamp format:(NSString *)format isMS:(BOOL)isMS{
   
    //时间戳
    //    NSString *str= [NSString stringWithFormat:@"%lu",timestamp];
    //    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate;
    if (isMS == NO) {
        detaildate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    }else{
        detaildate = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;

}

#pragma mark 方式 3(最常用)
/** 时间戳转时间_createDate = 1460187597000 */
+ (NSString *)_getDateStringFromTimestamp:(NSInteger)timestamp type:(NSInteger)type{
    //时间戳
    //    NSString *str= [NSString stringWithFormat:@"%lu",timestamp];
    //    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate * detaildate=[NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    
    
    //    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    //    if (type == 0) {
    //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    }
    //    if (type == 1) {
    //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //    }
    //    if (type == 2) {
    //        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //    }
    //    if (type == 3) {
    //        [dateFormatter setDateFormat:@"MM-dd"];
    //    }
    
    switch (type) {
        case 0:{
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        }
        case 1:{
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        }
        case 2:{
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        }
        case 3:{
            [dateFormatter setDateFormat:@"MM-dd"];
            break;
        }
        case 4:{
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            break;
        }
        default:{
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        }
            
    }
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}
#pragma mark 方式 3(最常用)
/** 时间戳转时间_createDate = 1460187597000 */
+ (NSString *)_getDateStringFromTimestamp:(NSInteger)timestamp type:(NSInteger)type isMs:(BOOL)isMs{
    //时间戳
    //    NSString *str= [NSString stringWithFormat:@"%lu",timestamp];
    //    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate;
    if (isMs == NO) {
        detaildate =[NSDate dateWithTimeIntervalSince1970:timestamp];
    }else{
        detaildate=[NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (type) {
        case 0:{
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        }
        case 1:{
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        }
        case 2:{
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        }
        case 3:{
            [dateFormatter setDateFormat:@"MM-dd"];
            break;
        }
        case 4:{
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            break;
        }
        default:{
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        }
            
    }
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}

+ (NSString *)_getTimeForTimestamp:(NSInteger)timestamp{
    
    NSString *dateString = [ZBTimestampObject _getDateStringFromTimestamp:timestamp type:0];
    
    NSArray *timeArr = [ZBTimestampObject _getTimeArr:dateString];
    
    NSInteger int_Year   = [timeArr[0] integerValue];
    NSInteger int_Month  = [timeArr[1] integerValue];
    NSInteger int_Date   = [timeArr[2] integerValue];
    //    NSInteger int_Hour   = (NSInteger)timeArr[3];
    //    NSInteger int_Minute = (NSInteger)timeArr[4];
    //    NSInteger int_second = (NSInteger)timeArr[5];
    
    
    NSArray *currentTimeArr = [ZBTimestampObject _getCurrentTimeArr];
    NSInteger cur_Year   = [currentTimeArr[0] integerValue];
    NSInteger cur_Month  = [currentTimeArr[1] integerValue];
    NSInteger cur_Date   = [currentTimeArr[2] integerValue];
    //    NSInteger cur_Hour   = (NSInteger)currentTimeArr[3];
    //    NSInteger cur_Minute = (NSInteger)currentTimeArr[4];
    //    NSInteger cur_second = (NSInteger)currentTimeArr[5];
    
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

/** 获取当前的时间,并切割保存为数组 */
+ (NSArray *)_getCurrentTimeArr{
    NSString *timeStr = [ZBTimeObject currentTimeFormatter:@"yyyy-MM-dd HH:mm:ss"];
    NSArray  *timeArr = [ZBTimestampObject _getTimeArr:timeStr];
    
    return timeArr;
}

/** 将完整的是将截取成数组 */
+ (NSArray *)_getTimeArr:(NSString *)dateString{
    //    NSArray *timeArr = [NSArray array];
    //    if([dateString rangeOfString:@"-"].location == NSNotFound){
    //        timeArr = @[timeArr];
    //    }
    //    else{
    NSArray *arr_1 = [dateString componentsSeparatedByString:@" "];
    NSString *str_Year   = [arr_1[0] componentsSeparatedByString:@"-"][0];
    NSString *str_Month  = [arr_1[0] componentsSeparatedByString:@"-"][1];
    NSString *str_Date   = [arr_1[0] componentsSeparatedByString:@"-"][2];
    NSString *str_Hour   = [arr_1[1] componentsSeparatedByString:@":"][0];
    NSString *str_Minute = [arr_1[1] componentsSeparatedByString:@":"][1];
    NSString *str_second = @"00";
    if([[arr_1[1] componentsSeparatedByString:@":"] count] == 3){
        str_second = [arr_1[1] componentsSeparatedByString:@":"][2];
    }
    NSArray * timeArr = @[str_Year,str_Month,str_Date,str_Hour,str_Minute,str_second];
    //    }
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

//获取系统当前的时间戳    (*1000代表毫秒级)
+ (NSString *)currentTimeIntervalIS1000:(BOOL)is1000
{
    NSInteger a = 1;
    if (is1000 == YES) {
        a = 1000;
    }
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970] * a;
    return [NSString stringWithFormat:@"%llu",recordTime];
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
