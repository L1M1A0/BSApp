//
//  ZBAttributedString.m
//  CloudShop
//
//  Created by 李振彪 on 16/6/11.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "ZBAttributedString.h"

@implementation ZBAttributedString



/** 设置text文字颜色格式,rLocal表示效果range起始位置, range范围是lacal到倒数第二个字符串 */
+ (NSMutableAttributedString *)attributedStr:(NSString *)str rColor:(UIColor *)rColor start:(NSInteger)startIndex end:(NSInteger)endIndex{
    NSMutableAttributedString *maStr = [[NSMutableAttributedString alloc]initWithString:str];

    [maStr addAttribute:NSForegroundColorAttributeName value:rColor range:NSMakeRange(startIndex, maStr.length-startIndex-endIndex)];
    return maStr;
}



/**
 多种大小的字符串

 @param Str <#Str description#>
 @param size 突出的字符大小
 @param sizeRange 作用区域
 @param color 字符串颜色
 @return <#return value description#>
 */
+(NSMutableAttributedString *)differentSizeStr:(NSString *)Str size:(CGFloat)size sizeRange:(NSRange)sizeRange color:(UIColor *)color{
    
    //NSString *aStr = [NSString stringWithFormat:@"¥ %.2f 元/吨 ",str1];
    NSMutableAttributedString *maStr = [[NSMutableAttributedString alloc]initWithString:Str];
    [maStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:sizeRange];
    if (color != nil) {
        [maStr addAttribute:NSForegroundColorAttributeName value:color  range:NSMakeRange(0, Str.length)];

    }
    
    return maStr;
}



/**
 中间画删除线的字符串

 @param str <#str description#>
 @param color 字符串颜色
 @param lineColor 删除线颜色
 @return <#return value description#>
 */
+(NSMutableAttributedString *)deleteLineStr:(NSString *)str color:(UIColor *)color lineColor:(UIColor *)lineColor{
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, str.length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:lineColor range:NSMakeRange(0, str.length)];
    [attri addAttribute:NSBaselineOffsetAttributeName value:@(0)  range:NSMakeRange(0, str.length)];
    [attri addAttribute:NSForegroundColorAttributeName value:color  range:NSMakeRange(0, str.length)];
    
    return attri;
}


/**
 文字缩进样式

 @param str 原字符
 @param firstLineHeadIndent 首行头部缩进
 @param headIndent 头部缩进
 @param tailIndent 尾部缩进
 @param alignment 对齐方式
  注意：1. 头部缩进的值无法作用到首行（缩进）；
       2. 尾部缩进的值一般为负值；
       3. 左对齐时，取headIndent的缩进值；右对齐时，取tailIndent的缩进值
 */
+(NSMutableAttributedString *)attributedStr:(NSString *)str firstLineHeadIndent:(CGFloat)firstLineHeadIndent headIndent:(CGFloat)headIndent tailIndent:(CGFloat)tailIndent alignment:(NSTextAlignment)alignment{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = alignment;//NSTextAlignmentJustified;// 对齐方式
    style.firstLineHeadIndent = firstLineHeadIndent; //10.0f;// 首行缩进
    style.headIndent = headIndent;//10.0f;//头部缩进
    style.tailIndent = tailIndent;//-10.0f;// 尾部缩进
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:str attributes:@{ NSParagraphStyleAttributeName : style}];
    return attrText;
}

@end
