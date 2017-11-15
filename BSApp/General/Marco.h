//
//  Marco.h
//  Fhalo
//
//  Created by YauzZ on 11/3/14.
//  Copyright (c) 2014年 YauzZ. All rights reserved.
//

#ifndef Fhalo_Marco_h
#define Fhalo_Marco_h
#endif
/*
 
 macro.h
 
 使用方法：
 ＊需要时import
 ＊添加到-Prefix.pch文件中,所有类中都可以使用
 
 author : YauzZ
 Date : 2014-03-12
 */

//#if TARGET_OS_IPHONE
//#define NSFoundationVersionNumber_iOS_8_0 1047.25
//#endif

/** 对NSLog的格式化宏 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


// 去除"-(id)performSelector:(SEL)aSelector withObject:(id)object;"的警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


/** app沙盒中，文档或文件夹的路径 documents structure of application  */
#define APP_DOCUMENT      [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_LIBRARY       [NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_CACHES_PATH   [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_USERINFO_PATH userInfoPath()

/* 校验数据是否为 null */
#define CONVERTER(obj) [obj isEqual:[NSNull null]] ? nil: obj

//1像素线：位置（x或y － SINGLE_LINE_ADJUST_OFFSET） 粗SINGLE_LINE_WIDTH
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

/** block self */
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;


/**  GCD */
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)




