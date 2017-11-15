//
//  ZBDocumentInteractionTool.h
//  giseGnmGkapp
//
//  Created by 李振彪 on 2016/12/28.
//  Copyright © 2016年 baothink. All rights reserved.
//

//使用外部应用来打开文件
#import <Foundation/Foundation.h>
#import "ZBSandBoxObject.h"
#import "WebVC.h"
#import "ZBOpenFileOnOtherAppObject.h"
@class BSAttachmentModel;

#pragma mark - BSAttachmentModel

@interface BSAttachmentModel : NSObject
//网络返回的数据
@property (nonatomic,copy)NSString * ptId;
@property (nonatomic,copy)NSString * fileId;
@property (nonatomic,copy)NSString * fileSize;
@property (nonatomic,copy)NSString * fileName;


//本地添加的数据
/** 附件来源类型:0, 网络请求来的数据; 1, 本地添加的附件 */
@property (nonatomic,copy) NSString * fileOriginType;
//图片
@property (nonatomic,copy) UIImage *image;
/** 文件是否存在本地: 0, 不存在; 1, 已存在 */
@property (nonatomic,assign) NSInteger isLoad;
@end



#pragma mark - ZBDocumentInteractionTool

@interface ZBDocumentInteractionTool : NSObject

/** <#Description#> */
@property (nonatomic, strong) BSAttachmentModel *model;

/** <#Description#> */
@property (nonatomic, retain) UIDocumentInteractionController *documentController;




/**
 初始化原始的附件数据，判断附件是否已经下载

 @param model 重设后的数据，原数据不变
 @return 新的附件模型
 */
- (BSAttachmentModel *)resetModelAtFirst:(BSAttachmentModel *)model;

/**
 打开方式
 1. 来源网络, 没有下载, 下载然后打开
 ([model.fileOriginType isEqualToString:@"0"] && model.isLoad == 0) 
 
 2. 来源网络, 且已下载, 直接本地打开
 ([model.fileOriginType isEqualToString:@"0"] && model.isLoad == 1)
 
 3. 来源本地, 没有上传, 直接打开
 model.fileOriginType = @"1";

 @return
 */
- (NSInteger)openType:(BSAttachmentModel *)model;


/**
 打开保存在沙盒中的文件

 @param model    附件模型
 @param webView  webView中打开
 @param filePath 文件路径
 @param success  可以用于设置打开方式
 */
- (void)openFile:(BSAttachmentModel *)model
        success:(void (^) (WebVC *webView ,NSString *filePath))success;

/** 调用外部应用 */
- (void)openDocumentInteractionOnView:(UIView *)view
                             delegate:(id<UIDocumentInteractionControllerDelegate>)delegate
                             filePath:(NSString*)filePath;
@end
