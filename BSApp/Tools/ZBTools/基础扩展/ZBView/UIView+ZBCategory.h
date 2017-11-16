//
//  UIView+ZBCategory.h
//  Marketing
//
//  Created by BaoThink on 16/1/19.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZBCategory)

@property(assign, nonatomic) CGFloat x;
@property(assign, nonatomic) CGFloat y;
@property(assign, nonatomic) CGFloat width;
@property(assign, nonatomic) CGFloat height;
@property(assign, nonatomic) CGSize  size;
@property(assign, nonatomic) CGPoint origin;

/**
 阴影效果

 @param shadowColor 阴影颜色
 @param shadowOpacity 阴影透明度
 @param shadowRadius 阴影半径
 @param shadowOffset 阴影偏移
 
 注：设置阴影的同时也要设置圆角的话，需要将masksToBounds设置为NO
 */
- (void)shadowColor:(UIColor *)shadowColor opacity:(float)shadowOpacity radius:(float)shadowRadius offset:(CGSize)shadowOffset;


/**
 圆角效果

 @param borderWidth 线圈的宽
 @param borderColor 线圈的颜色
 @param masksToBounds 是否圆角
 @param cornerRadius 半径长度
 
 注：设置圆角的同时也要添加阴影的话，需要将masksToBounds设置为NO

 */
- (void)layerWidth:(CGFloat)borderWidth color:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds cornerRadius:(CGFloat)cornerRadius;


/**
 添加tapGestureRecognizer点击事件

 @param target 目标
 @param action 动作
 */
- (UITapGestureRecognizer *)tapGestureRecognizerTarget:(id)target action:(SEL)action;
@end
