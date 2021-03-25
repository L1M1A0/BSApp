//
//  ZBHttpResult.h
//  BSApp
//
//  Created by lizb on 2017/11/10.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface ZBHttpResult : NSObject

/** AFN网络请求的operation，
 请求成功时，结果属于Success Block的，
 请求失败时，结果属于Failure Block
 */
@property (nonatomic, strong) AFHTTPRequestOperation *operation;

/** Success，原始的返回数据，未加处理 */
@property (nonatomic, strong) id responseObject;

/** Success，默认的对 responseObject 处理过后的数据 */
@property (nonatomic, strong) id object;

/** Failure，原始的错误信息，未加处理 */
@property (nonatomic, strong) NSError *error;

/** Failure，默认的对 error 处理过后的错误信息，简要错误信息 */
@property (nonatomic, copy)   NSString *message;

@end
