//
//  ZBAppObject.m
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "ZBAppObject.h"

@implementation ZBAppObject


/** 获取程序版本 */
+ (NSString *)appVersion{
   
    //NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    /**
     *  警告,如果Bundle identifier 发生了改变, 一定要注意这里的变化,否则版本信息就会显示错误
     */
    
    
    NSString *appVersion = [NSString stringWithFormat:@"%@ V%@",[self appName],[self currentVersion]];
    //    if ([identifier isEqualToString:BundleIdentifierForAppStore]){
    //        appVersion = [NSString stringWithFormat:@"App Store版  %@",version];//即:团体版
    //    }
    //    if ([identifier isEqualToString:BundleIdentifierForEnterPrise]){
    //        appVersion = [NSString stringWithFormat:@"企业版  %@",version];//即:企业版
    //    }
    //    if ([identifier isEqualToString:BundleIdentifierForDeveloper]){
    //        appVersion = [NSString stringWithFormat:@"测试版  %@",version];//即:测试用,经常发生改变
    //    }
    return appVersion;
}

+ (NSString *)currentVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    return version;
}
+ (NSString *)appName{
    // app名称
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    return appName;
}



+ (BOOL)isStartAfterLoadNewVersion{
    
    BOOL isStartAfterLoadNewVersion = NO;
    
    NSString *oldAppVersion = [ZBUserDefault _defaultValueForKey:kDefaultLastLoginVersion];
    //比较新旧版本号
    if (![oldAppVersion isEqualToString:[self currentVersion]]) {
        isStartAfterLoadNewVersion = YES;
        //将新版本写入本地
        [ZBUserDefault _defaultValue:[ZBAppObject currentVersion] key:kDefaultLastLoginVersion];
        //NSLog(@"afsdbgrgre_%@",[ZBUserDefault _defaultValueForKey:kDefaultLastLoginVersion]);
    }
    return isStartAfterLoadNewVersion;
}


@end
