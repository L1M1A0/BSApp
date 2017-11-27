//
//  BSJPushSeviceObject.m
//  BSApp
//
//  Created by BaoThink on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSJPushSeviceObject.h"
#import "JPUSHService.h"
#import "BSLoginManager.h"

@implementation BSJPushSeviceObject


/** 设置极光推送 */
- (void)setupJpushOptions:(NSDictionary *)launchOptions delegate:(id<JPUSHRegisterDelegate>)delegate{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:delegate];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }

    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:kJpushAppKey
                          channel:kJpushChannel
                 apsForProduction:kJpushIsProduction
            advertisingIdentifier:nil];
}

/**
 用户登录的时候,极光推送设置别名
 */
-(void)setupJpushAlias{
    //设置别名 平台id加用户id，md5之后，然后全部转为小写
    BSUserModel *userModle = [BSLoginManager getCurrentUserInfo];
    NSString *userId = userModle.empCode;
    NSString *alias = [kPtId stringByAppendingFormat:@"_%@",userId];
    alias = [ZBEncryption MD5:alias];//MD5方法中已实现字母小写化
    //[JPUSHService setAlias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    NSLog(@"注册极光alias_%@",alias);
    
    __weak BSJPushSeviceObject * weakSelf = self;

    //放在主线程上，可以更快回调成功。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [JPUSHService setTags:nil alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            NSString *callbackString =
            [NSString stringWithFormat:@"\niResCode_%d, \ntags: %@, \nalias: %@\n", iResCode,
             [weakSelf logJushSet:iTags], iAlias];
            NSLog(@"TagsAlias服务器返回结果_%@",callbackString);
            
        }];
    });
    
  
    
}



- (NSString *)logJushSet:(NSSet *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}



// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logJushDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}



- (void)setupJpushBagdeWhenAppWillEnterForeground:(UIApplication *)application{
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)setupJpushBagdeWhenAppDidEnterBackground{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)cancelRemoteMessagePush{
    //注销远程通知(不接收推送)
    [JPUSHService setAlias:@"" callbackSelector:nil object:nil];
}




//*******************************将以下代码复制到AppDelegate.中

//#pragma mark - 极光推送设置
//
//
//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    
//    NSLog(@"注册Device Token_%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
//    [JPUSHService registerDeviceToken:deviceToken];
//}
//
//- (void)application:(UIApplication *)application
//didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
//}
//
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"收到通知:%@", [jPushObject logJushDic:userInfo]);
//    //[rootViewController addNotificationCount];
//}
//
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo
//fetchCompletionHandler:
//(void (^)(UIBackgroundFetchResult))completionHandler {
//    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"收到通知:%@", [jPushObject logJushDic:userInfo]);
//    //[rootViewController addNotificationCount];
//    
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//- (void)application:(UIApplication *)application
//didReceiveLocalNotification:(UILocalNotification *)notification {
//    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
//}



@end
