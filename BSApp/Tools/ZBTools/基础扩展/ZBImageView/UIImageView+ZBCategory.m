//
//  UIImageView+ZBCategory.m
//  Marketing
//
//  Created by BaoThink on 16/1/27.
//  Copyright © 2016年 forr. All rights reserved.
//

#import "UIImageView+ZBCategory.h"

@implementation UIImageView (ZBCategory)

- (void)imageUrl:(NSString *)UrlString placeholderImage:(NSString *)placeholderImage data:(void (^)(NSData *))block{
    
    __block NSData *data = [NSData data];
//    if (imgId.length>0) {
//        NSString * urlString = [NSString stringWithFormat:@"%@/%@",kBaseFile(@"loadImage"),imgId];
        NSURL * url = [NSURL URLWithString:UrlString];
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeholderImage] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                NSLog(@"下载图片失败——%@",error);
                data = UIImageJPEGRepresentation([UIImage imageNamed:placeholderImage], 0.1);
                block(data);
                
            }else{
                data = UIImageJPEGRepresentation(image, 0.1);
                block(data);
            }
        }];
//    }else{
//        self.image = [UIImage imageNamed:placeholderImage];
//        data = UIImageJPEGRepresentation([UIImage imageNamed:placeholderImage], 0.1);
//        block(data);
//    }
}

@end
