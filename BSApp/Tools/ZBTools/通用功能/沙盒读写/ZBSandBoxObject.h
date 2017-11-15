//
//  ZBSandBoxObject.h
//  CloudShop
//
//  Created by 李振彪 on 16/4/3.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBSandBoxObject : NSObject


/** 文件保存，文件夹名为nil或者@“”，将直接保存在D路径下 */
+ (NSString *)saveFileInFolder:(NSString *)folderName file:(NSString *)fileName;


/** 检测沙盒，判断文件是否已经下载，文件夹名为nil或者@“”，将直接检测在直属D路径下的文件*/
+ (BOOL)isDownloadedInFolder:(NSString*)folderName file:(NSString *)fileName;


+ (void)createTxt:(NSString *)string fileName:(NSString *)fileName;

- (NSString *)getMessgeFromFile:(NSString *)fileName;
@end
