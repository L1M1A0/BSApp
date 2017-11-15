//
//  UIImageView+ZBCategory.m
//  Marketing
//
//  Created by BaoThink on 16/1/27.
//  Copyright © 2016年 forr. All rights reserved.
//

#import "UIImageView+ZBCategory.h"

@implementation UIImageView (ZBCategory)

/**
 *  ZBImageView_是否允许交互
 *
 *  @param frame                  frame
 *  @param image                  图片
 *  @param userInteractionEnabled 是否允许用户交互
 *
 *  @return ZBImageView
 */
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage *)image
             userInteractionEnabled:(BOOL)userInteractionEnabled
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    imageView.userInteractionEnabled = userInteractionEnabled;
    return imageView;
}

/**
 *  设置按钮的layer属性
 *
 *  @param width        线圈的宽
 *  @param color        线圈的颜色
 *  @param boolValue    是否圆角
 *  @param cornerRadius 圆角的值
 *
 */
- (void)layerWidth:(CGFloat)width
              color:(UIColor *)color
      masksToBounds:(BOOL)boolValue
       cornerRadius:(CGFloat)cornerRadius {
    
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
    [self.layer setMasksToBounds:boolValue];
    [self.layer setCornerRadius:cornerRadius];
}

@end
