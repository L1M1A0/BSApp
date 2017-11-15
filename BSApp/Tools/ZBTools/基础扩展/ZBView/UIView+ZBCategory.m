//
//  UIView+ZBCategory.m
//  Marketing
//
//  Created by BaoThink on 16/1/19.
//  Copyright © 2016年 forr. All rights reserved.
//

#import "UIView+ZBCategory.h"

@implementation UIView (ZBCategory)

/** 邮件表格:
 * y每+1, 起始位置 *30
 */
+ (UIView *)_createViewSetY:(NSInteger)y subView:(UIView *)subView gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, y * 35, kScreenWidth, 35)];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    [view.layer setBorderWidth:0.5];
    [view.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    [view addSubview:subView];
    [view addGestureRecognizer:gestureRecognizer];
    return view;
}


/** 阴影效果 */
- (UIView *)_shadowView:(UIView *)view frame:(CGRect)frame{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    view1.backgroundColor = [UIColor redColor];
    view1.layer.cornerRadius = 5.0;
    view1.layer.masksToBounds = YES;
    
    view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor yellowColor];
//    view2.layer.cornerRadius = 5.0;
    view.layer.shadowColor = [UIColor blueColor].CGColor;
    view.layer.shadowOpacity = 1.0;
    view.layer.shadowRadius = 20.0;
    view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [view addSubview:view1];
    return view;
}
@end
