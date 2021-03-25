//
//  ZBImagePickerObject.h
//  BSApp
//
//  Created by lizb on 2016/11/9.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBImagePickerObject : NSObject


/**
 调用相册

 */
- (void)selectImageFromAlbum:(id <UINavigationControllerDelegate, UIImagePickerControllerDelegate> )delegate viewController:(UIViewController *)viewController;

/**
 调用相机
 */
- (void)selectImageFromCamera:(id <UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate viewController:(UIViewController *)viewController;

/** 压缩图片, 转为500kb以下的图片 */
- (NSDictionary *)compressureImage:(UIImage *)origionImage isUnder500k:(BOOL)isUnder500k;
@end
