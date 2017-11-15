//
//  ZBTimestampObject.h
//  giseGnmGkapp
//
//  Created by baothink on 16/4/23.
//  Copyright © 2016年 baothink. All rights reserved.
//

// 使用模拟器的话, 得到的时间戳会是错误的, 一般是1970年

#import <Foundation/Foundation.h>

@interface ZBTimestampObject : NSObject


#pragma mark - 时间戳转正常时间
//时间戳形式：1460187597000

/** 方式1 */
+ (NSString *)changeTimeToStringWithTimeString:(NSString *)time;
/** 方式2 */
+ (NSString *)_getTimeFromLongStrng:(NSString *)strTime type:(NSInteger)type;

+(NSString *)timestamp:(NSInteger)timestamp format:(NSString *)format isMS:(BOOL)isMS;
/** 方式3 最常用,根据type获取返回指定时间格式 */
//isMs是否毫秒
+ (NSString *)_getDateStringFromTimestamp:(NSInteger)timestamp type:(NSInteger)type isMs:(BOOL)isMs;
+ (NSString *)_getDateStringFromTimestamp:(NSInteger)timestamp type:(NSInteger)type;
/** 方式3 扩展type0格式 根据时间戳 获取当前时间的时间状态. 今天, 昨天, 前天 */
+ (NSString *)_getTimeForTimestamp:(NSInteger)timestamp;


/** 方式3 扩展type0格式 分拆时间成数组 */
+ (NSArray *)_getTimeArr:(NSString *)dateString;


/** 获取当前时间完整形式,分拆时间成数组,(只适合用于当前时间) */
+ (NSArray *)_getCurrentTimeArr;

/**
 将某一时间字符串如：@"1992-05-21 13:08:08"，转化成时间戳
 输入的日期字符串形如：@"1992-05-21 13:08:08"
 */
+ (NSInteger)timestampWithTimeString:(NSString *)dateString format:(NSString *)dateFormat;
//获取系统当前的时间戳    (*1000代表毫秒级)
+ (NSString *)currentTimeIntervalIS1000:(BOOL)is1000;

/**
 格式如：1时39分09秒，数字显示颜色
 
 @param timestamp 时间戳（非毫秒级（1000））
 @param color 数字的颜色
 @isShow0 是否在数值小于0的时候，修改为
 @return 1时39分09秒，数字显示颜色
 */
+ (NSMutableAttributedString *)attributedStringWithTimestamp:(NSInteger)timestamp color:(UIColor *)color  isShow0:(BOOL)isShow0;
@end
