//
//  BSAppObject.m
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSAppObject.h"
#import "AFNetworking.h"
#import "ZBAppObject.h"
@implementation BSAppObject

//type:统计类型，lauch:启动，activate:安装/激活
+(void)_postAppStatus:(NSString *)type{
    
    
    //AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    // 响应的类型是二进制
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", nil];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/brs/appstatistics",kBaseUrl];
    NSString *versionName = [ZBAppObject currentVersion];
    NSString *versionCode = [NSString stringWithFormat:@"%@",VERSION_CODE];
    
    NSDictionary *para = @{
                           @"versionCode":versionCode,
                           @"versionName":versionName,
                           @"platformName":@"20",
                           @"type":type
                           };
    
    
    [manager POST:urlStr parameters:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"提交应用统计信息成功__%@\n_%@",task,responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"提交应用统计信息失败__%@\n_error__%@",task,error);
        
    }];
    

    
}

+ (void)_setFirstToUse{
    NSUserDefaults *first = [NSUserDefaults standardUserDefaults];
    [first setValue:@"IS_FIRST_TO_USE_THIS_APP" forKey:@"IS_FIRST_TO_USE_THIS_APP"];
    
    //    [first setBool:tag forKey:@"IS_FIRST_TO_USE_THIS_APP"];
    [first synchronize];
}


+ (BOOL)_isFirstUse{
    BOOL isFirst = NO;
    
    NSUserDefaults *tag = [NSUserDefaults standardUserDefaults];
    //isFirst = [tag boolForKey:@"IS_FIRST_TO_USE_THIS_APP"];
    NSString *stt = [tag valueForKey:@"IS_FIRST_TO_USE_THIS_APP"];
    
    if(stt.length == 0){
        isFirst = YES;
    }
    else{
        isFirst = NO;
    }
    
    return isFirst;
}


+ (void)_postAppStatus{
    
    NSLog(@"isFirstisFirst_%d",[self _isFirstUse]);
    if ([self _isFirstUse] == YES) {
        //        NSLog(@"安装/激活启动");
        [self _postAppStatus:@"activate"];
        [self _setFirstToUse];
    }
    else{
        //        NSLog(@"平常的启动")
        [self _postAppStatus:@"lauch"];
        
    }
    
}



@end
