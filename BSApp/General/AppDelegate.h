//
//  AppDelegate.h
//  BSApp
//
//  Created by 李振彪 on 2017/11/8.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTabBarCtrl.h"
#import "BSJPushSeviceObject.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;

/** <#Description#> */
@property (nonatomic, strong) BSTabBarCtrl *tabbar;
/** <#Description#> */
@property (nonatomic, strong) BSJPushSeviceObject *jPushObject;
@end

