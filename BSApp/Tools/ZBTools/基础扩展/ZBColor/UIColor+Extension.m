//
//  UIColor+Extension.m
//  BWDApp
//
//  Created by Kratos on 15/8/12.
//  Copyright (c) 2015年 Kratos. All rights reserved.
//

#import "UIColor+Extension.h"
#define SF_COLOR(RED, GREEN, BLUE, ALPHA)    [UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA]

@implementation UIColor (Extension)
+ (UIColor *)RGBWithHexColor:(NSString *)hexColor{
    
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)     return kWhiteColor;
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6)    return kWhiteColor;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}


+(UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return SF_COLOR(((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f), 1);
}


+(UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alpha{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return SF_COLOR(((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f), alpha);
    
}



/**
 渐变色
 
 更多渐变色的内容：https://www.cnblogs.com/zhouxihi/p/6295624.html
 
 @param colors 渐变颜色数组
 @param frame 渐变范围
 @return 渐变色
 */
+ (CAGradientLayer *)gradientLayer:(NSArray *)colors frame:(CGRect)frame{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    NSMutableArray *cl = [NSMutableArray array];
    for (int i = 0; i < colors.count; i++) {
        UIColor *col = colors[i];
        [cl addObject:(__bridge id)col.CGColor];
    }
    //    colors = [cl mutableCopy];
    gradientLayer.colors = colors;//@[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];//
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;//CGRectMake(0, -20, kScreenWidth, 64);
    //    [view.layer insertSublayer:gradientLayer atIndex:0];//渐变
    return gradientLayer;
}



@end
