//
//  ZBUserDefault.m
//  BSApp
//
//  Created by BaoThink on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "ZBUserDefault.h"



@implementation ZBUserDefault




#pragma mark - 通用
+ (void)defaultValue:(id)value key:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:value forKey:key];
    
    [user synchronize];
}
+ (void)defaultObject:(id)Object key:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:Object forKey:key];
    [user synchronize];
}

+ (void)defaultBool:(BOOL)value key:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:value forKey:key];
    [user synchronize];
}

+ (id)defaultValueForKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    id value = [user valueForKey:key];
    return value;
}

+ (id)defaultObjectForKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    id value = [user objectForKey:key];
    return value;
}

+ (BOOL)defaultBoolForKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL value = [user boolForKey:key];
    return value;
}



@end
