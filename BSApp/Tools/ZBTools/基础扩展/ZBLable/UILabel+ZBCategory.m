//ZBCategory.m
//  Marketing
//
//  Created by 李振彪 on 15/12/25.
//  Copyright © 2015年 forr. All rights reserved.
//

#import "UILabel+ZBCategory.h"

@implementation UILabel (ZBCategory)


#pragma mark - 公共

+ (UILabel *)label:(CGRect)frame text:(NSString *)text tColor:(UIColor *)tColor bColor:(UIColor *)bColor{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = tColor;
    label.backgroundColor = bColor;
    return label;
}

+ (UILabel *)label:(CGRect)frame text:(NSString *)text size:(CGFloat)size view:(UIView *)view{
    UILabel *lab = [self label:frame text:text tColor:kBlackColor bColor:kWhiteColor];
    lab.font = [UIFont systemFontOfSize:size];
    [view addSubview:lab];
    return lab;
}



@end
