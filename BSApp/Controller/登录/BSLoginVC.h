//
//  BSLoginVC.h
//  BSApp
//
//  Created by BaoThink on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface BSLoginVC : UIViewController



/** 登录成功后回调 */
@property(nonatomic, copy)void(^loginSuccess)(void);

/** 是否登录成功后返回 */
@property (nonatomic, assign) BOOL isLoginSuccess;


@end
