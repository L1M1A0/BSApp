//
//  ZBStringSize.m
//  giseGnmGkapp
//
//  Created by baothink on 16/4/22.
//  Copyright © 2016年 baothink. All rights reserved.
//

#import "ZBStringSize.h"

@implementation ZBStringSize



/**
 换行状态下, 字符串所占的Size

 @param string str
 @param fontSize fontsize
 @param width 区间
 @param margin 与旁边间隔
 @return <#return value description#>
 */
+ (CGSize)stringCountRow:(NSString *)string fontSize:(NSInteger)fontSize width:(CGFloat)width margin:(CGFloat)margin{

    
    UIFont *textFont = [UIFont systemFontOfSize:fontSize];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = textFont;
    
    CGSize maxSize = CGSizeMake(width - margin*2, MAXFLOAT);
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    return size;
}


/** 获取不换行时字符的所占width */
+ (CGSize)stringCountLong:(NSString *)string fontSize:(NSInteger)fontSize{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize singleLineStringSize = [string sizeWithAttributes:attributes];
//    CGSize singleLineStringSize = [string sizeWithFont:fontSize];
    //NSLog(@"cgsize is %f %f", singleLineStringSize.height, singleLineStringSize.width);
    return singleLineStringSize;
}



//注：系统判断有问题
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize textSize;
    if (isIOS6) {
        textSize = [ZBStringSize sizeWithString:string font:font constrainedToSize:size lineBreakMode:lineBreakMode];
        return textSize;
    }
    else{
        if (CGSizeEqualToSize(size, CGSizeZero)) {//返回单行文本
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
            
            textSize = [string sizeWithAttributes:attributes];
        }
        else {//返回多行文本
            //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（字体大小+行间距=行高）
            NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
            CGRect rect = [string boundingRectWithSize:size
                                               options:option
                                            attributes:attributes
                                               context:nil];
            
            textSize = rect.size;
        }
        return textSize;
    }
}



//注：系统判断有问题
+(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize resultSize = CGSizeZero;
    if (string.length <= 0) {
        return resultSize;
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        resultSize = [string boundingRectWithSize:size
                                        options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                     attributes:@{NSFontAttributeName: font}
                                        context:nil].size;
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        resultSize = [ZBStringSize sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        //        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
        //
        //        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //        [paragraphStyle setLineSpacing:2.0];
        //
        //        [attributedStr addAttribute:NSParagraphStyleAttributeName
        //                              value:paragraphStyle
        //                              range:NSMakeRange(0, [self length])];
        //        resultSize = [attributedStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
      
    
#endif
    }
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    //    if ([self containsEmoji]) {
    //        resultSize.height += 10;
    //    }
    
    

    return resultSize;
}

+(CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self sizeWithString:string font:font constrainedToSize:size].height;
}
+(CGFloat)widthWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self sizeWithString:string font:font constrainedToSize:size].width;
}


@end
