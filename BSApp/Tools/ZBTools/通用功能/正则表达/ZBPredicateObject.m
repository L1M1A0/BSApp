//
//  ZBPredicateObject.m
//  CloudShop
//
//  Created by BaoThink on 16/3/18.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "ZBPredicateObject.h"

@implementation ZBPredicateObject







#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString*) password{
    NSString*pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";NSPredicate  *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName:(NSString*)userName{
    NSString *pattern =@"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber:(NSString*)number{
    NSString*pattern =@"^[0-9]{12}";
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}
#pragma 正则匹配UR
+ (BOOL)checkURL : (NSString*) url{
    NSString*pattern =@"^[0-9A-Za-z]{1,50}";
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}


#pragma - 正则匹配用户身份证号15或18位
//+ (BOOL)checkUserIdCard:(NSString*)idCard{
//    NSString*pattern =@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
//    BOOL isMatch = [pred evaluateWithObject:idCard];
//    return isMatch;
//}

+ (BOOL)checkUserIdCard:(NSString *)idCard
{
    if (idCard.length <= 0) {
        return NO;
    }
    
    
    //@"^(\\d{14}|\\d{17})(\\d|[xX])$";
    //isIDCard2=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
    
    //安卓
    // "((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})" + "(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}" + "[Xx0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))";
    
    //-地区号6(大陆31省)-|----年4---|------月2-------|------日2-----------|-随机3-|-校验码-X--|
    //@"^(地区号2)\\d{4}[1-2]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|[Xx])$"
    NSString *predicateStr = @"^(11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)\\d{4}[1-2]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|[Xx])$";
    
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",predicateStr];
    BOOL isMatch = [identityCardPredicate evaluateWithObject:idCard];
    return isMatch;
}





#pragma mark - 匹配手机号码方法
//#pragma 正则匹配手机号
+ (BOOL)isMobileNumber1:(NSString *)mobileNum
{
    NSString *pattern =@"^1+[34578]+\\d{9}";
    NSPredicate  *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    return isMatch;
}
#pragma 手机号判断
+ (BOOL)isMobileNumber2:(NSString *)mobileNum{
    
    //截止至2016年5月
    //电信号段:133/149/153/173/177/180/181/189
    //联通号段:130/131/132/145/155/156/171/175/176/185/186
    //移动号段:134/135/136/137/138/139/147/150/151/152/157/158/159/178/182/183/184/187/188
    //虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|7[0135-8]|8[0-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}



/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isMobileNumber3:(NSString *)mobileNum
{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
////以上集合一起，并兼容14开头的
//+ (BOOL)isMobileNumber:(NSString *)mobileNum
//{
//
//
//    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
//    BOOL isMatch = [mobileNum isMatchedByRegex:phoneRegex];
//    return isMatch;
//}
// 判断是否是11位手机号码
- (BOOL)judgePhoneNumber:(NSString *)phoneNum
{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    
    // 一个判断是否是手机号码的正则表达式
//    NSString *pattern = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",CM_NUM,CU_NUM,CT_NUM];
//    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *mobile = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        NO;
    }
    
    return NO;
}


/**
 从一段字符串中找出手机号码

 @param str <#str description#>
 @return 手机号码数组
 */
+(NSMutableArray *)detectorPhoneNumFromStr:(NSString *)str{
    
    NSArray *arr = [NSString stringToArray:str];
    NSMutableArray *marr = [NSMutableArray array];
    NSMutableArray *temp11 = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSString *item = arr[i];
        
//        NSLog(@"shifufo——%d",[NSString isPureInt:item] );
        
        //找出连续的字符串
        if([NSString isPureInt:item] == YES) {
            
            [temp11 addObject:item];
            
            //11位的时候临时保存一次
            if (temp11.count == 11) {
                [marr addObject:[temp11 mutableCopy]];
            }else if(temp11.count > 11){
                
                //超过11位，删除最后的数组，更新最后的数组（保存当前连续的数字）
                [marr removeLastObject];
                [marr addObject:[temp11 mutableCopy]];
            }
        }else{
            //如果在连续的字符串中出现其他类型的字符串，则清空数组
            [temp11 removeAllObjects];
    
        }
    }
    
    NSMutableArray *phoneArr = [NSMutableArray array];
    for (int i = 0; i < marr.count; i++) {
        
        //如果字符长度刚好等于 11位，则正则判断字符串
        if ([marr[i] count] == 11) {
            NSString *str = [marr[i] componentsJoinedByString:@""];
            if([ZBPredicateObject isMobileNumber2:str] == YES){
                [phoneArr addObject:str];
            }
        }
    }
    
    return phoneArr;
}


@end
