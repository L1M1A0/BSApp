//
//  ZBDocumentInteractionTool.m
//  giseGnmGkapp
//
//  Created by lizb on 2016/12/28.
//  Copyright © 2016年 baothink. All rights reserved.
//

#import "ZBDocumentInteractionTool.h"


@implementation BSAttachmentModel

@end

@implementation ZBDocumentInteractionTool


- (BSAttachmentModel *)resetModelAtFirst:(BSAttachmentModel *)model{
    BOOL isLoad = [ZBSandBoxObject isDownloadedInFolder:model.fileId file:model.fileName];
    
    if (isLoad) {
        model.isLoad = 1;
    }
    else{
        model.isLoad = 0;
    }
    model.fileOriginType = @"0";
    return model;
}

- (NSInteger)openType:(BSAttachmentModel *)model{
    
    NSInteger type;
    
    if ([model.fileOriginType isEqualToString:@"0"] && model.isLoad == 0) {
        //来源网络, 没有下载, 下载然后打开
        //[self _downLoadAttachment:model];
        type = 0;
    }
    else if([model.fileOriginType isEqualToString:@"0"] && model.isLoad == 1){
        //来源网络, 且已下载, 直接本地打开
        //[self _loadFileOnWebVC:model];
        type = 1;
    }
    else{ //model.fileOriginType =@"1";
        //来源本地, 没有上传, 直接打开
        //[self _loadFileOnWebVC:model];
        type = 2;
    }
    return type;
}



- (void)openFile:(BSAttachmentModel *)model success:(void (^)(WebVC *, NSString *))success{
    NSString *filePath = @"";
    WebVC *ctrl = [[WebVC alloc]init];
    if ([model.fileOriginType isEqualToString:@"0"]) {
        
        BOOL isLoad = [ZBSandBoxObject isDownloadedInFolder:model.fileId file:model.fileName];
        if (isLoad) {
            filePath = [ZBSandBoxObject saveFileInFolder:model.fileId file:model.fileName];
            ctrl.isLocalFile = YES;
            ctrl.hideProgress = YES;
        }
        else{
//            NSMutableDictionary * para =[BSSecurityTool getParas];
//            NSDictionary *dic = @{
//                                  @"ptId":model.ptId,
//                                  @"fileId":model.fileId
//                                  };
//            //添加到这个字典数组里面
//            [para addEntriesFromDictionary:dic];
//            filePath = [NSString stringWithFormat:@"%@brs/attachment/file?%@",KWebUrl,para];
            filePath = [ZBSandBoxObject saveFileInFolder:model.fileId file:model.fileName];
            [self downLoadAttachment:model filePath:filePath];
        }
    }
    else{
        filePath = [ZBSandBoxObject saveFileInFolder:@"附件" file:model.fileName];
        ctrl.isLocalFile = YES;
        ctrl.hideProgress = YES;
    }
    
    success(ctrl,filePath);
    
//    1. webVC打开
//    ctrl.urlStr = filePath;
//    [self.navigationController pushViewController:ctrl animated:YES];
//    
//    2. 外部应用打开 或 其他方式打开
//    self openInFileOnDocumentController:<#(UIDocumentInteractionController *)#> delegate:<#(id<UIDocumentInteractionControllerDelegate>)#> view:<#(UIView *)#> filePath:<#(NSString *)#>
}


/** 从网络下载附件 */
- (void)downLoadAttachment:(BSAttachmentModel*)model filePath:(NSString *)filePath{
    
    //根据具体的地址填写
    NSString *urlStr = @"";//[NSString stringWithFormat:@"%@brs/attachment/file",KWebUrl];
    NSDictionary *dic = @{
//                          @"ptId":model.ptId,
//                          @"fileId":model.fileId
                          };
    
    NSMutableDictionary *para = [BSSafetyParameter parameterDic];
    [para addEntriesFromDictionary:dic];
    
    ZBOpenFileOnOtherAppObject *zbDown = [[ZBOpenFileOnOtherAppObject alloc]init];
    [zbDown downloadFileWithPara:para url:urlStr savedPath:filePath
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             NSLog(@"下载附件成功__%@",responseObject);
//                             [self _resetFileStatus:model];
//                             [self _loadFile:model];
                             
                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                         } progress:^(float progress) {
                             
                             NSInteger ta = progress *100;
                             NSLog(@"dfasdgs __%ld",ta);
                            
                         }];
}







- (void)openDocumentInteractionOnView:(UIView *)view delegate:(id<UIDocumentInteractionControllerDelegate>)delegate filePath:(NSString*)filePath{
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
    self.documentController.delegate = delegate;
//    self.documentController.UTI = @"asg";
//    self.documentController.i
    //documentController.URL = url;
//    [documentController presentOpenInMenuFromRect:CGRectZero inView:view animated:YES];
    //CGRectMake(0, 64, KScreenWidth, KScreenHeight-64)
    
    [self.documentController presentOptionsMenuFromRect:view.frame inView:view animated:YES];
//    self.documentController = documentController;
}


//直接复制到用到的页面
#pragma mark - UIDocumentInteractionControllerDelegate

//页面消失时重设导航栏按钮文字颜色
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    
//}
//- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
////设置导航栏返回按钮颜色
//[[UINavigationBar appearance] setTintColor:[UIColor yellowColor]];
//    return self;
//}
//- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
//    return self.view;
//}
//
//- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
//{
//    return self.view.frame;
//}


//-(void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller{
//    //设置失效
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    
//}

@end
