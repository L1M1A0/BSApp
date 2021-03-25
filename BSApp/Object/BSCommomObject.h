//
//  BSCommomObject.h
//  BSApp
//
//  Created by lizb on 2017/8/18.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"

@interface BSCommomObject : NSObject

+(UIButton *)cycleButton:(CGRect)frame image:(NSString *)image
                  target:(id)target action:(SEL)action;






/**
 返回格式 如 "¥ %.2f 元/吨  ¥%.2f "
 
 @param str1 ¥ %.2f 元/吨 中间的金额大写
 @param size str1中的特殊字符的大小
 @param str2 ¥%.2f 字体相对str1更小，中间有删除线
 @return <#return value description#>
 */
+ (NSMutableAttributedString *)atr:(double)str1 color1:(UIColor*)color1
                              str2:(double)str2 color2:(UIColor *)color2
                              size:(CGFloat)size decimalLength:(NSInteger)decimalLength;


/**
 打开QQ

 @param str QQ号码
 */
+(void)openQQ:(NSString *)str;

/**
 拨打电话

 @param str 电话号码
 */
+(void)openPhone:(NSString*)str;

/**
 复制内容到剪贴板

 @param str <#str description#>
 */
+(void)copyStrToPasteboard:(NSString *)str;


/**
 下载用户头像

 @param imageView 头像视图
 @param block 将图片转化成data
 */
+(void)loadHeadImage:(UIImageView *)imageView data:(void (^)(NSData *imageData))block;

/**
 下载图片

 @param imgId 图片id
 @param imageView <#imageView description#>
 @param placeholderImage <#placeholderImage description#>
 @param block <#block description#>
 */
+(void)loadImage:(NSString *)imgId imageView:(UIImageView *)imageView placeholderImage:(NSString *)placeholderImage data:(void (^)(NSData *imageData))block;



@end
