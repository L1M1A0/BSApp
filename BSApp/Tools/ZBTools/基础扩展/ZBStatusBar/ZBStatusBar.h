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
 状态栏
 */
@property (nonatomic, strong) UIView *statusBar;

/**
 渐变图层
 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


/**
 设置状态栏显示风格
 
 @param statusBarStyle 风格
 */
+ (void)statusBarStyle:(UIStatusBarStyle)statusBarStyle;

/**
 设置状态栏背景颜色
 
 @param color 背景颜色
 */
+ (void)backgroundColor:(UIColor *)color;

/**
 设置状态栏的颜色为渐变色（layer）
 
 注：适合需要根据需求随时改变状态栏颜色的场景，推荐适用
 @param colors 渐变颜色数组
 */
- (void)gradientLayer:(NSArray *)colors;



@end
