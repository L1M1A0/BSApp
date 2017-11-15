//
//  ZBDeviceAuxiliary.m
//  BSApp
//
//  Created by 李振彪 on 2017/6/10.
//  Copyright © 2017年 BaoThink. All rights reserved.
//



#import "ZBDeviceAuxiliary.h"
#import <sys/utsname.h>

@implementation ZBDeviceAuxiliary

//待参考http://www.cnblogs.com/YYSheng/p/5550127.html




/**
 获取自定义 app 版本

 @return 如：团体版 1.1.0
 */
+ (NSString *)customAppVersion{
    
    NSString *appVersion = @"";
    NSString *version    = [self appVersion];
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    /**
     *  警告,如果Bundle identifier 发生了改变, 一定要注意这里的变化,否则版本信息就会显示错误
     */

    if ([kBaseUrl isEqualToString:kDistributionUrl]) {
        //ku = @"正式库";
        
        if ([identifier isEqualToString:BundleIdentifierForApp]) {
            appVersion = [NSString stringWithFormat:@"团体版  %@",version];//即:团体版
            
        }else{
            appVersion = [NSString stringWithFormat:@"企业版  %@",version];//即:企业版
        }
        
    }
    else {
        //@"测试库"
        if ([identifier isEqualToString:BundleIdentifierForApp]) {
            appVersion = [NSString stringWithFormat:@"测试版 %@",version];//即:测试用,经常发生改变
            
        }else{
            appVersion = [NSString stringWithFormat:@"其他测试 %@",version];//其他测试, bid没有注册的
        }
    }
    
    return appVersion;
}


/**
 获取 app 版本

 @return 如：1.1.0
 */
+ (NSString *)appVersion{
    NSString *version    = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}


/**
 获取 app 的bundleIdentifier

 @return bundleID
 */
+ (NSString *)bundleIdentifier{
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    return bundleID;
}

/**
 获取 设备系统版本

 @return 设备系统版本
 */
+ (NSString *)deviceSystemVersion{
    return  [[UIDevice currentDevice] systemVersion];
}


/**
 获取 设备系统名字

 @return 设备系统名字
 */
+ (NSString *)deviceSystemName{
    return [[UIDevice currentDevice] systemName];
}


/**
 获取设备型号

 @return 如iPhone 6
 */
+ (NSString *)deviceModel {

    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])   return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])  return @"iPhone Simulator";
    
    return platform;
    
}

@end
