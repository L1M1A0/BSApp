//
//  UIView+ZBCategory.h
//  Marketing
//
//  Created by BaoThink on 16/1/19.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZBCategory)

/** 邮件表格:
 * y每+1, 起始位置 *30
 */
+ (UIView *)_createViewSetY:(NSInteger)y subView:(UIView *)subView gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer;


- (UIView *)_shadowView:(UIView *)view frame:(CGRect)frame;
@end
