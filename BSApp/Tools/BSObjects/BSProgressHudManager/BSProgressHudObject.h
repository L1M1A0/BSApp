//
//  BSProgressHudObject.h
//  giseGnmGkapp
//
//  Created by baothink on 16/5/5.
//  Copyright © 2016年 baothink. All rights reserved.
//

/**
 *   使用说明: 要实例化一个对象
 *   MBProgressHUD *hud = [[MBProgressHUD alloc]init];
 *
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BSProgressHudObject : NSObject

/** 初始化MBProgressHUD,并设置显示的文字 */
+ (void)_initHUD:(MBProgressHUD *)hud str:(NSString *)str view:(UIView *)superView;

/** 延迟并移除MBProgressHUD,设置清除前显示的文字  */
+ (void)_hideHUD:(MBProgressHUD *)hud str:(NSString *)str After:(CGFloat)time;

//先创建，再移除
+ (void)_initHUD:(MBProgressHUD *)hud str:(NSString *)str view:(UIView *)superView hideAfter:(CGFloat)time;

+ (void)_initHUDWithStr:(NSString *)str view:(UIView *)superView hideAfter:(CGFloat)time;
/**
 默认用于数据请求
 
 @param currentArray 当前接收到的数据源（数组）
 @param dataSource 总数据源（数组）
 @param view 父视图
 @param time 显示时间
 */

/**先创建，再移除*/
+ (void)_hideWithArray:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource view:(UIView *)superView after:(CGFloat)time;
/**先创建，再移除*/
+ (void)_hideHUD:(MBProgressHUD *)hud array:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource view:(UIView *)superView after:(CGFloat)time;
/**移除已创建的*/
+ (void)_hideHUD:(MBProgressHUD *)hud array:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource after:(CGFloat)time;

//+ (void)_initHudWithStr:(NSString *)str view:(UIView *)superView;
//
//+ (void)_hideHudWithStr:(NSString *)str view:(UIView *)superView After:(CGFloat)time;





@end
