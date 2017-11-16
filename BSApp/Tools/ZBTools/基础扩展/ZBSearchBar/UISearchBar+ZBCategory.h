//
//  UISearchBar+ZBCategory.h
//  CloudShop
//
//  Created by BaoThink on 16/6/28.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (ZBCategory)


#pragma mark - 初始化
/** 创建搜索框，是否移除边框线（barTintColor将会失效）  */
+(UISearchBar *)searchBarFrame:(CGRect)frame placeholder:(NSString *)placeholder removeBarBackgroundView:(BOOL)isRemoveBarBackgroundView;





#pragma mark - 扩展

/** 移除搜索框背景边框，同时会移除上下边框线（barTintColor将会失效） */
+ (void)removeBarBackgroundView:(UISearchBar *)searchBar;

/** 通过new一个设置backgroundImage方式, 移除了边框线（推荐） */
+ (void)removeBarBorderLine:(UISearchBar *)searchBar;

/** 设置cancelButton的标题(此方法默认显示cancel)，一般设置为中文的“取消” */
+ (void)setSearchBar:(UISearchBar *)searchBar cancelTitle:(NSString *)title;

@end
