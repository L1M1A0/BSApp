//
//  UIImage+DrawRect.m
//  微博
//
//  Created by 6072 on 14-8-27.
//  Copyright (c) 2014年 RUI. All rights reserved.
//

#import "UIImage+DrawRect.h"

@implementation UIImage (DrawRect)

/**
 *  ZBImage_重绘图片的大小 (width, height)
 *
 *  @param image  原图
 *  @param reSize 设置新的大小(width, height)
 *
 *  @return ZBImage_重绘图片的大小
 */
+ (UIImage *)_imageSetSize:(UIImage *)image
                    toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    //加上这句代码, 重绘后的图片是尽量保持与原图的清晰度的,少了会变模糊
    //如果将 "NO" 改为 "YES" ,重绘后的圆形图片会有黑色背景(除去圆的部分)
    UIGraphicsBeginImageContextWithOptions(reSize, NO, 0);
    CGRect rect = CGRectMake(0, 0, reSize.width, reSize.height);
    [image drawInRect:rect];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


/**
 *  ZBImage_重绘图片的Frame (x, y, width, height)
 *
 *  @param souceImage 原图
 *  @param souceRect  设置新的frame
 *
 *  @return ZBImage_重绘图片的Frame (x, y, width, height)
 */
+ (UIImage *)_imageDrawRect:(UIImage *)souceImage
                       rect:(CGRect)souceRect
{
    //UIImage* image = souceImage;
    //CGRect rect = souceRect;
    UIGraphicsBeginImageContext(souceRect.size);
    UIGraphicsBeginImageContextWithOptions(souceRect.size, NO, 0);
    [souceImage drawInRect:souceRect];
    souceImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return souceImage;
}


///**
// *  ZBImage_批量重绘图片的大小
// *
// *  @param imgArr   图片数据源的数组(数组中存放图片)
// *  @param itemSize 重绘后的大小
// *
// *  @return ZBImage_批量重绘图片的大小
// */
//- (NSMutableArray *)_imageReDrawArr:(NSArray *)imgArr size:(CGSize)itemSize{
//    //NSArray *iconArray = @[[UIImage imageNamed:@"iconImg.png"]];
//    //重绘图片
//    UIImage *icon;
//    NSMutableArray *iconArr = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < [imgArr count]; i++) {
//        icon = imgArr[i];//每执行一次，获取一张图片
//        //CGSize itemSize = CGSizeMake(30, 30);//重绘后的大小
//        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0);
//        CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);//重绘后的存放位置
//        [icon drawInRect:imageRect];//正式重绘图片
//        UIImage *imageIcon = UIGraphicsGetImageFromCurrentImageContext();
//        [iconArr addObject:imageIcon];//将重绘后的图片填入到新可变数组，正式保存为数据源
//    }
//    return iconArr;
//}



@end
