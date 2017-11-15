//
//  UIButton+ZBCategory.h
//  Marketing
//
//  Created by BaoThink on 16/1/19.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZBCategory)


/** btn是否可以使用 */
-(void)isBtnCanUse:(BOOL)isBtnCanUse;

/**
 *  ZBButton_最基础的设置_无需设置tag和背景颜色
 *
 *  @param frame  frame
 *  @param title  标题
 *  @param tColor 标题颜色
 *  @param target 目标 self
 *  @param action 动作
 *
 *  @return 按钮的基础设置
 */
+ (UIButton *)_buttonFrame:(CGRect)frame
                     title:(NSString *)title
                    tColor:(UIColor *)tColor
                    target:(id)target
                    action:(SEL)action;

/**
 *  ZBButton_基础+tag+背景颜色,
 *
 *  @param frame  frame
 *  @param title  标题
 *  @param tColor 标题颜色
 *  @param bColor 背景颜色
 *  @param tag    tag值
 *  @param action 动作
 *
 *  @return 按钮常用设置 01
 */
+ (UIButton *)_buttonFrame:(CGRect)frame
                     title:(NSString *)title
                    tColor:(UIColor *)tColor
                    bColor:(UIColor *)bColor
                       tag:(NSInteger)tag
                    target:(id)target
                    action:(SEL)action;

/**
 *  ZBButton_基础+背景图片
 *
 *  @param frame    frame
 *  @param title    标题
 *  @param tColor   标题颜色
 *  @param bgImgame 背景图片(普通状态)
 *  @param target   目标 self
 *  @param action   动作
 *
 *  @return 按钮常用设置 02
 */
+ (UIButton *)_buttonFrame:(CGRect)frame
                     title:(NSString *)title
                    tColor:(UIColor *)tColor
                   bgImage:(UIImage *)bgImgame
                    target:(id)target
                    action:(SEL)action;



#pragma mark - 扩展 属性

/**
 *  设置按钮的layer属性
 *
 *  @param width        线圈的宽
 *  @param color        线圈的颜色
 *  @param boolValue    是否圆角
 *  @param cornerRadius 圆角的值
 *
 */
- (void)_layerWidth:(CGFloat)width
              color:(UIColor *)color
      masksToBounds:(BOOL)boolValue
       cornerRadius:(CGFloat)cornerRadius;

/** 设置按钮图片（不是背景图片）,以及相关显示模式（大图时） */
- (void)_setImage:(NSString *)imgName;


#pragma mark - 扩展样式
//按钮中添加图片和文字（非背景）****未完成
//+ (UIButton *)_buttonFrame:(CGRect)frame isTitleOnLeft:(BOOL)isTitleOnLeft title:(NSString *)title imageName:(NSString *)imageName imageSize:(CGSize)imageSize;
@end
