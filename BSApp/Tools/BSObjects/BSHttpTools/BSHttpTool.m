//
//  BSHttpTool.m
//  BSApp
//
//  Created by BaoThink on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSHttpTool.h"


@interface BSHttpTool ()
{
    
}

@end


@implementation BSHttpTool

- (NSDictionary *)getParameters:(id)parameters urlStr:(NSString *)urlStr{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    if(parameters != nil){
        //使用字符串类型安全参数，直接拼接在url后面。
        if([parameters isEqualToDictionary:@{}]){
            NSString *paraS = [BSSecurityParameters parameterStr];//parameters;
            urlStr = [NSString stringWithFormat:@"%@?%@",urlStr,paraS];


            //[dic addEntriesFromDictionary:parameters];

        }
        else{//使用json类型安全参数，写在请求体里面
            dic = [BSSecurityParameters parameterDic];
            [dic addEntriesFromDictionary:parameters];
        }
    }
    //    else{
    //        dic = parameters;
    //    }

    //dic可能为空引发崩溃
    NSDictionary *para = @{@"parameters":dic,@"urlStr":urlStr};

    return para;

}


#pragma mark - 扩展方法 数据整理 方法 2

+ (void)isRequstError:(id)object yes:(void (^)(NSString *))yes no:(void (^)(void))no{

    [[[BSHttpTool alloc]init] isRequstError:object yes:^(NSString *errorMessage) {
        yes(errorMessage);
    } no:^{
        no();
    }];
}
- (void)isRequstError:(id)object yes:(void (^)(NSString *))yes no:(void (^)(void))no{

    id data;
    //判断返回的数据的类型
    if ([object isKindOfClass:[NSData class]]) {

        data = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingMutableContainers error:nil];
    }else if([object isKindOfClass:[NSDictionary class]]){

        data = object;
    }
    else{
        data = object;
    }

//    NSLog(@"dataa,__%@",[object class]);
    //获取数据的大致结构，如果包含@“errorMsg”key，就表明是失败的，但却在成功中回调
    if ([data isKindOfClass:[NSDictionary class]]) {
        //NSLog(@"data_allKeys_%@",[data allKeys]);

        if ([[data allKeys] containsObject:@"errorMsg"] == YES) {

            yes(data[@"errorMsg"]);
        }else{
            no();
        }
    }else{
        yes(kUnknowDataType);
    }
}

@end
