//
//  BSLoginManager.h
//  BSApp
//
//  Created by lizb on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "BSUserModel.h"


@interface BSLoginManager : NSObject

/**
 *  获取当前用户模型
 *
 *  @return 用户模型
 */
+ (BSUserModel *)getCurrentUserInfo;


/**
 *  退出清空本地用户信息
 */
+ (void)removeCurrentUserInfo;

/**
 *  当前用户是否存在或登录
 *
 *  @return 是否存在
 */
+ (BOOL)isLoginOfCurrentUser;


+ (void)saveUserDic:(id)model;

/**
 将model保存成dic
 
 @param model userModel
 */
+(void)modelToDicAndSaveWithDic:(BSUserModel *)model;

@end
