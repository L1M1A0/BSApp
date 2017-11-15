//
//  ZBDataDetector.h
//  BSApp
//
//  Created by 李振彪 on 2017/8/22.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBDataDetector : NSObject




/**
 数据探测器
 
 @param str 原字符
 @param checkingTypes 探测的数据类型
 @param resultData 探测结果
 
 注：比如手机号码与前后字符连写（或者没有使用特殊字符隔开），则无法识别
 */
+(void)detectorStr:(NSString *)str types:(NSTextCheckingTypes)checkingTypes result:(void (^)(NSTextCheckingResult *result))resultData;
@end
