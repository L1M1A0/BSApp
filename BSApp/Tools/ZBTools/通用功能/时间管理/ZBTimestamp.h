//
//  ZBTimestamp.h
//  giseGnmGkapp
//
//  Created by baothink on 16/4/23.
//  Copyright © 2016年 baothink. All rights reserved.
//

// 使用模拟器的话, 得到的时间戳会是错误的, 一般是1970年

#import <Foundation/Foundation.h>

@interface ZBTimestamp : NSObject


//获取系统当前的时间戳    (*1000代表毫秒级)
+ (NSString *)currentTimeStampIs1000:(BOOL)is1000;

#pragma mark - 时间戳转正常时间
+(NSString *)timestamp:(NSInteger)timestamp format:(NSString *)format isX1000:(BOOL)isX1000;


+ (NSString *)timeForTimestamp:(NSInteger)timestamp;

/** 获取当前的时间,拆分成每个单独元素，组成数组*/
+ (NSArray *)splitCurrentTimeToArray;

/**
 拆分时间 将完整的是将截取成数组
 
 @param dateString 正确输入格式是：1999-12-10 18:12:23
 @return 时间数组
 */
+ (NSArray *)splitTimeStringToArray:(NSString *)dateString;

/**
 将某一时间字符串如：@"1992-05-21 13:08:08"，转化成时间戳
 输入的日期字符串形如：@"1992-05-21 13:08:08"
 */
+ (NSInteger)timestampWithTimeString:(NSString *)dateString format:(NSString *)dateFormat;

/**
 格式如：1时39分09秒，数字显示颜色
 
 @param timestamp 时间戳（非毫秒级（1000））
 @param color 数字的颜色
 @isShow0 是否在数值小于0的时候，修改为0
 @return 1时39分09秒，数字显示颜色
 */
+ (NSMutableAttributedString *)attributedStringWithTimestamp:(NSInteger)timestamp color:(UIColor *)color isShow0:(BOOL)isShow0;
@end
