//
//  BSUpdate.m
//  BSApp
//
//  Created by 李振彪 on 2017/11/27.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import "BSUpdate.h"

@interface BSUpdate(){
    
}
/** <#Description#> */
@property (nonatomic, strong) ZBAlertController *alert;

/** <#Description#> */
@property (nonatomic, copy) NSString *appUrl;
/** ns */
@property (nonatomic, assign) NSInteger updateType;

/** <#Description#> */
@property (nonatomic, strong) NSDictionary *dic;

@end

@implementation BSUpdate




#pragma mark - 版本检测

/**
 *  版本检测更新
 */
- (void)checkAppUpdate{
    NSString *urlStr = [NSString stringWithFormat:@"%@",KBaseUrl(@"appupdate")];
    NSString *version_code = VERSION_CODE;
    NSString *platformCode = @"20";
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    if (![bundleID isEqualToString:BundleIdentifierForApp]){
        //临时
        platformCode = @"20";
    }
    
    NSDictionary *para = @{@"platformCode":platformCode,
                           @"versionCode":version_code};
    
    BSHttpTool *versionManager = [[BSHttpTool alloc]init];
    versionManager.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    versionManager.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
    __weak BSUpdate *weakSelf = self;
    
    [versionManager get:urlStr parameters:para success:^(ZBHttpResult *result) {
        weakSelf.dic = result.object[@"data"];
        NSLog(@"检测应用更新的数据_%@",weakSelf.dic);
        
        weakSelf.appUrl = [weakSelf.dic objectForKey:@"updateAddress"];
        NSString *appMessage = @"\n  新版本已经发布, 是否前往更新?";;
        //        if (![bundleID isEqualToString:BundleIdentifierForAppStore]){
        //            appMessage = [NSString stringWithFormat:@"%@",[dic valueForKey:@"updateDetail"]];
        //            appMessage = [self _message:appMessage];
        //        }
        
        //是否需要更新
        if ([[weakSelf.dic valueForKey:@"needUpdate"] integerValue]==1) {
            
            //强制更新
            if ([[weakSelf.dic valueForKey:@"forceUpdate"] integerValue]==1) {
                
                [weakSelf launchDialog:appMessage type:1];
            }
            else{
                [weakSelf launchDialog:appMessage type:0];
            }
        }
        
    } failure:^(ZBHttpResult *result) {
        NSLog(@"检测更新接口请求错误——%@",result.message);
        
    }];

}



/** 整理更新信息 */
- (NSString *)_message:(NSString *)string{
    NSArray *arr = [string componentsSeparatedByString:@"<br>"];
    NSMutableString *mStr = [NSMutableString string];
    for (int i = 0; i<arr.count; i++) {
        NSString *str1 = arr[i];
        
        mStr = [NSMutableString stringWithFormat:@"%@\n%@",mStr,str1];
        
    }
    
    return mStr;
}

/** actType: 0,非强制更新; 1,强制更新 */
- (void)launchDialog:(NSString *)message type:(NSInteger)actType{
    
    self.updateType = actType;
    NSString *cancelTitle = @"";
    NSString *localMessage = @"";
    if(self.updateType == 1){
        cancelTitle = nil;
        localMessage = [NSString stringWithFormat:@"\n%@",@"有新的版本可以更新，您需要下载新版本才能继续使用"];
        
    }else{
        cancelTitle = @"取消";
        localMessage = [NSString stringWithFormat:@"\n%@",@"有新的版本可以更新，确认后前往更新"];
    }

    
    _alert = [ZBAlertController alert:@"更新版本" messge:localMessage action1:cancelTitle handler1:^(UIAlertAction *action) {
        
    } action2:@"确定" handler2:^(UIAlertAction *action) {
        [self judgeAppUpdateAction];
    }];
    
    [self.alert alertShow:^{}];
    
}


/** 判断执行当前要更新的应用平台以及数据库类型 */
- (void)judgeAppUpdateAction{
    NSString *bundelID = [ZBDeviceAuxiliary bundleIdentifier];
    
    //判断是否是团体版
    if ([bundelID isEqualToString:BundleIdentifierForApp]){
        
        //判断团体版数据库
        if ([kBaseUrl isEqualToString:kDistributionUrl]) {
            //正式库
            [self newVersionFromAppStore];
        }
        else{
            //测试库
            [self openAppUpdateURL];
        }
    }
    else{
        //企业版
        [self openAppUpdateURL];
    }
    
}

- (void)openAppUpdateURL{
    
    __weak BSUpdate  *weakSelf = self;
    if (isIOS10 || isAfterIOS10) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.appUrl] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {
            
            //如果succss为NO（self.appUrl为空或者打开失败）,应用会直接退出
            if(success == YES){
                //强制更新
                //跳转到下载地址后将应用直接杀死，然后点击左上角返回的时候会重新调用应用。所以会一直重新请求更新接口，达到强制更新的效果
                if(weakSelf.updateType == 1){
                    [weakSelf exitApplication];
                }
            }else{
                if (weakSelf.updateType == 1) {
                    kAlert(@"提示", @"打开更新地址失败！程序将会退出。\n请前往AppStore更新");
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf exitApplication];
                    });
                }else{
                    kAlert(@"提示", @"打开更新地址失败！请前往AppStore更新");
                }
            }
            
        }];
    }else{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.appUrl]];
    }
}



- (void)newVersionFromAppStore{
    
    //本应用的链接 id=1277531091
    NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",kAppStoreId];
    
    AFHTTPRequestOperationManager *versionManager = [AFHTTPRequestOperationManager manager];
    [versionManager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *responseDict = responseObject;
        NSArray *infoArr = [responseDict objectForKey:@"results"];
        
        if (infoArr.count > 0) {
            NSDictionary *infoDict = [infoArr objectAtIndex:0];
            //已经上线程序的版本号
            NSString *lastVersion = [infoDict objectForKey:@"version"];
            //已经上线的程序的地址
            self.appUrl = [NSString stringWithFormat:@"%@",[infoDict objectForKey:@"trackViewUrl"]];
            NSLog(@"已经上线的版本_%@,地址:_%@",lastVersion,self.appUrl);
            //NSString *releaseNotes = [NSString stringWithFormat:@"%@",[infoDict objectForKey:@"releaseNotes"]];
            
            //取得本地程序的版本号
            NSString *localVersion = [ZBDeviceAuxiliary appVersion];
            NSLog(@"app版本判别local_%@,last_%@",localVersion,lastVersion);
            
            //判断版本号是否相同, 线上版本永远不会小于本地版本, 可以相等
            if (![lastVersion isEqualToString:localVersion]) {
                [self openAppUpdateURL];
            }
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"团体版检测更新错误_%@",error);
        
    }];
    
    
}

#pragma mark - 退出应用
- (void)exitApplication {
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.window cache:NO];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    //self.widow.bounds = CGRectMake(0, 0, 0, 0);
    [UIView commitAnimations];
}
- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
}
@end
