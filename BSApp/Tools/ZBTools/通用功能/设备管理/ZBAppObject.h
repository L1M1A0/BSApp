//
//  ZBAppObject.h
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZBAppObject : NSObject


/**
获取自定义 app 版本

@return 如：团体版 1.1.0
*/
+ (NSString *)customAppVersion1;
+ (NSString *)customAppVersion2;

+ (BOOL)isStartAfterLoadNewVersion;
@end
