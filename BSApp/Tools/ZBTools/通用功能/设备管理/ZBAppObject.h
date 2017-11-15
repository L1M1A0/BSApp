//
//  ZBAppObject.h
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBAppObject : NSObject


/** 获取程序版本(关于页面调用) */
+ (NSString *)appVersion;

/** 获取app当前版本 */
+ (NSString *)currentVersion;

/** app名字 */
+ (NSString *)appName;

+ (BOOL)isStartAfterLoadNewVersion;
@end
