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
+ (void)defaultValue:(id)value key:(NSString *)key;
+ (void)defaultObject:(id)Object key:(NSString *)key;
+ (void)defaultBool:(BOOL)value key:(NSString *)key;

+ (id)defaultValueForKey:(NSString *)key;
+ (id)defaultObjectForKey:(NSString *)key;
+ (BOOL)defaultBoolForKey:(NSString *)key;

@end
