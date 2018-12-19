//
//  ZBStatusBar.h
//  giseGnmGkapp
//
//  Created by LZBiao on 2018/8/23.
//  Copyright © 2018年 baothink. All rights reserved.
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
 隐藏状态栏：YES or NO
 */
@property (nonatomic, assign) BOOL statusBarHidden;




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
- (void)backgroundColor:(UIColor *)color;

/**
 设置状态栏的颜色为渐变色（layer）
 
 注：适合需要根据需求随时改变状态栏颜色的场景，推荐适用
 @param colors 渐变颜色数组
 */
- (void)gradientLayer:(NSArray *)colors;


/**
 隐藏状态栏
 
 @param isHidden YES or NO
 */
+(void)statusBarHidden:(BOOL)isHidden;
+(void)statusbarHideWithUIApplication:(BOOL)isHidden;

@end
