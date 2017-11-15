//
//  BSAppDelegateObject.m
//  BSApp
//
//  Created by BaoThink on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSAppDelegateObject.h"
#import "AFNetworkReachabilityManager.h"
#import "IQKeyboardManager.h"
#import "BSLoginManager.h"

@implementation BSAppDelegateObject


/** 监听网络 */
- (void)setupNetworkReachability
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            {
                NSLog(@"未知网络");
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            {
                UIAlertView *aler =[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不可用，请检查网络连接是否正常" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                [aler show];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            {
                NSLog(@"手机自带网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
            {
                NSLog(@"WIFI");
                break;
            }
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}


/** 注册键盘助理 */
- (void)setupKeyboardManager
{
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}



/** 获取当前时间 */
- (NSInteger)_getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYYMMdd";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSInteger time = [str integerValue];
    return time;
}



@end
