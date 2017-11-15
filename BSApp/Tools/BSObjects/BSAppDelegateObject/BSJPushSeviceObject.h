//
//  BSJPushSeviceObject.h
//  BSApp
//
//  Created by BaoThink on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>


// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface BSJPushSeviceObject : NSObject

/** 设置极光推送 */
- (void)setupJpushOptions:(NSDictionary *)launchOptions delegate:(id<JPUSHRegisterDelegate>)delegate;

/** 用户登录的时候,激光推送设置别名 */
- (void)setupJpushAlias;

/** 在生命周期 ApplicationWillEnterForeground 里调用*/
- (void)setupJpushBagdeWhenAppWillEnterForeground:(UIApplication *)application;

/** 在生命周期 ApplicationDidEnterBackground 里调用*/
- (void)setupJpushBagdeWhenAppDidEnterBackground;

/** 注销推送（一般用于用户推出账号时） */
- (void)cancelRemoteMessagePush;

- (NSString *)logJushSet:(NSSet *)dic;
- (NSString *)logJushDic:(NSDictionary *)dic;

@end
