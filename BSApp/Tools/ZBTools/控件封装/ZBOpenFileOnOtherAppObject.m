//
//  ZBOpenFileOnOtherAppObject.m
//  Marketing
//
//  Created by 李振彪 on 16/3/29.
//  Copyright © 2016年 forr. All rights reserved.
//

#import "ZBOpenFileOnOtherAppObject.h"



@implementation ZBOpenFileOnOtherAppObject



#pragma mark - 下载文件到沙盒
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
                    progress:(void (^)(float progress))progress{
    
    //沙盒路径    //NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/xxx.zip"];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:requestURL parameters:para error:nil];
    
    //以下是手动创建request方法 AFQueryStringFromParametersWithEncoding有时候会保存
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    //   NSMutableURLRequest *request =[[[AFHTTPRequestOperationManager manager]requestSerializer]requestWithMethod:@"POST" URLString:requestURL parameters:paramaterDic error:nil];
    //
    //    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    //
    //    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    //    [request setHTTPMethod:@"POST"];
    //
    //    [request setHTTPBody:[AFQueryStringFromParametersWithEncoding(paramaterDic, NSASCIIStringEncoding) dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        NSLog(@"下载成功_____%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
        
        NSLog(@"下载失败_%@,",error);
        
    }];
    
    [operation start];
    
}

#pragma mark - 外部应用
//
//- (void)_openFileByAnotherApplication:(NSString*)string{
//    
//    //    NSString *cachePath = [NSString ];
//    NSURL *url = [NSURL fileURLWithPath:string];
//    _documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
//    _documentController.delegate = self;
//    //documentController.URL = url;
//    //[documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
//    [_documentController presentOptionsMenuFromRect:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) inView:_ViewController.view animated:YES];
//}
//
//-(void)documentInteractionController:(UIDocumentInteractionController *)controller  willBeginSendingToApplication:(NSString *)application {
//    
//    NSLog(@"__1____1");
//    
//}
//
//
//-(void)documentInteractionController:(UIDocumentInteractionController *)controller
//          didEndSendingToApplication:(NSString *)application {
//    
//    
//    NSLog(@"__1____2");
//}
//
//
//-(void)documentInteractionControllerDidDismissOpenInMenu: (UIDocumentInteractionController *)controller{
//    
//    NSLog(@"__1____3");
//    
//}
//- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller{
//    NSLog(@"__1____4");
//}
//
//
//- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
//    return _ViewController;
//}
//- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
//    return _ViewController.view;
//}
//
//- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
//{
//    return _ViewController.view.frame;
//}

@end
