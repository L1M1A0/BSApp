//
//  UIColor+Extension.h
//  BWDApp
//
//  Created by Kratos on 15/8/12.
//  Copyright (c) 2015年 Kratos. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 基础颜色 */
#define kBlackColor     [UIColor blackColor]      // 0.0 white
#define kDarkGrayColor  [UIColor darkGrayColor]   // 0.333 white
#define kLightGrayColor [UIColor lightGrayColor]  // 0.667 white
#define kWhiteColor     [UIColor whiteColor]      // 1.0 white
#define kGrayColor      [UIColor grayColor]       // 0.5 white
#define kRedColor       [UIColor redColor]        // 1.0, 0.0, 0.0 RGB
#define kGreenColor     [UIColor greenColor]      // 0.0, 1.0, 0.0 RGB
#define kBlueColor      [UIColor blueColor]       // 0.0, 0.0, 1.0 RGB
#define kCyanColor      [UIColor cyanColor]       // 0.0, 1.0, 1.0 RGB
#define kYellowColor    [UIColor yellowColor]     // 1.0, 1.0, 0.0 RGB
#define kMagentaColor   [UIColor magentaColor]    // 1.0, 0.0, 1.0 RGB
#define kOrangeColor    [UIColor orangeColor]     // 1.0, 0.5, 0.0 RGB
#define kPurpleColor    [UIColor purpleColor]     // 0.5, 0.0, 0.5 RGB
#define kBrownColor     [UIColor brownColor]      // 0.6, 0.4, 0.2 RGB
#define kClearColor     [UIColor clearColor]      // 0.0 white, 0.0
#define kGroupTableViewBackgroundColor [UIColor groupTableViewBackgroundColor]

/** 快速RGB */
#define RGB(r, g, b)         [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

/** 常用颜色 */
#define kDefaultBlueColor       RGB(0,133,255)



@interface UIColor (Extension)

/**
 根据十六进制颜色码，转换成RGB UIColor
 
 @param hexColor 十六进制颜色码 如：#F0F0F0
 @return RGB颜色
 */
+ (UIColor *)RGBWithHexColor:(NSString *)hexColor;

/**
 渐变色
 
 更多渐变色的内容：https://www.cnblogs.com/zhouxihi/p/6295624.html
 
 @param colors 渐变颜色数组
 @param frame 渐变范围
 @return 渐变色
 */
+ (CAGradientLayer *)gradientLayer:(NSArray *)colors frame:(CGRect)frame;

@end
