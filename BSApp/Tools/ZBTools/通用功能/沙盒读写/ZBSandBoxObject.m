//
//  ZBSandBoxObject.m
//  CloudShop
//
//  Created by 李振彪 on 16/4/3.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "ZBSandBoxObject.h"

@implementation ZBSandBoxObject



/** 创建文件夹 */
+ (void)_createFolder:(NSString *)folderName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:folderName];
    
    NSError *error;
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
}


/** 文件路径 */
+ (NSString *)saveFileInFolder:(NSString *)folderName file:(NSString *)fileName{
    NSString *name = [NSString stringWithFormat:@"%@",NSHomeDirectory()];
    NSString *savePath;
    if([folderName isEqualToString:@""]||folderName.length == 0){
        savePath = [NSString stringWithFormat:@"%@/Documents/%@",name,fileName];
    }
    else{
        [self _createFolder:folderName];
        savePath = [NSString stringWithFormat:@"%@/Documents/%@/%@",name,folderName,fileName];
    }
    
    return savePath;
}

/** 检测沙盒，判断文件是否已经下载 */
+ (BOOL)isDownloadedInFolder:(NSString*)folderName file:(NSString *)fileName{
    
    BOOL isDownLoad = NO;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([folderName isEqualToString:@""]||folderName.length == 0) {
        
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        
        if ([fileManager fileExistsAtPath:filePath]) {
            //NSLog(@"存在");
            isDownLoad = YES;
        }
        else{
            //NSLog(@"不存在");
            isDownLoad = NO;
        }
    }
    else{
        //NSString *name = [NSString stringWithFormat:@"%@",NSHomeDirectory()];
        [self _createFolder:folderName];
        //NSString *filePath = [NSString stringWithFormat:@"%@/Documents/%@/%@",name,folderName,fileName];
        NSString *str = [NSString stringWithFormat:@"%@/%@",folderName,fileName];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:str];
        
        if ([fileManager fileExistsAtPath:filePath]) {
            //NSLog(@"存在");
            isDownLoad = YES;
        }
        else{
            //NSLog(@"不存在");
            isDownLoad = NO;
        }
        
    }
    
    
    return isDownLoad;
}



+ (void)createTxt:(NSString *)string fileName:(NSString *)fileName{
    
    //创建文件夹的路径 - 在沙盒目录下创建
    NSString *folderPath = [[NSString alloc]initWithFormat:@"%@/Documents",NSHomeDirectory()];
    
    //创建文件的路径 - 在沙盒目录下创建
    NSString *filePath = [[NSString alloc]initWithFormat:@"%@/Documents/%@.txt",NSHomeDirectory(),fileName];
    
    //创建唯一存在的文件管理器
    NSFileManager *fManager = [NSFileManager defaultManager];//创建文件管理器 ---单例（唯一的）
    
    //如果文件夹不存在，就创建文件夹
    if (![fManager fileExistsAtPath:folderPath]) {
        [fManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    
    //获取原来的文件中含有的数据, 在后面拼接新的数据.如果省略, 将覆盖文件中的原有数据
    //NSString *originalMessage = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //string = [originalMessage stringByAppendingFormat:@"%@",string];
    
    //文件中的内容
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //创建文件，并写入内容
    [fManager createFileAtPath:filePath contents:data attributes:nil];
    
    //    //如果文件不存在，就创建文件
    //    if (![fManager fileExistsAtPath:filePath]) {
    //        //文件中的内容
    //        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //        //创建文件，并写入内容
    //        [fManager createFileAtPath:filePath contents:data attributes:nil];
    //    }
#pragma mark 文件基本操作
    
    NSString *file1Content = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //文件读取
    NSLog(@"file1Content = %@",file1Content);
    //
    //文件写入
    //    NSString *str2 = @"hi,test";
    //    [str2 writeToFile:[NSString stringWithFormat:@"%@/Documents/file2.txt",NSHomeDirectory()] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}

- (NSString *)getMessgeFromFile:(NSString *)fileName{
    NSString *path = [[NSString alloc]initWithFormat:@"%@/Documents/%@.txt",NSHomeDirectory(),fileName];
    NSString *file1Content = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //文件读取
    //NSLog(@"file1Content = %@",file1Content);
    return file1Content;
}

@end
