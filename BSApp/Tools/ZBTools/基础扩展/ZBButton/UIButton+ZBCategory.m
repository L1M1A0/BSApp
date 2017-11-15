//
//  UIButton+ZBCategory.m
//  Marketing
//
//  Created by BaoThink on 16/1/19.
//  Copyright © 2016年 forr. All rights reserved.
//

#import "UIButton+ZBCategory.h"

@implementation UIButton (ZBCategory)

//按钮中的文字右对齐
//[self.rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];

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
                    action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:tColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


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
                    action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundColor:bColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button setTitleColor:tColor forState:UIControlStateNormal];
    [button setTag:tag];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

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
                    action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:tColor forState:UIControlStateNormal];
    [button setBackgroundImage:bgImgame forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}




#pragma mark - 属性扩展
/**
 *  ZBButton_设置按钮的layer属性
 *
 *  @param button       需要改变layer属性的按钮
 *  @param width        线圈的宽
 *  @param color        线圈的颜色
 *  @param boolValue    是否圆角
 *  @param cornerRadius 圆角的值
 *
 *  @return ZBButton_按钮的layer属性 01
 */
- (void)_layerWidth:(CGFloat)width
              color:(UIColor *)color
      masksToBounds:(BOOL)boolValue
       cornerRadius:(CGFloat)cornerRadius {
    
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
    [self.layer setMasksToBounds:boolValue];
    [self.layer setCornerRadius:cornerRadius];
}






- (void)_setImage:(NSString *)imgName{
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    
    //设置图片显示模式，明显效果在图片比按钮大的时候出现
    //    [btn.imageView setContentMode:UIViewContentModeScaleToFill];
    
    //    [btn.imageView setContentMode:UIViewContentModeScaleAspectFill];//保持原大图，填充，但会显示不全
    //    [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];//将大图缩小，显示图片全部内容，不拉伸，缩减
    //    [btn.imageView setContentMode:UIViewContentModeRedraw];
    
    //以下为显示图片的哪一块位置的模式
    //    [btn.imageView setContentMode:UIViewContentModeCenter];
    //    [btn.imageView setContentMode:UIViewContentModeTop];
    //    [btn.imageView setContentMode:UIViewContentModeBottom];
    //    [btn.imageView setContentMode:UIViewContentModeLeft];
    //    [btn.imageView setContentMode:UIViewContentModeRight];
    //    [btn.imageView setContentMode:UIViewContentModeTopLeft];
    //    [btn.imageView setContentMode:UIViewContentModeTopRight];
    //    [btn.imageView setContentMode:UIViewContentModeBottomLeft];
    //    [btn.imageView setContentMode:UIViewContentModeBottomRight];
}


#pragma mark - 扩展样式
//按钮中添加图片和文字（非背景）****未完成
+ (UIButton *)_buttonFrame:(CGRect)frame isTitleOnLeft:(BOOL)isTitleOnLeft title:(NSString *)title imageName:(NSString *)imageName imageSize:(CGSize)imageSize{
    
    
    //调用示范
    //    UIButton *btn = [UIButton _buttonFrame:CGRectMake(50, 200, 130, 50) isTitleOnLeft:YES title:@"文字" imageName:@"add_blue" imageSize:CGSizeMake(40, 40)];
    //
    //    btn.backgroundColor = [UIColor yellowColor];
    //    [self.view addSubview:btn];
    //
    
    
    CGFloat leftGap   = 5;
    CGFloat imageY    = (frame.size.height-imageSize.height)/2;
    CGFloat textLabW  = frame.size.width-imageSize.width-leftGap * 2;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.imageView.hidden = YES;
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    //    btn.titleLabel.font = [UIFont s];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setBackgroundColor:[UIColor redColor]];
    //    [btn.titleLabel setFrame:CGRectMake(imageSize.width, 0, textLabW, frame.size.height)];
    //    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];//文字居左
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    
    // UIEdgeInsets insets = {top, left, bottom, right};
    //文字在左,图片在右
    if (isTitleOnLeft == YES) {
        //uibutton默认是左图片，右文字。
        [btn setImageEdgeInsets:UIEdgeInsetsMake(imageY, textLabW, imageY, leftGap)];
        //        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -textLabW+leftGap, 0, imageSize.width+leftGap*2)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, textLabW, 0, 0)];
        
    }
    else{
        [btn setImageEdgeInsets:UIEdgeInsetsMake(imageY, leftGap, imageY, textLabW)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,-textLabW, 0, leftGap)];
        
    }
    
    return btn;
}
-(void)isBtnCanUse:(BOOL)isBtnCanUse{

    if (isBtnCanUse == YES) {
        self.backgroundColor = kDefaultBlueColor;
        self.userInteractionEnabled = YES;
        [self setTitleColor:kWhiteColor forState:0];
    }else{
        self.backgroundColor = kGroupTableViewBackgroundColor;
        self.userInteractionEnabled = NO;
        [self setTitleColor:kGrayColor forState:0];
    }
}

@end
