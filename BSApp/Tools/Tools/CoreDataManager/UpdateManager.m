//
//  UpdateManager.m
//  BoriLearning
//
//  Created by YauzZ on 11/5/14.
//  Copyright (c) 2014年 Jason Tse. All rights reserved.
//

#import "UpdateManager.h"

@implementation UpdateManager

+ (UpdateManager *)sharedInstance
{
    static UpdateManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UpdateManager alloc]init];
    });
    return _sharedInstance;
}

+ (void)updateDataBaseWithName:(NSString *)name storePath:(NSString *)storePath
{
    NSString *key = [NSString stringWithFormat:@"updateKey_%@",name];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isUpdated = [[userDefaults objectForKey:key] boolValue];
    
    if (!isUpdated) {
        [[NSFileManager defaultManager] removeItemAtPath:storePath error:nil];
        [userDefaults setBool:YES forKey:key];
        [userDefaults synchronize];
    }
}

@end
