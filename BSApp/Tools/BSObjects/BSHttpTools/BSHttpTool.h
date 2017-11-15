//
//  BSHttpTool.h
//  BSApp
//
//  Created by BaoThink on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "ZBHttpTool.h"


//************基于AFNetWorking的封装**************
@interface BSHttpTool : ZBHttpTool
///*****
// 
// 安全参数类型：
// 字符串类型的安全参数：                   para = @{}；
// json型的：                            para = @{@“a”:"b"}；
// 不填安全参数或者其他类型的安全参数拼接方式， para = nil；
// 
// */


///**
// 对成功返回的信息进行判断
// 
// @param object 返回的数据
// @param yes 请求返回错误
// @param no  请求返回正常
// */
//+ (void)isRequstError:(id)object yes:(void(^)(NSString *errorMessage))yes no:(void(^)(void))no;
//- (void)isRequstError:(id)object yes:(void(^)(NSString *errorMessage))yes no:(void(^)(void))no;

@end
