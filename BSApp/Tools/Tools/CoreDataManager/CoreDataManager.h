//
//  CoreDataManager.h
//  BoriLearning
//
//  Created by YauzZ on 14/5/14.
//  Copyright (c) 2014年 Jason Tse. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CoreDataManager : NSObject

@property (strong, readonly, nonatomic) NSManagedObjectModel *objectModel;
@property (strong, readonly, nonatomic) NSManagedObjectContext *mainObjectContext;
@property (strong, readonly, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
/** 数据模型名 */
@property (strong, nonatomic) NSString *modelName;

/** 共享实实例 */
+ (id)sharedInstance;

/* 添加表 */
- (id)aManagedObjectWithEntityName:(NSString *)name;
/* 删除一条记录 */
- (void)deleteManagedObject:(id)object;
/* 保存 */
- (BOOL)save;
/* 回滚 */
- (void)rollback;

/** 作用：查询表，可以是单条记录也可以是多条
 *  @param frName    *model名*
 *  @param predicate *查询条件*
 *
 *  @return *取得Model数组*
 */
- (id)existingManagedObjectsWithFetchRequestTemplateName:(NSString *)frName predicate:(NSPredicate *)predicate;

/* 删除所有表 */
- (void)removeAllManagedObjectsWithFetchRequestTemplateName:(NSString *)name;
/* 删除一张 表*/
- (void)removeAllManagedObjectsWithFetchRequestTemplateName:(NSString *)name predicate:(NSPredicate *)predicate;

/* 查询某表所有记录 */
- (NSArray *)allManagedObjectsForEntityWithFetchRequestTemplateName:(NSString *)frName sortDescriptor:(NSSortDescriptor *)sortDescriptor;
/* 查询某表指定的记录 */
- (NSArray *)allManagedObjectsForEntityWithFetchRequestTemplateName:(NSString *)frName sortDescriptor:(NSSortDescriptor *)sortDescriptor predicate:(NSPredicate *)predicate;

@end
