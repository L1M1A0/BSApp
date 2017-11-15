//
//  ZBStringSize.h
//  giseGnmGkapp
//
//  Created by baothink on 16/4/22.
//  Copyright © 2016年 baothink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBStringSize : NSObject
/**
 换行状态下, 字符串所占的Size
 
 @param string str
 @param fontSize fontsize
 @param width 区间
 @param margin 与旁边间隔
 @return <#return value description#>
 */
+ (CGSize)stringCountRow:(NSString *)string fontSize:(NSInteger)fontSize width:(CGFloat)width margin:(CGFloat)margin;

/** 获取不换行时字符的所占width */
+ (CGSize)stringCountLong:(NSString *)string fontSize:(NSInteger)fontSize;


/** iOS7后计算文本size方法*/
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

/** 获取字符串的物理大小 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size;
/** 获取字符串的高度 */
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size;
/** 获取字符串的宽度 */
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size;
@end
