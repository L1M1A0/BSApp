//
//  ZBFMDBObject.h
//  BSApp
//
//  Created by lizb on 2018/9/18.
//  Copyright © 2018年 lizb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>


@interface ZBFMDBObject : NSObject

@property (nonatomic, copy)   NSString *databasePath;
@property (nonatomic, strong) FMDatabase *dataBase;

- (NSString *)databasePathWithName:(NSString *)databaseName;
- (FMDatabase *)databaseWithName:(NSString *)databaseName;
@end
