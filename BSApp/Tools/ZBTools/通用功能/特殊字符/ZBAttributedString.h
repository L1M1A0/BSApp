//
//  ZBAttributedString.h
//  CloudShop
//
//  Created by 李振彪 on 16/6/11.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBAttributedString : NSObject



/**
 设置text文字颜色格式

 @param str        原字符
 @param rColor     目标区间内的字符的颜色
 @param startIndex 表示效果range起始位置
 @param endIndex   表示效果的截止位置
 @return <#return value description#>
 */
+ (NSMutableAttributedString *)attributedStr:(NSString *)str rColor:(UIColor *)rColor start:(NSInteger)startIndex end:(NSInteger)endIndex;

/**
 多种大小的字符串
 
 @param Str 原字符
 @param size 突出的字符大小
 @param sizeRange 作用区域
 @param color 字符串颜色
 @return <#return value description#>
 */
+(NSMutableAttributedString *)differentSizeStr:(NSString *)Str size:(CGFloat)size sizeRange:(NSRange)sizeRange color:(UIColor *)color;


/**
 中间画删除线的字符串
 
 @param str 原字符
 @param color 字符串颜色
 @param lineColor 删除线颜色
 @return <#return value description#>
 */
+(NSMutableAttributedString *)deleteLineStr:(NSString *)str color:(UIColor *)color lineColor:(UIColor *)lineColor;

/**
 文字缩进样式
 
 @param str 原字符
 @param firstLineHeadIndent 首行头部缩进
 @param headIndent 头部缩进
 @param tailIndent 尾部缩进
 @param alignment 对齐方式
 @return 注意：头部缩进的值无法作用到首行（缩进）；尾部缩进的值一般为负值；
 */
+(NSMutableAttributedString *)attributedStr:(NSString *)str firstLineHeadIndent:(CGFloat)firstLineHeadIndent headIndent:(CGFloat)headIndent tailIndent:(CGFloat)tailIndent alignment:(NSTextAlignment)alignment;
@end
