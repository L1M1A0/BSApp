//ZBCategory.m
//  Marketing
//
//  Created by 李振彪 on 15/12/25.
//  Copyright © 2015年 forr. All rights reserved.
//

#import "UILabel+ZBCategory.h"

@implementation UILabel (ZBCategory)


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
                      bColor:(UIColor *)bColor{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = tColor;
    label.backgroundColor = bColor;
    return label;
}



/**
 *  UILabel的扩展 _01 layer层的设置 _01
 *
 *  @param label        需要设置层的label
 *  @param width        线圈的宽
 *  @param color        线圈的颜色
 *  @param boolValue    YES / NO
 *  @param cornerRadius 圆角值
 *
 *  @return layer层的基本设置
 */
- (void)layerWidth:(CGFloat)width
             color:(UIColor *)color
     masksToBounds:(BOOL)boolValue
      cornerRadius:(CGFloat)cornerRadius{
    
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
    [self.layer setMasksToBounds:boolValue];
    [self.layer setCornerRadius:cornerRadius];
}

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
userInteractionEnabled:(BOOL)boolValue{
    
    if ([name isEqualToString:@""]) {
        label.font = [UIFont systemFontOfSize:size];
    }else{
        label.font = [UIFont fontWithName:name size:size];

    }
    
    label.textAlignment = textAlignment;
    label.userInteractionEnabled = boolValue;
    return label;
}

#pragma mark - 个例

+ (UILabel *)_initWithFrame:(CGRect)frame text:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

+ (UILabel *)_creatLabeLtext:(NSString *)text{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 35)];
    lab.text = text;
    lab.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    lab.textAlignment = NSTextAlignmentRight;
    lab.font = [UIFont systemFontOfSize:14];
    //lab.backgroundColor = [UIColor redColor];
    return lab;
}
+ (UILabel *)_labelWithFrame:(CGRect)frame
                        text:(NSString *)text
                    isCenter:(NSInteger)center{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    if (center == 0){
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:10];
    }
    if (center == 1){
        label.textAlignment = NSTextAlignmentCenter;
        //label.font = [UIFont systemFontOfSize:13];
        label.font = [UIFont systemFontOfSize:13 weight:2];
    }
    if (center == 2) {
        label.textAlignment = NSTextAlignmentRight;
    }
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    return label;
}




@end
