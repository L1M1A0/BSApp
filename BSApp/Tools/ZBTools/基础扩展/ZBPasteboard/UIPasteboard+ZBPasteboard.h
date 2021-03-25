//
//  UIPasteboard+ZBPasteboard.h
//  BSApp
//
//  Created by lizb on 2017/11/30.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPasteboard (ZBPasteboard)


/**
 复制字符串到剪贴板

 @param string 目标字符
 */
+ (void)copyString:(NSString *)string;
@end
