//
//  NSArray+ZBCategory.h
//  Marketing
//
//  Created by BaoThink on 16/7/5.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ZBCategory)


/** 将一维数组转换成二维数组 */
+ (NSArray *)arrayTo2DArray:(NSArray *)array size:(NSInteger)size;

/** 移除数组中重复出现的字符串,重复的只保存一个 */
+ (NSArray *)removeStringWhichIsRepeatedInArrayAndSaveOne:(NSArray *)originArray;

/** 判断数组中是否包含某个字符串, 推荐使用官方方法:containsObject */
+ (BOOL)isArr:(NSArray *)arr ContainsStr:(NSString *)string;
@end
