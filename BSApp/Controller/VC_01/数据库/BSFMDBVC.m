//
//  BSFMDBVC.m
//  BSApp
//
//  Created by lizb on 2017/12/8.
//  Copyright © 2017年 lizb. All rights reserved.
//

/*参考
 基本操作：https://www.jianshu.com/p/7958d31c2a97
 SQL语法：https://www.jianshu.com/p/249da8e58704
*/
#import "BSFMDBVC.h"
#import <FMDB.h>
#import "BSFMDBModel.h"
#import "ZBFMDBObject.h"
#import "BSListCell.h"

@interface BSFMDBVC (){
    FMDatabase *db;
    ZBFMDBObject *dbObject;
    BSListCell *dbCell;//数据库
    BSListCell *tbCell;//表
    BSListCell *columCell;//条件、列
    BSListCell *valueCell;//数据
    UITextView *textView;
    
    NSString *dbName;
    
    
    
}

@end

@implementation BSFMDBVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
  
}
- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    dbObject = [[ZBFMDBObject alloc]init];
    
    dbCell = [self cell:0 title:@"数据库：" holder:@"数据库名称"];
    tbCell = [self cell:1 title:@"表名："  holder:@"表名"];
    tbCell.inputTF.text = @"t_student";
    
    columCell = [self cell:2 title:@"字段：" holder:@"k1,k2,k3"];
    columCell.inputTF.text = @"ID,name,phone,score";
    
    valueCell = [self cell:3 title:@"数值：" holder:@"v1,v2,v3;v1,v2,v3;..."];
    valueCell.inputTF.text = @"12,20A,12C,12D";
    
    
    
    UIButton *btn20 = [self btn:2 x:0 title:@"插入" action:@selector(insertSQL)];
    UIButton *btn21 = [self btn:2 x:1 title:@"删除" action:@selector(handleDelete)];
    UIButton *btn22 = [self btn:2 x:2 title:@"修改" action:@selector(handleUpdate)];
    UIButton *btn23 = [self btn:2 x:3 title:@"查询" action:@selector(handleQuery)];
    UIButton *btn30 = [self btn:3 x:0 title:@"transaction db" action:@selector(handleTransaction)];
    UIButton *btn31 = [self btn:3 x:1 title:@"notransaction db" action:@selector(handleNotransaction)];
    UIButton *btn32 = [self btn:3 x:2 title:@"mutilLine db" action:@selector(handleMutilLine)];
    UIButton *btn33 = [self btn:3 x:3 title:@"protectmutilLine db" action:@selector(handleProtectMutilLine)];
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(btn30.frame)+10 , kScreenWidth-20, 200)];
    textView.backgroundColor = kYellowColor;
    textView.textColor = kRedColor;
    [self.view addSubview:textView];
    
    [self initDataBase:@"school"];
}

#pragma mark - 通用方法
/**
 使用FMDBbase类创建数据库
 
 作者：123456789q
 链接：https://www.jianshu.com/p/7958d31c2a97
 來源：简书
 简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
 */
