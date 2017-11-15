//
//  CoreDataManager.m
//  BoriLearning
//
//  Created by YauzZ on 14/5/14.
//  Copyright (c) 2014年 Jason Tse. All rights reserved.
//

#import "CoreDataManager.h"
#import "UpdateManager.h"
#import <CoreData/CoreData.h>
//#import "UncaughtExceptionFileManager.h"

@implementation CoreDataManager

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainObjectContext = _mainObjectContext;
@synthesize objectModel = _objectModel;

+ (id)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedInstance) {
            _sharedInstance = [[CoreDataManager alloc]init];
        }
    });
    return _sharedInstance;
}

- (NSString *)modelName
{
    if (!_modelName)
    {

       NSException *exception = [NSException exceptionWithName:@"未定义数据库名" reason:@"未定义数据库名" userInfo:nil];
        
//        [UncaughtExceptionFileManager _writeExceptionIntoCoreData:exception];

    }
    return _modelName;
}

#pragma mark - an existing managed objects for entity
/*查询单条记录*/
//现有的管理对象与获取请求模板名称
- (id)existingManagedObjectsWithFetchRequestTemplateName:(NSString *)frName predicate:(NSPredicate *)predicate
{
    NSManagedObjectContext *context = self.mainObjectContext;
    NSFetchRequest *fetchRequest = [[self.objectModel fetchRequestTemplateForName:frName] copy];
    if (predicate) [fetchRequest setPredicate:predicate];
    NSArray *objs = [context executeFetchRequest:fetchRequest error:nil];
    
    return ([objs count] > 0)?([objs objectAtIndex:0]):nil;
}

#pragma mark - CoreData Utils
/*添加表*/
- (id)aManagedObjectWithEntityName:(NSString *)name
{
    //工厂方法，根据给定的 Entity(实体) 描述，生成相应的 NSManagedObject 对象，并插入到 ManagedObjectContext 中,通过上面的代码可以得到name这个表的实例
    id obj = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.mainObjectContext];
    return obj;
}

/*删除所有表*/
- (void)removeAllManagedObjectsWithFetchRequestTemplateName:(NSString *)name
{
    [self removeAllManagedObjectsWithFetchRequestTemplateName:name predicate:nil];
}
/*删除一张表*/
- (void)removeAllManagedObjectsWithFetchRequestTemplateName:(NSString *)name
                                                  predicate:(NSPredicate *)predicate
{
    NSArray *managedObjects = [self allManagedObjectsForEntityWithFetchRequestTemplateName:name sortDescriptor:nil];
    
    if (predicate) {
        managedObjects = [managedObjects filteredArrayUsingPredicate:predicate];
    }
    
    if ([managedObjects count] > 0) {
        for (id obj in managedObjects) {
            [self.mainObjectContext deleteObject:obj];
        }
        [self save];
    }
}

/*查询某表所有记录*/
- (NSArray *)allManagedObjectsForEntityWithFetchRequestTemplateName:(NSString *)frName sortDescriptor:(NSSortDescriptor *)sortDescriptor
{
    return [self allManagedObjectsForEntityWithFetchRequestTemplateName:frName sortDescriptor:sortDescriptor predicate:nil];
}

/*查询某表指定记录*/
- (NSArray *)allManagedObjectsForEntityWithFetchRequestTemplateName:(NSString *)frName
                                                     sortDescriptor:(NSSortDescriptor *)sortDescriptor
                                                          predicate:(NSPredicate *)predicate
{
    NSManagedObjectContext *context = self.mainObjectContext;
    NSFetchRequest *fetchRequest = [[self.objectModel fetchRequestTemplateForName:frName] copy];
    
    [fetchRequest setPredicate:predicate];
    
    if (sortDescriptor) {
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
    }
    NSError *error;
    
    NSArray *managedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (!managedObjects) {
        NSLog(@"allManagedObjectsForEntityWithFetchRequestTemplateName, execute fetch request error: %@", error);
//        [UncaughtExceptionFileManager _writeErrorIntoCoreData:error];

        return nil;
    }
    else {
        return managedObjects;
    }
}

