//
//  ZBAlertController.m
//
//
//  Created by lizb on 2017/11/10.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import "ZBAlertController.h"

@interface ZBAlertController ()

@end

@implementation ZBAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


#pragma mark - 初始化 ZBAlertController
/// 初始化  创建一个 action 的 ZBAlertController
+(ZBAlertController *)alert:(NSString *)title messge:(NSString *)message action:(NSString *)action handler:(void (^ _Nullable)(UIAlertAction *))handler{
    
    ZBAlertController *alertController = [ZBAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:action handler:handler];
    return alertController;
}

/// 初始化，创建多个 actions 的 ZBAlertController
+(ZBAlertController *)alert:(NSString *)title messge:(NSString *)message actions:(NSArray *)actions handler:(void (^)(UIAlertAction *))handler{
    ZBAlertController *alertController = [ZBAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addActions:actions handler:handler];
    return alertController;
}

/// 初始化 包含两个 action  的 ZBAlertController 推荐使用批量创建
+(ZBAlertController *)alert:(NSString *)title messge:(NSString *)message action1:(NSString *)action1 handler1:(void (^)(UIAlertAction *))handler1 action2:(NSString *)action2 handler2:(void (^)(UIAlertAction *))handler2{
    
    ZBAlertController *alertController = [ZBAlertController alert:title messge:message action:action1 handler:handler1];
    
    if (action2 != nil || action2.length > 0) {
        [alertController addAction:action2 handler:handler2];
    }
//    [self presentViewController:alertController animated:YES completion:nil];
    return alertController;
}


#pragma mark - 快速初始化 ZBAlertController
/// 快速初始化 ZBAlertController 指定标题和内容
+(void)alert:(NSString *)title message:(NSString *)messge{
   [self alert:title message:messge btnTitle:nil viewController:nil];
}

/// 快速初始化 ZBAlertController 快速初始化 ZBAlertController 指定title、messge、viewController，一个按钮标题
+(void)alert:(NSString *)title message:(NSString *)messge btnTitle:(NSString *)btnTitle viewController:(UIViewController *)viewController{
    
    btnTitle = btnTitle.length == 0 || btnTitle == nil ? @"关闭" : btnTitle;
    ZBAlertController *alert = [self alert:title messge:messge action:btnTitle handler:nil];

    if(viewController == nil){
        [alert alertShow:nil];
    }else{
        [alert alertShow:viewController completion:nil];
    }
}

#pragma mark - 显示窗口
/// 显示窗口，不指定显示viewController，在当前keyWindow中显示
-(void)alertShow:(void (^)(void))completion{
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self alertShow:viewController completion:completion];
}

/// 显示窗口，并指定显示viewController
-(void)alertShow:(UIViewController *)viewController completion:(void (^)(void))completion{
    [viewController presentViewController:self animated:YES completion:completion];
}


#pragma mark - action
/// 给alertController 增加一个action
-(UIAlertAction *)addAction:(NSString *)title handler:(void (^ _Nullable)(UIAlertAction *))handler{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
    [self addAction:action];
    return action;

}

/// 批量创建action，根据action标题来区分，原则上是不支持titles里面的元素重复出现
-(void)addActions:(NSArray *)titles handler:(void (^ _Nullable)(UIAlertAction *))handler{
    for (NSInteger i = 0; i < titles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:handler];
        [self addAction:action];
    }
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
