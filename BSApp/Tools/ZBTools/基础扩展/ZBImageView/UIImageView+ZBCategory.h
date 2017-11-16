//
//  UIImageView+ZBCategory.h
//  Marketing
//
//  Created by BaoThink on 16/1/27.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"


@interface UIImageView (ZBCategory)


/**
 下载图片

 @param UrlString 图片url地址
 @param placeholderImage 占位图
 @param block 回调imageData，不能传入nil
 */
- (void)imageUrl:(NSString *)UrlString placeholderImage:(NSString *)placeholderImage data:(void (^)(NSData * imageData))block;
@end
