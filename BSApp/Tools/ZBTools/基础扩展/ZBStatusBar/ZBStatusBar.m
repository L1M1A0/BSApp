//
//  ZBStatusBar.m
//  BSApp
//
//  Created by 李振彪 on 2017/11/23.
//  Copyright © 2017年 李振彪. All rights reserved.
//

//参考链接http://www.jianshu.com/p/25e9c1a864be

#import "ZBStatusBar.h"

@implementation ZBStatusBar

-(UIView *)statusBar{
    if (!_statusBar) {
        _statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    }
    return _statusBar;
}

-(CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.locations = @[@0.0, @1.0];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
        _gradientLayer.frame = CGRectMake(0, 0, kScreenWidth, 20);
    }
    return _gradientLayer;
}

+ (void)backgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

+ (void)statusBarStyle:(UIStatusBarStyle)statusBarStyle{
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle];
}

- (void)gradientLayer:(NSArray *)colors{
    
    NSMutableArray *cl = [NSMutableArray array];
    for (int i = 0; i < colors.count; i++) {
        UIColor *col = colors[i];
        [cl addObject:(__bridge id)col.CGColor];
    }
    colors = [cl mutableCopy];
    self.gradientLayer.colors = colors;
    
    //    for (__strong id lay in statusBar.layer.sublayers) {
    //        if ([lay isKindOfClass:[CAGradientLayer class]]){
    //            //            [lay removeFromSuperlayer];
    //            lay = (CAGradientLayer *)self.gradientLayer;
    //            lay = self.gradientLayer;
    //        }
    //    }
    [self.statusBar.layer insertSublayer:self.gradientLayer atIndex:0];
}



@end
