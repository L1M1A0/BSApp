//
//  ZBReadFileObject.m
//  CloudShop
//
//  Created by BaoThink on 16/3/18.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "ZBReadFileObject.h"

@implementation ZBReadFileObject

/**
 *  NSFileManager实例方法读取数据
 *  @param fileName 如:@"fd_list.txt"
 */
- (NSString *)_readFileByNSFileManager:(NSString *)fileName{
    //第一种方法： NSFileManager实例方法读取数据
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString* thepath = [paths lastObject];
    thepath = [thepath stringByAppendingPathComponent:fileName];
    NSLog(@"桌面目录：%@", thepath);
    NSFileManager* fm = [NSFileManager defaultManager];
    NSData* data = [[NSData alloc] initWithData:[fm contentsAtPath:thepath]];
//    data = [fm contentsAtPath:thepath];
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",message);
    
    return message;
}
/**
 *  NSData类方法读取数据
 *  @param fileName 如:@"fd_list.txt"
 */
- (NSString *)_readFileByNSData:(NSString *)fileName{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString* thepath = [paths lastObject];
    thepath = [thepath stringByAppendingPathComponent:fileName];

    NSData *data = [NSData dataWithContentsOfFile:thepath];
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"NSData类方法读取的内容是：%@",message);
    return message;
}
/**
 *  NSString类方法读取内容
 *  @param fileName 如:@"fd_list.txt"
 */
- (NSString *)_readFileByNSString:(NSString *)fileName{
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
    NSString* thepath = [paths lastObject];
    thepath = [thepath stringByAppendingPathComponent:fileName];
    
    //第三种方法： NSString类方法读取内容
    NSString* message = [NSString stringWithContentsOfFile:thepath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"NSString类方法读取的内容是：\n%@",message);
    return message;

}
/**
 *  NSFileHandle实例方法读取内容
 *  @param fileName <#fileName description#>
 */
- (NSString *)_readFileByNSFileHandle:(NSString *)fileName{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString* thepath = [paths lastObject];
    thepath = [thepath stringByAppendingPathComponent:fileName];
    
    //第四种方法： NSFileHandle实例方法读取内容
    NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:thepath];
    NSData *data = [fh readDataToEndOfFile];
    NSString *message =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"NSFileHandle实例读取的内容是：\n%@",message);
    return message;
}

- (void)_da:(NSString *)fileName{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString* thepath = [paths lastObject];
    thepath = [thepath stringByAppendingPathComponent:fileName];
    NSLog(@"桌面目录：%@", thepath);
    NSFileManager* fm = [NSFileManager defaultManager];
    NSData* data = [[NSData alloc] initWithData:[fm contentsAtPath:thepath]];
//    data = [fm contentsAtPath:thepath];
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",message);

    
}

@end
