//
//  ZBAppObject.m
//  BSApp
//
//  Created by lizb on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "ZBAppObject.h"
#import "ZBDeviceAuxiliary.h"

@implementation ZBAppObject


/** 获取程序版本 */
+ (NSString *)customAppVersion1{
   
    /**
     *  警告,如果Bundle identifier 发生了改变, 一定要注意这里的变化,否则版本信息就会显示错误
     */
    
    NSString *appVersion = [NSString stringWithFormat:@"%@ V%@",[ZBDeviceAuxiliary appName],[ZBDeviceAuxiliary appVersion]];
    return appVersion;
}


+ (NSString *)customAppVersion2{
    
    NSString *appVersion = @"";
    NSString *version    = [ZBDeviceAuxiliary appVersion];
    NSString *identifier = [ZBDeviceAuxiliary bundleIdentifier];
    /**
     *  警告,如果Bundle identifier 发生了改变, 一定要注意这里的变化,否则版本信息就会显示错误
     */
    
    if ([kBaseUrl isEqualToString:kDistributionUrl]) {
        //@"正式库";
        if ([identifier isEqualToString:BundleIdentifierForApp]) {
            appVersion = [NSString stringWithFormat:@"团体版 %@",version];
        }else{
            appVersion = [NSString stringWithFormat:@"企业版 %@",version];
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




+ (BOOL)isStartAfterLoadNewVersion{
    
    BOOL isStartAfterLoadNewVersion = NO;
    NSString *oldAppVersion = [ZBUserDefault defaultValueForKey:kDefaultLastLoginVersion];

    //比较新旧版本号
    if (![oldAppVersion isEqualToString:[ZBDeviceAuxiliary appVersion]]) {
        isStartAfterLoadNewVersion = YES;
        //将新版本写入本地
        [ZBUserDefault defaultValue:[ZBDeviceAuxiliary appVersion] key:kDefaultLastLoginVersion];
        //NSLog(@"afsdbgrgre_%@",[ZBUserDefault _defaultValueForKey:kDefaultLastLoginVersion]);
    }
    return isStartAfterLoadNewVersion;
}


+ (void)saveUserLoginNum{
    BSUserModel *user = [BSLoginManager getCurrentUserInfo];
    [ZBUserDefault defaultValue:user.empCode key:kLastLoginUserName];
}
+ (NSString *)userLoginNum{
    NSString *str = [ZBUserDefault defaultValueForKey:kLastLoginUserName];
    if(str){
        return str;
    }else{
        return @"";
    }
}

@end
