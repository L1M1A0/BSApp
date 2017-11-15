//
//  ZBUserDefault.h
//  BSApp
//
//  Created by BaoThink on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBUserDefault : NSObject

#pragma mark - 通用
+ (void)_defaultValue:(id)value key:(NSString *)key;
+ (void)_defaultObject:(id)Object key:(NSString *)key;
+ (void)_defaultBool:(BOOL)value key:(NSString *)key;

+ (id)_defaultValueForKey:(NSString *)key;
+ (id)_defaultObjectForKey:(NSString *)key;
+ (BOOL)_defaultBoolForKey:(NSString *)key;

@end
