//
//  BSAppDelegateObject.h
//  BSApp
//
//  Created by BaoThink on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

//用于AppDelegate中的基础预设

#import <Foundation/Foundation.h>

@interface BSAppDelegateObject : NSObject<UIAlertViewDelegate>

/** 监听网络 */
- (void)setupNetworkReachability;

/** 注册键盘助理 */
- (void)setupKeyboardManager;


@end
