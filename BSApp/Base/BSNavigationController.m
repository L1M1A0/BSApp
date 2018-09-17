//
//  BSNavigationController.m
//  giseGnmGkapp
//
//  Created by baothink on 16/1/12.
//  Copyright (c) 2016年 baothink. All rights reserved.
//

#import "BSNavigationController.h"

@interface BSNavigationController ()

@end

@implementation BSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

//gradientLayer.colors = @[(__bridge id)RGB(64, 73, 288).CGColor, (__bridge id)RGB(0, 181, 255).CGColor];
+(void)navCtrl:(UINavigationController *)navCtrl color1:(UIColor *)color1 color2:(UIColor *)color2{

    [self navCtrl:navCtrl image1:@"" image2:@""];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];//颜色不限数量，此方法只设置两个颜色
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, -20, KScreenWidth, 64);
    //    [self.navigationController.navigationBar.layer insertSublayer:gradientLayer below:self.navigationController.navigationBar.superview.layer];
    [navCtrl.navigationBar.layer insertSublayer:gradientLayer atIndex:0];//渐变
}

+(void)navCtrl:(UINavigationController *)navCtrl image1:(NSString *)image1 image2:(NSString *)image2{
    navCtrl.navigationBar.barStyle = UIBarStyleBlack;
    [navCtrl.navigationBar setBackgroundImage:image1.length==0?[UIImage new]:[UIImage imageNamed:image1] forBarMetrics:UIBarMetricsDefault];
    [navCtrl.navigationBar setShadowImage:image2.length==0?[UIImage new]:[UIImage imageNamed:image2]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
