//
//  ZBOpenFileOnOtherAppObject.h
//  Marketing
//
//  Created by 李振彪 on 16/3/29.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperation.h"

@interface ZBOpenFileOnOtherAppObject : NSObject<UIDocumentInteractionControllerDelegate>

///** 这个必须是retain创建的全局 */
//@property(nonatomic, retain) UIDocumentInteractionController *documentController;
//
//@property(nonatomic, retain) UIViewController *ViewController;

/**
 *  @author Jakey
 *
 *  @brief  下载文件
 *
 *  @param paramDic   附加post参数
 *  @param requestURL 请求地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
- (void)downloadFileWithPara:(NSDictionary *)para
                         url:(NSString*)requestURL
                   savedPath:(NSString*)savedPath
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                    progress:(void (^)(float progress))progress;


//- (void)_openFileByAnotherApplication:(NSString*)string;


@end
