//
//  UIView+ZBCategory.h
//  Marketing
//
//  Created by BaoThink on 16/1/19.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZBCategory)

@property(assign, nonatomic) CGFloat x;
@property(assign, nonatomic) CGFloat y;
@property(assign, nonatomic) CGFloat width;
@property(assign, nonatomic) CGFloat height;
@property(assign, nonatomic) CGSize size;
@property(assign, nonatomic) CGPoint origin;

/** 阴影效果 */
- (void)shadowColor:(UIColor *)shadowColor opacity:(float)shadowOpacity radius:(float)shadowRadius offset:(CGSize)shadowOffset;

- (void)layerWidth:(CGFloat)borderWidth color:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds cornerRadius:(CGFloat)cornerRadius;
@end
