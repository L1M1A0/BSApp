//
//  ZBStatusBar.m
//  BSApp
//
//  Created by 李振彪 on 2017/11/23.
//  Copyright © 2017年 李振彪. All rights reserved.
//

//参考链接http://www.jianshu.com/p/25e9c1a864be

#import "ZBStatusBar.h"

@implementation ZBStatusBar




+ (void)backgroundColor:(UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

+ (void)statusBarStyle:(UIStatusBarStyle)statusBarStyle{
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle];
}

@end
