//
//  UILabel+ZBCategory.h
//  Marketing
//
//  Created by 李振彪 on 15/12/25.
//  Copyright © 2015年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZBCategory)


#pragma mark - 公共
/**
 *  UILanle常用属性设置
 *
 *  @param frame  frame
 *  @param text   标题
 *  @param tColor 标题颜色
 *  @param bColor 背景颜色
 *
 *  @return UILanle常用属性设置
 */
+ (UILabel *)_labelWithFrame:(CGRect)frame
                        text:(NSString *)text
                      tColor:(UIColor *)tColor
                      bColor:(UIColor *)bColor;


/**
 *  UILabel的扩展 _01 layer层的设置 _01
 *
 *  @param width        线圈的宽
 *  @param color        线圈的颜色
 *  @param boolValue    YES / NO
 *  @param cornerRadius 圆角值
 *
 *  layer层的基本设置
 */
- (void)layerWidth:(CGFloat)width
             color:(UIColor *)color
     masksToBounds:(BOOL)boolValue
      cornerRadius:(CGFloat)cornerRadius;

/**
 *  UILabel的扩展 _02 文本相关设置 _01
 *
 *  @param label         需要设置其他属性的label
 *  @param size          字符大小
 *  @param name          字体类型
 *  @param textAlignment 字符位置
 *  @param boolValue     是否允许交互
 *
 *  @return UILabel的其他设置
 */
+ (UILabel *)_setLabel:(UILabel *)label
              fontSize:(CGFloat)size
              fontName:(NSString *)name
         textAlignment:(NSTextAlignment)textAlignment
userInteractionEnabled:(BOOL)boolValue;



//-----------------------------以上是通用的方法-----------------------------------------------------

//-----------------------------以下是极个别方法-----------------------------------------------------

#pragma mark - 个例
+ (UILabel *)_initWithFrame:(CGRect)frame text:(NSString *)text;

+ (UILabel *)_creatLabeLtext:(NSString *)text;

+ (UILabel *)_labelWithFrame:(CGRect)frame
                        text:(NSString *)text
                    isCenter:(NSInteger)center;

@end
