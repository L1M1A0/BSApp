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
+ (void)_defaultValue:(id)value key:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:value forKey:key];
    
    [user synchronize];
}
+ (void)_defaultObject:(id)Object key:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:Object forKey:key];
    [user synchronize];
}

+ (void)_defaultBool:(BOOL)value key:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:value forKey:key];
    [user synchronize];
}

+ (id)_defaultValueForKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    id value = [user valueForKey:key];
    return value;
}

+ (id)_defaultObjectForKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    id value = [user objectForKey:key];
    return value;
}

+ (BOOL)_defaultBoolForKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL value = [user boolForKey:key];
    return value;
}



@end
