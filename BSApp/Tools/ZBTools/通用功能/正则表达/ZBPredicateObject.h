//
//  ZBPredicateObject.h
//  CloudShop
//
//  Created by BaoThink on 16/3/18.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBPredicateObject : NSObject



/** 正则匹配手机号 只判断前面两位和长度（11位），缺点是没法识别实际上不存在的号段*/
+ (BOOL)isMobileNumber1:(NSString *)mobileNum;
/** 正则匹配手机号 判断前面三位，缺点是每新增一个号段就要修改或增加规则*/
+ (BOOL)isMobileNumber2:(NSString *)mobileNum;
/** 正则匹配手机号 判断精确到每个运营商，缺点是每新增一个号段就要修改或增加规则*/
+ (BOOL)isMobileNumber3:(NSString *)mobileNum;

/** 正则匹配用户密码6-18位数字和字母组合 */
+ (BOOL)checkPassword:(NSString *)password;

/** 正则匹配用户姓名,20位的中文或英文 */
+ (BOOL)checkUserName:(NSString *)userName;

/** 正则匹配用户身份证号 */
+ (BOOL)checkUserIdCard:(NSString *)idCard;

/** 正则匹员工号,12位的数字 */
+ (BOOL)checkEmployeeNumber:(NSString *)number;

/** 正则匹配URL */
+ (BOOL)checkURL:(NSString *)url;
/**
 从一段字符串中找出手机号码
 
 @param str <#str description#>
 @return 手机号码数组
 */
+(NSMutableArray *)detectorPhoneNumFromStr:(NSString *)str;
@end
