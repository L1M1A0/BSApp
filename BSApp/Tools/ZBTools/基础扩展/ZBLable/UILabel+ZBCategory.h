//
//  UILabel+ZBCategory.h
//  Marketing
//
//  Created by 李振彪 on 15/12/25.
//  Copyright © 2015年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZBCategory)


/**
 UILanle常用属性设置

 @param frame  frame
 @param text   标题
 @param tColor 标题颜色
 @param bColor 背景颜色

 @return UILanle
 */
+ (UILabel *)label:(CGRect)frame text:(NSString *)text tColor:(UIColor *)tColor bColor:(UIColor *)bColor;

/**
 UILanle常用属性设置

 @param frame frame
 @param text 标题
 @param size 字符大小
 @param view 父视图
 @return label
 */
+ (UILabel *)label:(CGRect)frame text:(NSString *)text size:(CGFloat)size view:(UIView *)view;

@end
