//
//  BSTabBarCtrl.m
//  BSApp
//
//  Created by BaoThink on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSTabBarCtrl.h"

#import "VC_01.h"
#import "VC_02.h"
#import "VC_03.h"
#import "VC_04.h"


@interface BSTabBarCtrl ()

@end

@implementation BSTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    NSArray *vctrArr = @[@"VC_01",@"VC_02",@"VC_03",@"VC_04"];
    NSArray *tabTitleArr  = @[@"控件",@"业务",@"UI",@"其他"];
    NSArray *navTitleArr  = @[@"1",@"2",@"3",@"4"];
    NSArray *imgArr1  = @[@"tab_Home_1",@"tab_GB_1",@"tab_Match_1",@"tab_My_1"];
    NSArray *imgArr2  = @[@"tab_Home_2",@"tab_GB_2",@"tab_Match_2",@"tab_My_2"];
    
    
    NSMutableArray *vcArr = [NSMutableArray array];
    for (int i = 0; i<vctrArr.count; i++) {
        Class vcClass = NSClassFromString(vctrArr[i]);
        UIViewController *vc = [[vcClass alloc]init];
        vc.title = navTitleArr[i];
        vc.view.backgroundColor = kWhiteColor;
        vc.tabBarItem = [self tabBarItemImage:imgArr1[i] selectedImage:imgArr2[i] title:tabTitleArr[i]];
        UINavigationController *navigation = [self navAppearance:vc isImage:NO];
        [vcArr addObject:navigation];
        //[self _setTabBarBackgroundColor:tabBarCtrl];
        
    }
    
    [self tabbar:vctrArr];
    [self tabBarItemTitleColor];
    
    self.selectedIndex = 0;
    self.viewControllers = vcArr;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)tabbar:(NSArray *)vctrArr{
    //tabBar是否透明
    self.tabBar.translucent = NO;
    //tabbar背景颜色(Item非选中状态)
    self.tabBar.barTintColor = kWhiteColor;//kNavigationBarTintColor;//RGB(85, 85, 85);
    //tabbar中Item被选中时的背景颜色
//    self.tabBar.bounds.size.height
    
    CGFloat tabbarItemHeight = self.tabBar.bounds.size.height;
    tabbarItemHeight = kTabBarHeight2;
    
    
    CGSize indicatorItemSize = CGSizeMake(self.tabBar.bounds.size.width/[vctrArr count],tabbarItemHeight);
    self.tabBar.selectionIndicatorImage = [self tabBarItemColorAndSize:indicatorItemSize];
}

/** 设置某个tabBarItem选中时的背景颜色 */
- (UIImage *)tabBarItemColorAndSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 45/255.0, 102/255.0, 209/255.0, 1);//RGB(0, 125, 192)
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


/** 设置标签栏的选中与非选中状态下的（前景）图片，以及标题 */
- (UITabBarItem *)tabBarItemImage:(NSString *)imgName selectedImage:(NSString *)selectedImageName title:(NSString *)title{
    
    //分别设置常规与选中状态的图片
//    [self.tabBar.selectedItem setImage:[UIImage imageNamed:@"3.png"]];
//    [self.tabBar.selectedItem setSelectedImage:[UIImage imageNamed:@"4.png"]];
    
    UIImage * normalImage = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //选中状态的图片的名字
    UIImage * selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置tabBarItem
    UITabBarItem * tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:normalImage selectedImage:selectedImage];
    
    return tabBarItem;
}

/** 设置标签栏的文字的颜色 */
- (void)tabBarItemTitleColor{
    //tabar中被选中item的字符的颜色(默认系统蓝), 这个方法会使未选中的变暗itemTitle颜色变暗
//    self.tabBar.tintColor = [UIColor whiteColor];
    
    //NSBackgroundColorAttributeName 背景颜色
    //NSForegroundColorAttributeName 前景颜色
    //字符颜色 titleNomalColor, NSForegroundColorAttributeName,
    //字体大小 [UIFont systemFontOfSize:13],NSFontAttributeName
    
    //NSDictionary *fontDic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    UIColor *titleColorNomal = kBlackColor;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleColorNomal, NSForegroundColorAttributeName,[UIFont systemFontOfSize:13],NSFontAttributeName,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleColorSelected = kDefaultBlueColor;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleColorSelected, NSForegroundColorAttributeName,[UIFont systemFontOfSize:13],NSFontAttributeName,
                                                       nil] forState:UIControlStateSelected];

}


/** 设置导航栏的属性 isImage: 是否使用图片来做背景，否：使用颜色*/
- (UINavigationController *)navAppearance:(UIViewController *)vc isImage:(BOOL)isImage{
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    //statusBar(最顶上)和导航栏的文字会变成白色(默认黑色)
    nav.navigationBar.barStyle = UIBarStyleBlack;
    //leftBarButtonItem 或者 rightBarButtonItem 文字颜色
    [nav.navigationBar setTintColor:kWhiteColor];
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [nav.navigationBar setTranslucent:YES];//
    [nav.navigationBar setBarTintColor:kNavigationBarTintColor];//RGB(0, 125, 255)
//    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor,NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter"size:18]}];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightde animated:YES];

    if (isImage == YES) {
        //为导航栏添加背景图片，图片如果是44高，那么不覆盖状态栏，如果是64高就会覆盖状态栏
        //UIBarMetricsDefault 缺省值 UIBarMetricsCompact 横屏样式  UIBarMetricsDefaultPrompt和UIBarMetricsCompactPrompt是有promt的两种样式
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"3.png"] forBarMetrics:UIBarMetricsDefault];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    
    return nav;
}

//-(void)_setTabBarBackgroundColor:(UITabBarController *)tabbarCtrl{
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.bounds.size.width, 49)];
//    backView.backgroundColor = [UIColor purpleColor];
//    [tabbarCtrl.tabBar insertSubview:backView atIndex:0];
//    tabbarCtrl.tabBar.opaque = YES;
//}



@end
