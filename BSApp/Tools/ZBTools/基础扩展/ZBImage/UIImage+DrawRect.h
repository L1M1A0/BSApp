//
//  UIImage+DrawRect.h
//  微博
//
//  Created by 6072 on 14-8-27.
//  Copyright (c) 2014年 RUI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQTextView.h>
@interface UIImage (DrawRect)
/**
 *  ZBImage_重绘图片的大小 (width, height)
 *
 *  @param image  原图
 *  @param reSize 设置新的大小(width, height)
 *
 *  @return ZBImage_重绘图片的大小
 */
+ (UIImage *)_imageSetSize:(UIImage *)image
                    toSize:(CGSize)reSize;

/**
 *  ZBImage_重绘图片的Frame (x, y, width, height)
 *
 *  @param souceImage 原图
 *  @param souceRect  设置新的frame
 *
 *  @return ZBImage_重绘图片的Frame (x, y, width, height)
 */
+ (UIImage *)_imageDrawRect:(UIImage *)souceImage
                       rect:(CGRect)souceRect;


/**
 *  ZBImage_批量重绘图片的大小
 *
 *  @param imgArr   图片数据源的数组(数组中存放图片)
 *  @param itemSize 重绘后的大小
 *
 *  @return ZBImage_批量重绘图片的大小
 */
//- (NSMutableArray *)_imageReDrawArr:(NSArray *)imgArr size:(CGSize)itemSize;
@end
