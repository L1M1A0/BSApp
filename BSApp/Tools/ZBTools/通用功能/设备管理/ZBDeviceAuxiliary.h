//
//  ZBDeviceAuxiliary.h
//  BSApp
//
//  Created by lizb on 2017/6/10.
//  Copyright © 2017年 BaoThink. All rights reserved.
//


//----App 辅助工具
#import <Foundation/Foundation.h>

/** 设备屏幕尺寸 */
#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#define kScreenFrame    (CGRectMake(0, 0 ,kScreenWidth,kScreenHeight))
#define kScreenCenterX  kScreenWidth/2
#define kScreenCenterY  kScreenHeight/2
#define kScreenMaxLength (MAX(kScreenWidth, kScreenHeight))
#define kScreenMinLength (MIN(kScreenWidth, kScreenHeight))

//iphone4s～6+的缩放比例
#define KAutoSizeScaleX   ((kScreenHeight>480)?(kScreenWidth/320):1.0)
#define KAutoSizeScaleY   ((kScreenHeight>480)?(kScreenHeight/568):1.0)

/** 判断设备类型 */
#define isRetina ([[UIScreen mainScreen] scale]==2)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


/** 设备型号*通过分辨率判断 */
#define is_iPhone4_4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone5_5S_5C ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone6_7_8 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone6P_7P_8P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhone12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone12_mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone12_Max_pro ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1282, 2778), [[UIScreen mainScreen] currentMode].size) : NO)

#define kIsiPhone12Series ((is_iPhone12==YES || is_iPhone12_mini ==YES || is_iPhone12_Max_pro== YES) ? YES : NO)
#define kIsMaxStatusBarSeries ((is_iPhoneX==YES || is_iPhoneXr ==YES || is_iPhoneXs== YES || is_iPhoneXs_Max== YES) ? YES : NO)


//iPhone 特性高度计算
#define kStatusBarHeight  ([ZBDeviceAuxiliary statusBarHeight])
#define kNavigationBarHeight(viewController)   ([ZBDeviceAuxiliary navigationBarHeight:viewController])
#define kTabBarHeight(viewController)   ([ZBDeviceAuxiliary tabBarHeight:viewController])
#define kTabBarHeight2 ((kIsMaxStatusBarSeries==YES || kIsiPhone12Series==YES) ? 83.0 : 49.0)


/** 设备型号*通过像素点判断 */
#define IS_IPHONE_4_OR_LESS (isPhone && kScreen_max_length < 568.0)
#define IS_IPHONE_5 (((double)[[UIScreen mainScreen] bounds].size.height) == ((double)568))
//#define IS_IPHONE_5 (isPhone && kScreen_max_length == 568.0)
#define IS_IPHONE_6 (isPhone && kScreen_max_length == 667.0)
#define IS_IPHONE_6P (isPhone && kScreen_max_length == 736.0)
#define IS_IPHONE_6s (isPhone && kScreen_max_length == 667.0)
#define IS_IPHONE_6sP (isPhone && kScreen_max_length >= 736.0)


/** 设备系统 */
//原样式，如： #define isIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]==5)
#define systemVersionFloat ([[[UIDevice currentDevice] systemVersion] floatValue])
#define systemVersionInt [[[UIDevice currentDevice] systemVersion] intValue]
#define isIOS4  systemVersionInt == 4
#define isIOS5  systemVersionInt == 5
#define isIOS6  systemVersionInt == 6
#define isIOS7  systemVersionInt == 7
#define isIOS8  systemVersionInt == 8
#define isIOS9  systemVersionInt == 9
#define isIOS10 systemVersionInt == 10
#define isIOS11 @available(iOS 11.0, *)
#define isAfterIOS4 systemVersionInt > 4
#define isAfterIOS5 systemVersionInt > 5
#define isAfterIOS6 systemVersionInt > 6
#define isAfterIOS7 systemVersionInt > 7
#define isAfterIOS8 systemVersionInt > 8
#define isAfterIOS9 systemVersionInt > 9
#define isAfterIOS10 systemVersionInt > 10
#define isAfterIOS11 systemVersionInt > 11




@interface ZBDeviceAuxiliary : NSObject



/**
 获取 app 版本
 
 @return 如：1.1.0
 */
+ (NSString *)appVersion;

/**
 获取 app 名字

 @return 我的应用
 */
+ (NSString *)appName;

/**
 获取 app 的bundleIdentifier
 
 @return bundleID
 */
+ (NSString *)bundleIdentifier;

/**
 获取 设备系统版本
 
 @return 设备系统版本
 */
+ (NSString *)deviceSystemVersion;
/**
 获取 设备系统名字
 
 @return 设备系统名字
 */
+ (NSString *)deviceSystemName;

/**
 获取设备型号
 
 @return 如iPhone 6
 */
+ (NSString *)deviceModel;


/// 获取状态栏高度
+ (CGFloat)statusBarHeight;


/// 获取导航栏高度（包含状态栏）
/// @param viewController  当前viewController，传入self
+ (CGFloat)navigationBarHeight:(UIViewController *)viewController;

/// 获取底部标签栏高度
/// @param viewController 当前viewController，传入self
+(CGFloat)tabBarHeight:(UIViewController *)viewController;

@end
