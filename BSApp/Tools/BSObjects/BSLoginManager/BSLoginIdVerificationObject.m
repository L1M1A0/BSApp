//
//  BSLoginIdVerificationObject.m
//  BSApp
//
//  Created by 李振彪 on 16/9/6.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSLoginIdVerificationObject.h"
//#import "BSHttpTool.h"
#import "AFHTTPRequestOperationManager.h"
#import "ZBUserDefault.h"

@implementation BSLoginIdVerificationObject

+ (void)loginIdVerification:(void(^)(void))suc failure:(void(^)(void))fail{
    
    
    BSUserModel *user = [BSLoginManager getCurrentUserInfo];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@?%@",KBaseUrl(@"loginid/verification"),user.loginId,[BSSafetyParameter parameterStr]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [[NSData alloc]initWithData:responseObject];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"登录id验证成功_%@_%@",responseObject,str);
        
        if (suc) {
            suc();
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZBHttpResult *result = [[ZBHttpResult alloc]init];
        result.error = error;
        result.operation = operation;
        NSString *message = [ZBHttpError failureMessage:result];
        NSLog(@"登录id验证失败_%@",message);
        
        if (fail) {
            fail();
        }
    }];

    
    
}


@end
