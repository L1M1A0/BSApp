//
//  BSLoginIdVerificationObject.h
//  BSApp
//
//  Created by lizb on 16/9/6.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSLoginIdVerificationObject : NSObject

+ (void)loginIdVerification:(void(^)(void))suc failure:(void(^)(void))fail;

@end
