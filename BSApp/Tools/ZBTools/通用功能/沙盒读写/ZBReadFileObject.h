//
//  ZBReadFileObject.h
//  CloudShop
//
//  Created by BaoThink on 16/3/18.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBReadFileObject : NSObject

/**
 *  NSFileManager实例方法读取数据
 *  @param fileName 如:@"fd_list.txt"
 */
- (NSString *)_readFileByNSFileManager:(NSString *)fileName;
/**
 *  NSData类方法读取数据
 *  @param fileName 如:@"fd_list.txt"
 */
- (NSString *)_readFileByNSData:(NSString *)fileName;
/**
 *  NSString类方法读取内容
 *  @param fileName 如:@"fd_list.txt"
 */
- (NSString *)_readFileByNSString:(NSString *)fileName;

/**
 *  NSFileHandle实例方法读取内容
 *  @param fileName 如:@"fd_list.txt"
 */
- (NSString *)_readFileByNSFileHandle:(NSString *)fileName;
@end
