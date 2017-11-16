//
//  UIView+ZBCategory.m
//  Marketing
//
//  Created by BaoThink on 16/1/19.
//  Copyright © 2016年 forr. All rights reserved.
//

#import "UIView+ZBCategory.h"

@implementation UIView (ZBCategory)
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}



- (void)shadowColor:(UIColor *)shadowColor opacity:(float)shadowOpacity radius:(float)shadowRadius offset:(CGSize)shadowOffset {

    self.layer.shadowColor   = shadowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius  = shadowRadius;
    self.layer.shadowOffset  = shadowOffset;
}

- (void)layerWidth:(CGFloat)borderWidth color:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds cornerRadius:(CGFloat)cornerRadius {
    
    [self.layer setBorderWidth:borderWidth];
    [self.layer setBorderColor:borderColor.CGColor];
    [self.layer setMasksToBounds:masksToBounds];
    [self.layer setCornerRadius:cornerRadius];
}

- (UITapGestureRecognizer *)tapGestureRecognizerTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    return tap;
}

@end