-(UIButton *)btn:(CGFloat)indexY x:(CGFloat)indexX title:(NSString *)title action:(SEL)action{
    CGFloat wid = (kScreenWidth-30)/4;
    UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
    btn.frame = CGRectMake(10+(wid+5)*indexX,250+(40+10)*indexY,wid, 40);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleLabel.numberOfLines = 2;
    [btn setTitleColor:kRedColor forState:0];
    [btn setBackgroundColor:kLightGrayColor];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

-(BSListCell *)cell:(CGFloat)index title:(NSString *)title holder:(NSString *)holder{
    BSListCell *cell = [[BSListCell alloc]initWithFrame:CGRectMake(10, kNavigationBarHeight(self)+10+(35+10)*index, kScreenWidth-20, 35) title:title placeholder:holder leftViewWidth:80];
    [cell showDefaultLayer:kRedColor];
    [self.view addSubview:cell];
    return cell;
}

-(void)showQueryResult:(NSString *)sql{
    [db open];
    FMResultSet *result;
    
//    0.直接sql语句
//    result = [db executeQuery:@"select * from 't_student' where ID = 110"];
//    1.
//    result = [db executeQuery:@"select * from 't_student' where ID = ?",@111];
//    2.
//    result = [db executeQueryWithFormat:@"select * from 't_student' where ID = %d",112];
//    3.
//    result = [db executeQuery:@"select * from 't_student' where ID = ?" withArgumentsInArray:@[@113]];
//    4.
//    result = [db executeQuery:@"select * from 't_sutdent' where ID = ?" withParameterDictionary:@{@"ID":@114}];
    
    result = [db executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        BSFMDBModel *person = [BSFMDBModel new];
        person.ID = [result intForColumn:@"ID"];
        person.name = [result stringForColumn:@"name"];
        person.phone = [result stringForColumn:@"phone"];
        person.score = [result intForColumn:@"score"];
        [arr addObject:person];
//        NSLog(@"从数据库查询到的人员 %@",person.name);
    }
    [db close];
    
//    NSMutableArray *strs = [NSMutableArray array];
    NSMutableString *mstR  = [NSMutableString stringWithString:@""];
    for (int i = 0; i<arr.count; i++) {
        BSFMDBModel *model = arr[i];
        NSString *str = [NSString stringWithFormat:@"%d_%@_%@_%d\n",model.ID,model.name,model.phone,model.score];
//        [strs addObject:str];
        [mstR appendString:str];
    }
    textView.text = mstR;
}




#pragma mark - 基本操作，创建与增删改查

#pragma mark 初始化数据库
- (void)initDataBase:(NSString *)dbName {

    //2.创建对应路径下数据库
    db = [dbObject databaseWithName:[NSString stringWithFormat:@"%@.db",dbName]];
    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
    [db open];
    if (![db open]) {
        NSLog(@"数据库open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库");
        return;
    }
    //4.数据库中创建表（可创建多张）
    NSString *sql = @"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' CHAR NOT NULL, 'phone' CHAR NOT NULL,'score' INTEGER NOT NULL)";
    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
    BOOL result = [db executeUpdate:sql];
    if (result) {
        NSLog(@"创建数据库成功");
    }
    [db close];
}

#pragma mark 增加
/**
 备注：
 1. 增删改查中 除了查询（executeQuery），其余操作都用（executeUpdate）
 2. 如果字段的值是基本数字类型如：int，不加''，如：54；如果是对象类型如：NSString，需要加'',如：'wang'，否则会增删改查失败

 //1.sql语句中跟columnname 绑定的value 用 ？表示，不加‘’，可选参数是对象类型如：NSString，不是基本数据结构类型如：int，方法自动匹配对象类型
 - (BOOL)executeUpdate:(NSString*)sql, ...;
 //2.sql语句中跟columnname 绑定的value 用%@／%d表示，不加‘’
 - (BOOL)executeUpdateWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
 //3.sql语句中跟columnname 绑定的value 用 ？表示的地方依次用 (NSArray *)arguments 对应的数据替代
 - (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments;
 //4.同3 ，区别在于多一个error指针，记录更新失败
 - (BOOL)executeUpdate:(NSString*)sql values:(NSArray * _Nullable)values error:(NSError * _Nullable __autoreleasing *)error;
 //5.同3，区别在于用 ？ 表示的地方依次用(NSDictionary *)arguments中对应的数据替代
 - (BOOL)executeUpdate:(NSString*)sql withParameterDictionary:(NSDictionary *)arguments;
 - (BOOL)executeUpdate:(NSString*)sql withVAList: (va_list)args;
 */
-(void)insertSQL{
    NSString *tbStr = tbCell.inputTF.text;
    NSString *key = columCell.inputTF.text;
    NSString *sql = [NSString stringWithFormat:@"insert into '%@'(%@) values(?,?,?,?)",tbStr,key];

    [db open];
    //0.直接sql语句
    //BOOL result = [db executeUpdate:@"insert into 't_student' (ID,name,phone,score) values(110,'x1','11',83)"];
    //1.
    //BOOL result = [db executeUpdate:@"insert into 't_student'(ID,name,phone,score) values(?,?,?,?)",@111,@"x2",@"12",@23];
    //2.
    //BOOL result = [db executeUpdateWithFormat:@"insert into 't_student' (ID,name,phone,score) values(%d,%@,%@,%d)",112,@"x3",@"13",43];
    //3.
    //BOOL result = [db executeUpdate:@"insert into 't_student'(ID,name,phone,score) values(?,?,?,?)" withArgumentsInArray:@[@113,@"x3",@"13",@53]];
    //4.
    //BOOL result = [db executeUpdate:@"insert into 't_student' (ID,name,phone,score) values(:ID,:name,:phone,:score)" withParameterDictionary:@{@"ID":@114,@"name":@"x4",@"phone":@"14",@"score":@89}];
//    if (result) {
//        NSLog(@"insert into 't_studet' success");
//        [self showAlertWithTitle:@"insert  success" message:nil person:nil];
//    } else {
//        //增加数据库失败
//        [self showAlertWithTitle:[db lastError].description message:nil person:nil];
//    }
    
    NSArray *values = [valueCell.inputTF.text componentsSeparatedByString:@";"];
    for (int i = 0; i < values.count; i++) {
        NSArray *arr = [values[i] componentsSeparatedByString:@","];
        if (arr.count == 4) {
            NSInteger a = [arr[0] integerValue];
            NSInteger d = [arr[3] integerValue];
            //参考3.
            [db executeUpdate:sql withArgumentsInArray:@[@(a),arr[1],arr[2],@(d)]];
        }
    }
    
    [db close];
    [self showQueryResult:@"select * from t_student"];
}




#pragma mark 删除
-(void)handleDelete {
    BOOL result = NO;
    NSString *tbStr = tbCell.inputTF.text;
    NSString *key = columCell.inputTF.text;
    NSArray *values = [valueCell.inputTF.text componentsSeparatedByString:@","];
   
    
    [db open];
    ///0.直接sql语句
    //result = [db executeUpdate:@"delete from 't_student' where ID = 110"];
    for (int i = 0; i < values.count; i++) {
        NSString *deleteSQL = @"";
        if([key isEqualToString:@"name"] || [key isEqualToString:@"phone"]){//字符串类型
            deleteSQL = [NSString stringWithFormat:@"delete from '%@' where %@ = '%@'",tbStr,key,values[i]];
        }else{//数字类型
            deleteSQL = [NSString stringWithFormat:@"delete from '%@' where %@ = %@",tbStr,key,values[i]];
        }
        result = [db executeUpdate:deleteSQL];
        if (!result) { NSLog(@"delete from '%@' failed：%@",tbStr,[db lastError].description); }
    }
    //1.
    //result = [db executeUpdate:@"delete from 't_student' where ID = ?",@(111)];
    //2.
    //result = [db executeUpdateWithFormat:@"delete from 't_student' where ID = %d",112];
    //3.
//    result = [db executeUpdate:@"delete from 't_student' where ID = ?" withArgumentsInArray:@[@113]];
    //4.
    //result = [db executeUpdate:@"delete from 't_student' where :ID = ?" withParameterDictionary:@{@"ID":@"114"}];
//    if (!result) { NSLog(@"delete from 't_student' failed：%@",[db lastError].description); }
    [db close];
    
    NSString *querySql = [NSString stringWithFormat:@"select * from t_student"];
    [self showQueryResult:querySql];
}

#pragma mark 修改
-(void)handleUpdate {
    BOOL result;
    NSString *tbStr = tbCell.inputTF.text;
    NSArray *keys   = [columCell.inputTF.text componentsSeparatedByString:@","];
    NSArray *values = [valueCell.inputTF.text componentsSeparatedByString:@","];
    NSString * sql = [NSString stringWithFormat:@"update '%@' set %@ = %@ where %@ = %@",tbStr,keys[0],values[0],keys[1],values[1]];

    [db open];
    //0.直接sql语句
    //result = [db executeUpdate:@"update 't_student' set ID = 110 where name = 'x1'"];
    
//    if ([keys[0] isEqualToString:@"name"]) {
//        //        if ([keys[1] isEqualToString:@"phone"]) {
//        //            //条件与值的类类型：都是字符串类型
//        //            sql = [NSString stringWithFormat:@"update '%@' set %@ = '%@' where %@ = '%@'",tbStr,keys[0],values[0],keys[1],values[1]];
//        //        }else{
//        //条件与值的类类型：值，字符串；条件，数字
//        sql = [NSString stringWithFormat:@"update '%@' set %@ = '%@' where %@ = %@",tbStr,keys[0],values[0],keys[1],values[1]];
//        //        }
//    }
//    else if ([keys[0] isEqualToString:@"phone"]) {
//        if ([keys[1] isEqualToString:@"name"]) {
//            //条件与值的类类型：都是字符串类型
//            sql = [NSString stringWithFormat:@"update '%@' set %@ = '%@' where %@ = '%@'",tbStr,keys[0],values[0],keys[1],values[1]];
//        }else{
//            //条件与值的类类型：值，字符串；条件，数字
//            sql = [NSString stringWithFormat:@"update '%@' set %@ = '%@' where %@ = %@",tbStr,keys[0],values[0],keys[1],values[1]];
//        }
//    }else{
//        if ([keys[1] isEqualToString:@"phone"] || [keys[1] isEqualToString:@"name"]) {
//            //条件与值的类类型：值，数字；条件，字符串
//            sql = [NSString stringWithFormat:@"update '%@' set %@ = %@ where %@ = '%@'",tbStr,keys[0],values[0],keys[1],values[1]];
//        }else{
//            //条件与值的类类型：都是数字类型
//            sql = [NSString stringWithFormat:@"update '%@' set %@ = %@ where %@ = %@",tbStr,keys[0],values[0],keys[1],values[1]];
//        }
//    }
    result = [db executeUpdate:sql];
    //1.
    //result = [db executeUpdate:@"update 't_student' set ID = ? where name = ?",@111,@"x2" ];
    //2.
    //result = [db executeUpdateWithFormat:@"update 't_student' set ID = %d where name = %@",113,@"x3" ];
    //3.
//    result = [db executeUpdate:@"update 't_student' set ID = ? where name = ?" withArgumentsInArray:@[@113,@"x3"]];
    //4.
    //result = [db executeUpdate:@"update 't_student' set :ID = ? where :name = ?" withParameterDictionary:@{@"ID":@114,@"name":@"x4"}];
    if (!result) {
        NSLog(@"修改出错：%@",[db lastError].description);
//        [self showAlertWithTitle:[db lastError].description message:nil person:nil];
    }
    [db close];
    
    [self showQueryResult:@"select * from t_student"];
}

#pragma mark 查询
-(void)handleQuery  {
    NSString *tbStr = tbCell.inputTF.text;
    NSString *key = columCell.inputTF.text;
    NSString *value = [valueCell.inputTF.text componentsSeparatedByString:@","][0];
    NSString *sql = [NSString stringWithFormat:@"select * from '%@' where %@ = %@",tbStr,key,value];
    [self showQueryResult:sql];
}

#pragma mark - 事物 or 多任务
/**
 transaction:事务 开启一个事务执行多个任务，效率高
 1.fmdb 封装transaction 方法，操作简单
 - (BOOL)beginTransaction;
 - (BOOL)beginDeferredTransaction;
 - (BOOL)beginImmediateTransaction;
 - (BOOL)beginExclusiveTransaction;
 - (BOOL)commit;
 - (BOOL)rollback;
 等等
 */
- (void)handleTransaction  {
    //alloc
    FMDatabase *db = [dbObject databaseWithName:@"test1.db"];

    [db open];
    BOOL isopen = [db open];
    if (!isopen) {
        return;
    }
    BOOL result = [db executeUpdate:@"create table if not exists text1 (name text,age,integer,ID integer)"];
    if (result) {
        NSLog(@"create table success");
    }
    //1.开启事务
    [db beginTransaction];
    NSDate *begin = [NSDate date];
    BOOL rollBack = NO;
    @try {
        //2.在事务中执行任务
        for (int i = 0; i< 500; i++) {
            NSString *name = [NSString stringWithFormat:@"text_%d",i];
            NSInteger age = i;
            NSInteger ID = i *1000;
            
            BOOL result = [db executeUpdate:@"insert into text1(name,age,ID) values(:name,:age,:ID)" withParameterDictionary:@{@"name":name,@"age":[NSNumber numberWithInteger:age],@"ID":@(ID)}];
            if (result) {
                NSLog(@"在事务中insert success");
            }
        }
    }
    @catch(NSException *exception) {
        //3.在事务中执行任务失败，退回开启事务之前的状态
        rollBack = YES;
        [db rollback];
    }
    @finally {
        //4. 在事务中执行任务成功之后
        rollBack = NO;
        [db commit];
    }
    NSDate *end = [NSDate date];
    NSTimeInterval time = [end timeIntervalSinceDate:begin];
    NSLog(@"事务中执行插入任务 所需要的时间 = %f",time);
    
}
-(void)handleNotransaction  {
    FMDatabase *db = [dbObject databaseWithName:@"test1.db"];
    [db open];
    BOOL isopen = [db open];
    if (!isopen) {
        return;
    }
    BOOL result = [db executeUpdate:@"create table if not exists text2('ID' INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTRGER)"];
    if (!result) {
        [db close];
    }
    NSDate *begin = [NSDate date];
    for (int i = 0; i< 500; i++) {
        NSString *name = [NSString stringWithFormat:@"text_%d",i];
        NSInteger age = i;
        NSInteger ID = i *1000;
        
        BOOL result = [db executeUpdate:@"insert into text2(name,age,ID) values(:name,:age,:ID)" withParameterDictionary:@{@"name":name,@"age":[NSNumber numberWithInteger:age],@"ID":@(ID)}];
        if (result) {
            NSLog(@"不在事务中insert success");
        }
    }
    NSDate *end = [NSDate date];
    NSTimeInterval time = [end timeIntervalSinceDate:begin];
    NSLog(@"事务中执行插入任务 所需要的时间 = %f",time);
}
/**
 在多条线程中不允许使用同一个FMDataBase实例对象，如果使用可能会造成数据丢失或者混乱，为了保证数据库操作时线程安全，引入FMDataBaseQueue
 */

- (void)handleMutilLine  {
    FMDatabase *db = [dbObject databaseWithName:@"test2.db"];
    BOOL isopen = [db open];
    if (!isopen) {
        return;
    }
    BOOL result = [db executeUpdate:@"create table if not exists text3('ID' INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTRGER)"];
    if (!result) {
        return;
    }
    NSLog(@"create table 当前线程1 = %@",[NSThread currentThread]);
    //测试开启多个线程操作数据库
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        BOOL result = [db executeUpdate:@"insert into text3(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@10,@"name":@"10",@"age":@10}];
        if (result) {
            NSLog(@"在group insert 10 success");
        }
        NSLog(@"current thread 当前线程2 =  %@",[NSThread currentThread]);
        
    });
    dispatch_group_async(group, queue, ^{
        BOOL result = [db executeUpdate:@"insert into text3(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@11,@"name":@"11",@"age":@11}];
        if (result) {
            NSLog(@"在group insert 11 success");
        }
        NSLog(@"current thread 当前线程3 = %@",[NSThread currentThread]);
        
    });
    dispatch_group_async(group, queue, ^{
        BOOL result = [db executeUpdate:@"insert into text3(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@12,@"name":@"12",@"age":@12}];
        if (result) {
            NSLog(@"在group insert 12 success");
        }
        NSLog(@"current thread 当前线程4 = %@",[NSThread currentThread]);
        
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"done");
        NSLog(@"current thread = %@",[NSThread currentThread]);
        BOOL result = [db executeQuery:@"select * from text3 where ID = ?",@(10)];
        if (result) {
            NSLog(@"query 10 success");
        }
        BOOL result2 = [db executeQuery:@"select * from text3 where ID = ?",@(11)];
        if (result2) {
            NSLog(@"query 11 success");
        }
        BOOL result3 = [db executeQuery:@"select * from text3 where ID = ?",@(12)];
        if (result3) {
            NSLog(@"query 12 success");
        }
        
    });
    
}
-(void)handleProtectMutilLine  {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test4.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    FMDatabaseQueue *dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [db open];
    BOOL isopen = [db open];
    if (!isopen) {
        return;
    }
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeUpdate:@"create table if not exists text4('ID' INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTRGER)"];
        if (!result) {
            return;
        }
        NSLog(@"create table = %@",[NSThread currentThread]);
    }];
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        //测试开启多个线程操作数据库
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        dispatch_group_async(group, queue, ^{
            BOOL result = [db executeUpdate:@"insert into text4(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@10,@"name":@"10",@"age":@10}];
            if (result) {
                NSLog(@"在group insert 10 success");
            }
            NSLog(@"current thread = %@",[NSThread currentThread]);
            
        });
        dispatch_group_async(group, queue, ^{
            BOOL result = [db executeUpdate:@"insert into text4(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@11,@"name":@"11",@"age":@11}];
            if (result) {
                NSLog(@"在group insert 11 success");
            }
            NSLog(@"current thread = %@",[NSThread currentThread]);
            
        });
        dispatch_group_async(group, queue, ^{
            BOOL result = [db executeUpdate:@"insert into text4(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@12,@"name":@"12",@"age":@12}];
            if (result) {
                NSLog(@"在group insert 12 success");
            }
            NSLog(@"current thread = %@",[NSThread currentThread]);
            
        });
        dispatch_group_notify(group, queue, ^{
            NSLog(@"done");
            NSLog(@"current thread = %@",[NSThread currentThread]);
            BOOL result = [db executeQuery:@"select * from text4 where ID = ?",@(10)];
            if (result) {
                NSLog(@"query 10 success");
            }
            BOOL result2 = [db executeQuery:@"select * from text4 where ID = ?",@(11)];
            if (result2) {
                NSLog(@"query 11 success");
            }
            BOOL result3 = [db executeQuery:@"select * from text4 where ID = ?",@(12)];
            if (result3) {
                NSLog(@"query 12 success");
            }
            
        });
    }];
    
    
    
    
}
-(void)showAlertWithTitle:(NSString *)title
                  message:(NSString *)message
                   person:(BSFMDBModel *)person
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:nil];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = person.name ? person.name : @"other";
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
