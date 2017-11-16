//
//  UIButton+ZBCategory.m
//  Marketing
//
//  Created by BaoThink on 16/1/19.
//  Copyright © 2016年 forr. All rights reserved.
//

#import "UIButton+ZBCategory.h"

@implementation UIButton (ZBCategory)

+ (UIButton *)button:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor{
    
    UIButton *button = [self button:frame title:title tColor:tColor bColor:kClearColor imageName:@""];
    return button;
}
+ (UIButton *)button:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor bColor:(UIColor *)bgColor{
    
    UIButton *button = [self button:frame title:title tColor:tColor bColor:bgColor imageName:@""];
    return button;
}

+ (UIButton *)button:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor bgImageName:(NSString *)bgImageName{
    
    UIButton *button = [self button:frame title:title tColor:tColor bColor:kClearColor imageName:bgImageName];
    
    return button;
}

+ (UIButton *)button:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor target:(id)target action:(SEL)action{
    UIButton *button = [self button:frame title:title tColor:tColor bColor:kClearColor imageName:@""];
    [button tag:0 target:target action:action];
    return button;
}

+ (UIButton *)button:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor bColor:(UIColor *)bgColor imageName:(NSString *)imageName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:tColor forState:UIControlStateNormal];
    [button setBackgroundImage:kImage(imageName) forState:UIControlStateNormal];
    [button setBackgroundColor:bgColor];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];//文字居左
    return button;
}



#pragma mark - 附属设置
- (void)tag:(NSInteger)tag target:(id)target action:(SEL)action{
    [self setTag:tag];
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}



- (void)isBtnCanUse:(BOOL)isBtnCanUse{
    
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






- (void)image:(NSString *)imgName{
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


@end
