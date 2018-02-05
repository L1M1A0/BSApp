//
//  ZBTimeObject.h
//  Marketing
//
//  Created by 李振彪 on 15/12/24.
//  Copyright © 2015年 forr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBTimeObject : NSObject


#pragma mark - 算日期


/** 获取自今天起n天后的日期,如今天:0,明天:1,后天:2,大后天:3,...依此类推 */
+ (NSString *)dateForOtherDayAfterToday:(NSInteger)number;

/**
 *  获取输入的日期得到今天是星期几
 *  如"2016-01-11" -> "周一"
 */
+ (NSString*)weekTimesFromDate:(NSDate *)inputDate;




@end
