//
//  ZBFMDBObject.m
//  BSApp
//
//  Created by LZBiao on 2018/9/18.
//  Copyright © 2018年 李振彪. All rights reserved.
//

#import "ZBFMDBObject.h"

@implementation ZBFMDBObject

- (NSString *)databasePathWithName:(NSString *)databaseName{
    //1.创建database路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    self.databasePath = [documentPath stringByAppendingPathComponent:databaseName];
    NSLog(@"数据库 %@ 的路径 = %@",databaseName,self.databasePath);
    return self.databasePath;
}

- (FMDatabase *)databaseWithName:(NSString *)databaseName{
    //2.创建对应路径下数据库
    self.databasePath = [self databasePathWithName:databaseName];
    //FMDatabase *db = [[FMDatabase alloc]initWithPath:dbPath];
    self.dataBase = [FMDatabase databaseWithPath:self.databasePath];
    return self.dataBase;
}

@end
