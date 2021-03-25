//
//  ZBHttpError.h
//  BSApp
//
//  Created by lizb on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBHttpError : NSObject

+ (NSString *)failureMessage:(ZBHttpResult *)result;

+ (NSString *)failureMessage:(AFHTTPRequestOperation *)operation error:(NSError *)error;

@end
