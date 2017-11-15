//
//  ZBLayer.h
//  BSApp
//
//  Created by 李振彪 on 2017/8/30.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface ZBLayer : NSObject
{
    
}


#pragma mark - CAShapeLayer



/**
 画一条虚线
 
 @param pointA 起点
 @param pointB 终点
 @param lineWidth 线宽（高）
 @param strokeColor 虚线颜色
 @param lineDashPattern 虚线块大小
 @return <#return value description#>
 */
+ (CAShapeLayer *)dottedLine:(CGPoint)pointA pointB:(CGPoint)pointB lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor lineDashPattern:(NSArray *)lineDashPattern;

/**
 根据size 生成虚线边框数组
 
 @param size 矩形的宽和高
 @param lineWidth 线宽（高）
 @param strokeColor 虚线颜色
 @param lineDashPattern 虚线块大小
 @return 返回虚线边框数组 CAShapelayer。
 */
+ (NSArray *)dottedBox:(CGSize)size lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor lineDashPattern:(NSArray *)lineDashPattern;

/**
 为矩形添加虚线边框
 
 @param view 矩形的宽和高
 @param lineWidth 线宽（高）
 @param strokeColor 虚线颜色
 @param lineDashPattern 虚线块大小
 */
+ (void)dottedBoxForView:(UIView *)view lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor lineDashPattern:(NSArray *)lineDashPattern;



/**
 取出数组中的 CAShapelayer 添加到 view 上面

 @param layers layer数组
 @param view 目标view
 */
+(void)addShapeLayers:(NSArray *)layers view:(UIView *)view;

/**
 移除view上面的 CAShapeLayer

 @param view 目标view
 */
+(void)removeShapeLayerFromView:(UIView *)view;


#pragma mark - CALayer

/** 为view添加实现layer */
+(CALayer *)layer:(CGRect)frame color:(UIColor *)color view:(UIView *)view;



/**
 为view添加投影

 @param view 目标view
 @param color 投影颜色
 @param opacity 透明度
 @param radius 圆角半径
 @param offset 偏移量
 */
+(void)shadow:(UIView *)view color:(UIColor *)color opacity:(float)opacity radius:(CGFloat)radius offset:(CGSize)offset;
@end
