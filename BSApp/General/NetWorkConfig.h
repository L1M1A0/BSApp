//
//  NetWorkConfig.h
//  BSApp
//
//  Created by BaoThink on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#ifndef NetWorkConfig_h
#define NetWorkConfig_h


//********************************数据库 * 测试*********************************

/** 基础业务链接 */
//#define kBaseUrl      @"http://192.168.18.114:8090/ecp-zfl-mobile-api"
//#define KBaseUrl(s)  [@"http://192.168.18.114:8090/ecp-zfl-mobile-api/" stringByAppendingString:s]
//#define kBaseFile(s) [@"http://192.168.18.114:8090/ecp-zfl-mobile-api/fileserver/" stringByAppendingString:s]


//********************************数据库 * 正式*********************************

//阿里云 com.baothink.dianxian（以下是临时正式地址） //原：http://119.23.34.4:8090
#define kBaseUrl      @""
#define KBaseUrl(s)  [@"/" stringByAppendingString:s]
#define kBaseFile(s) [@"/" stringByAppendingString:s]

#define kDistributionUrl @"未配置"

//********************************开启 https 模式*********************************
//注：需要在这个类文件中修改 kIsHttpsModel 的值为“YES”或者"NO"就可以了
//1. 将 kIsHttpsModel 设置为YES，表示启用 Https 传输协议。
//2. 必须同步修改Pods工程中"PodHttpManager.h"的 kIsHttpsModel 的值，保持结果一致。
//3. 无需再进入两个类文件中做调整，"AFURLConnectionOperation.m"

//是否是 Https 模式
#define kIsHttpsModel NO


//********************************标识符 以及其他重要设置*********************************

//------------------------ 检测更新功能的设置

/** 版本代码：团体版测试库更新 */
//#define VERSION_CODE @"4"

/** 版本代码：企业版正式库更新 */
//#define VERSION_CODE @"2"

/** 版本代码：团体版正式库更新 */
#define VERSION_CODE @"5"

/** appid：链接到AppStore上面的ID,一经确定后不能需改 */
#define appIdInAppStore @"1277531091"

//------------- App 设置------------

/** 团体版AppID */ //（开发版和发布版共用）
#define BundleIdentifierForApp @""

/** 企业版AppID */
//#define BundleIdentifierForApp @"com.未设置.bbb"

/** app 系统默认平台ID */
#define kPtId @"PT10000"
/** app 系统id */
#define kSysId @""


//********************************推送 * 相关设置*********************************

//------测试库 com.bao.developer
static NSString *kJpushAppKey  = @"60fb30fe99fbcbf13204599a";
static BOOL kJpushIsProduction = FALSE;

//------正式库 com.bao.developer
//static NSString *kJpushAppKey  = @"";
//static BOOL kJpushIsProduction = TRUE;

//------公用
static NSString *kJpushChannel = @"Publish channel";


#endif /* NetWorkConfig_h */
