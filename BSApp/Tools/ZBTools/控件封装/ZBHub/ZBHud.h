//
//  ZBHud.h
//  BSApp
//
//  Created by 李振彪 on 2017/11/28.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ZBHud : NSObject{
    
}
/** <#Description#> */
@property (nonatomic, strong) MBProgressHUD *hud;


/** 初始化MBProgressHUD,并设置显示的文字 */
- (instancetype)initWithStr:(NSString *)str view:(UIView *)superView;

/** 延迟并移除MBProgressHUD,设置清除前显示的文字  */
- (void)hideWithStr:(NSString *)str after:(CGFloat)time;

/** 初始化并移除hud */
+ (void)initWithStr:(NSString *)str hideAfter:(CGFloat)time view:(UIView *)superView;

/** 根据数据源，设置默认字符串，以及消失时间 */
- (void)hideWithArray:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource after:(CGFloat)time;

/** 根据数据源，初始化并移除hud */
+ (void)initWithArray:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource after:(CGFloat)time view:(UIView *)superView;

/** 根据数据源，设置hud应显示的默认字符串 */
+ (NSString *)array:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource;

@end
