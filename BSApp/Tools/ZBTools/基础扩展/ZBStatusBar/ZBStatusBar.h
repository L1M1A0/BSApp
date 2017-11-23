//
//  ZBStatusBar.h
//  BSApp
//
//  Created by 李振彪 on 2017/11/23.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBStatusBar : NSObject


/**
 设置状态栏背景颜色
 @param color 背景颜色
 */
+ (void)backgroundColor:(UIColor *)color;


/**
 设置状态栏显示风格

 @param statusBarStyle 风格
 */
+ (void)statusBarStyle:(UIStatusBarStyle)statusBarStyle;

@end