#pragma mark - system configuration 系统配置
- (NSManagedObjectModel *)objectModel
{
    if (_objectModel) {
        return _objectModel;
    }
    
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:self.modelName ofType:@"momd"];
    NSAssert1(modelPath, @"modelPath %@ is nil", modelPath);
    
    _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:modelPath]];
    
    return _objectModel;
}

/** 数据迁移必要设置_持久化存储协调员 */
- (NSPersistentStoreCoordinator*)persistentStoreCoordinator {
	if (_persistentStoreCoordinator)
		return _persistentStoreCoordinator;
    
	//获取 SQLite文件路径和数据库名称
	NSString *storePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:[self.modelName stringByAppendingString:@".sqlite"]];
    NSAssert(storePath, @"storePath %@ is nil", storePath);
    
    [UpdateManager updateDataBaseWithName:self.modelName storePath:storePath];
    
	NSURL *storeURL = [NSURL fileURLWithPath:storePath];
    
	// 定义核心数据版本迁移选项
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    
	// 试图加载持久化存储
	NSError *error = nil;
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.objectModel];
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:options
                                                           error:&error]) {
		NSLog(@"Fatal error while creating persistent store: %@", error);
//        [UncaughtExceptionFileManager _writeErrorIntoCoreData:error];

        //		abort();
	}

    
	return _persistentStoreCoordinator;
}

/*设置数据库本地路径*/
- (NSString*)sharedDocumentsPath {
	static NSString *SharedDocumentsPath = nil;
	if (SharedDocumentsPath)
		return SharedDocumentsPath;
    
	// Compose a path to the <Library>/Database directory
	NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	SharedDocumentsPath = [libraryPath stringByAppendingPathComponent:@"Database"];
    NSLog(@"dbPath=%@",SharedDocumentsPath);
	// Ensure the database directory exists 确保数据库目录的存在
	NSFileManager *manager = [NSFileManager defaultManager];
	BOOL isDirectory;
	if (![manager fileExistsAtPath:SharedDocumentsPath isDirectory:&isDirectory] || !isDirectory) {
		NSError *error = nil;
		NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
		[manager createDirectoryAtPath:SharedDocumentsPath
		   withIntermediateDirectories:YES
                            attributes:attr
                                 error:&error];
		if (error)
//            [UncaughtExceptionFileManager _writeErrorIntoCoreData:error];

			NSLog(@"Error creating directory path: %@", [error localizedDescription]);
	}
    
	return SharedDocumentsPath;
}



#warning 改 0706 zhudw（优化，用于解决原版中瞬间加载大量数据时会引发崩溃）
- (NSManagedObjectContext*)mainObjectContext {
    
    //改版
    if (_mainObjectContext){
        return _mainObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _mainObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_mainObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    //原版
    /*
    if (_mainObjectContext)
        return _mainObjectContext;
    
    // Create the main context only on the main thread
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(mainObjectContext)
                               withObject:nil
                            waitUntilDone:YES];
        return _mainObjectContext;
    }
    
    _mainObjectContext = [[NSManagedObjectContext alloc] init];
    [_mainObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
     */
     return _mainObjectContext;
}

/*IDU操作后需要保存*/
- (BOOL)save {
	if (![self.mainObjectContext hasChanges]) return YES;//保存了，返回YES
    
	NSError *error = nil;
	if (![self.mainObjectContext save:&error])//保存
    {

        //捕获异常
//        [UncaughtExceptionFileManager _writeErrorIntoCoreData:error];
        //保存数据到数据库失败
		NSLog(@"Error while saving: %@\n%@", [error localizedDescription], [error userInfo]);
        
		return NO;
	}
    
	return YES;
}

/*删除一条记录并保存*/
- (void)deleteManagedObject:(id)object
{
    [self.mainObjectContext deleteObject:object];
    [self save];
}

- (void)dealloc {
    [self save];
}

/*回滚*/
- (void)rollback
{
    if ([self.mainObjectContext hasChanges])//hasChanges方法是检查是否有未保存的上下文更改，
    {
        [self.mainObjectContext rollback];
    }
}

@end
