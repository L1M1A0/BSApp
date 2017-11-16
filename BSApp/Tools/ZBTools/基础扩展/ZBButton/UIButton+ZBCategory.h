//
//  UIButton+ZBCategory.h
//  Marketing
//
//  Created by BaoThink on 16/1/19.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZBCategory)


#pragma mark - 初始化

/**
 UIbutton 初始化

 @param frame frame
 @param title title
 @param tColor title color
 @param bgColor background color
 @param imageName imageName
 @return UIbutton
 */
+ (UIButton *)button:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor bColor:(UIColor *)bgColor imageName:(NSString *)imageName;
+ (UIButton *)button:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor;
+ (UIButton *)button:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor bColor:(UIColor *)bgColor;
+ (UIButton *)button:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor bgImageName:(NSString *)bgImageName;
+ (UIButton *)button:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor target:(id)target action:(SEL)action;


#pragma mark - 属性扩展
/**
 设置 action
 
 @param tag tag值
 @param target target
 @param action 响应方法
 */
- (void)tag:(NSInteger)tag target:(id)target action:(SEL)action;

- (void)isBtnCanUse:(BOOL)isBtnCanUse;

- (void)image:(NSString *)imgName;
@end
