//
//  WebVC.m
//  BROnlineLearning
//
//  Created by forr on 14/12/10.
//  Copyright (c) 2014年 Bori Information Technology Co., Ltd. All rights reserved.
//

#import "WebVC.h"
#import "YHWebViewProgress.h"
#import "YHWebViewProgressView.h"
//#import "NSString+URLEncodeString.h"

@interface WebVC ()<UIWebViewDelegate>

@property (strong, nonatomic) YHWebViewProgress *progressProxy;
@property(strong,nonatomic)YHWebViewProgressView *progressView;
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"url=%@",self.urlStr);
//    self.urlStr = [self.urlStr urlReplaceWithString:self.urlStr];
    // Do any additional setup after loading the view from its nib.
    [self p_initWithUI];
    
    if (self.isLocalFile == NO) {
        [self _dataFromNETRequest];
    }
    else{
        [self _dataFromLocal];
    }
    
   
}

/** 数据来自网络 */
- (void)_dataFromNETRequest{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
        [self.scanResultWebView loadRequest:request];
    });
}

/** 数据来自本地 */
- (void)_dataFromLocal{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL fileURLWithPath:self.urlStr]];
        [self.scanResultWebView loadRequest:request];
    });
}


-(void)p_initWithUI{
    //self.scanResultWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 200)];
    self.scanResultWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.scanResultWebView.delegate = self;
    self.scanResultWebView.scalesPageToFit = YES;
    [self.view addSubview:self.scanResultWebView];

    //默认下显示，0/NO状态将显示 1/YES不显示
    if(self.hideProgress == 0){
        // 创建进度条代理，用于处理进度控制
        _progressProxy = [[YHWebViewProgress alloc] init];
        
        // 创建进度条
        self.progressView = [[YHWebViewProgressView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), CGRectGetWidth(self.view.bounds), 4)];
        self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
        
        // 设置进度条
        self.progressProxy.progressView = self.progressView;
        // 将UIWebView代理指向YHWebViewProgress
        self.scanResultWebView.delegate = self.progressProxy;
        // 设置webview代理转发到self（可选）
        self.progressProxy.webViewProxy = self;
        
        // 添加到视图
        [self.navigationController.view addSubview:self.progressView];

    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.progressView removeFromSuperview];
    self.progressView = nil;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
  
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"请求失败=%@",error);
}

@end
