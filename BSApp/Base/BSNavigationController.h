//
//  BSNavigationController.h
//  giseGnmGkapp
//
//  Created by baothink on 16/1/12.
//  Copyright (c) 2016年 baothink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSNavigationController : UINavigationController


/**
 导航栏，渐变颜色背景

 @param navCtrl 目标导航栏
 @param color1 开始颜色
 @param color2 结束颜色
 */
+(void)navCtrl:(UINavigationController *)navCtrl color1:(UIColor *)color1 color2:(UIColor *)color2;


/**
 导航栏，设置图片为背景

 @param navCtrl 目标导航栏
 @param image1 背景图片
 @param image2 阴影图片
 */
+(void)navCtrl:(UINavigationController *)navCtrl image1:(NSString *)image1 image2:(NSString *)image2;
@end
