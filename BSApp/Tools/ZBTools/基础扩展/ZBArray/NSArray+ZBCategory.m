//
//  NSArray+ZBCategory.m
//  Marketing
//
//  Created by BaoThink on 16/7/5.
//  Copyright © 2016年 forr. All rights reserved.
//

#import "NSArray+ZBCategory.h"

@implementation NSArray (ZBCategory)

/** 将一维数组转换成二维数组 */
+ (NSArray *)arrayTo2DArray:(NSArray *)array size:(NSInteger)size{
    
    //    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    NSMutableArray *mArr = [NSMutableArray array];
    
    NSInteger total = array.count / size;
    NSInteger offSet = array.count % size;
    if (offSet != 0) {
        total += 1;
    }
    for (int i = 0; i < total; i++) {//总页数
        NSMutableArray *temp = [NSMutableArray array];
        for (int j = 0; j < size; j++) {//偏移量
            //防越界
            NSInteger index = i * size+j;
            if (index < array.count) {
                [temp addObject:array[index]];
            }
        }
        [mArr addObject:temp];
    }
    
    return [NSArray arrayWithArray:mArr];
}


/** 移除数组中重复出现的字符串,重复的只保存一个 */
+ (NSArray *)removeStringWhichIsRepeatedInArrayAndSaveOne:(NSArray *)originArray{
    
    //三. 将所有标题中出现的重复的标题删除(清除重复元素), 只保留重复了的其中的一个,只有一个的直接保留
    NSMutableArray *resultArr = [NSMutableArray array];
    [originArray enumerateObjectsUsingBlock:^(NSString *heroString, NSUInteger idx, BOOL *stop) {
        __block BOOL isContain = NO;
        [resultArr enumerateObjectsUsingBlock:^(NSString *desString, NSUInteger idx, BOOL *stop) {
            if (NSOrderedSame == [heroString compare:desString options:NSCaseInsensitiveSearch]) {
                isContain = YES;
            }}];

        if (NO == isContain) {
            [resultArr addObject:heroString];
        }
    }];
    return (NSArray *)resultArr;
}


/** 判断数组中是否包含某个字符串, 推荐使用官方方法:containsObject */
+ (BOOL)isArr:(NSArray *)arr ContainsStr:(NSString *)string{
    BOOL isContains = NO;
    
    for (id obj in arr) {
        if ([obj isKindOfClass:[NSString class]]) {
            
            NSString *objStr = (NSString *)obj;
            if ([objStr containsString:string]) {
                NSLog(@"objStr:%@", objStr);
                isContains = YES;
            }else{
                isContains = NO;
            }
        }
    }
    return isContains;
}


@end
