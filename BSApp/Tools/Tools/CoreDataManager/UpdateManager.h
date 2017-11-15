//
//  UpdateManager.h
//  BoriLearning
//
//  Created by YauzZ on 11/5/14.
//  Copyright (c) 2014年 Jason Tse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateManager : NSObject

+ (UpdateManager *)sharedInstance;

+ (void)updateDataBaseWithName:(NSString *)name storePath:(NSString *)storePath;

@end
