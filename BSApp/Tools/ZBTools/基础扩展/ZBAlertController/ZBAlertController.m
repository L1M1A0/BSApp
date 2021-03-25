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


#pragma mark - 初始化 alert ZBAlertController
/// 初始化  创建一个 action 的 ZBAlertController
+(instancetype)alert:(NSString *)title messge:(NSString *)message action:(NSString *)action handler:(void (^)(UIAlertAction * _Nonnull))handler{

    ZBAlertController *alertController = [ZBAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];//UIAlertControllerStyleActionSheet
    [alertController addAction:action handler:handler];
    return alertController;
}

/// 初始化，创建多个 actions 的 ZBAlertController
+(instancetype)alert:(NSString *)title messge:(NSString *)message actions:(NSArray *)actions handler:(void (^)(UIAlertAction *))handler{
    ZBAlertController *alertController = [ZBAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];//UIAlertControllerStyleActionSheet
    [alertController addActions:actions handler:handler];
    return alertController;
}

/// 初始化 包含两个 action  的 ZBAlertController 推荐使用批量创建
+(instancetype)alert:(NSString *)title messge:(NSString *)message action1:(NSString *)action1 handler1:(void (^)(UIAlertAction *))handler1 action2:(NSString *)action2 handler2:(void (^)(UIAlertAction *))handler2{
    
    ZBAlertController *alertController = [ZBAlertController alert:title messge:message action:action1 handler:handler1];
    
    if (action2 != nil || action2.length > 0) {
        [alertController addAction:action2 handler:handler2];
    }
//    [self presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

#pragma mark - 初始化 sheet ZBAlertController
+(instancetype)sheet:(NSString *)title messge:(NSString *)message actions:(NSArray *)actions handler:(void (^)(UIAlertAction *))handler{
    //UIAlertControllerStyleActionSheet
    ZBAlertController *alertController = [ZBAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addActions:actions handler:handler];
    return alertController;
}



#pragma mark - 快速初始化 ZBAlertController
/// 快速初始化 ZBAlertController 指定标题和内容
+(void)alert:(NSString *)title message:(NSString *)messge{
   [self alert:title message:messge action:nil viewController:nil];
}

/// 快速初始化 ZBAlertController 快速初始化 ZBAlertController 指定title、messge、viewController，一个按钮标题
+(void)alert:(NSString *)title message:(NSString *)messge action:(NSString *)action viewController:(UIViewController *)viewController{
    
    action = action.length == 0 || action == nil ? @"关闭" : action;
    ZBAlertController *alert = [self alert:title messge:messge action:action handler:nil];

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
-(UIAlertAction *)addAction:(NSString *)title handler:(void (^)(UIAlertAction *))handler{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
    [self addAction:action];
    return action;

}

/// 批量创建action，根据action标题来区分，原则上是不支持titles里面的元素重复出现
-(void)addActions:(NSArray *)titles handler:(void (^)(UIAlertAction *))handler{
    for (NSInteger i = 0; i < titles.count; i++) {
//        UIAlertAction *action = [UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:handler];
//        [self addAction:action];
        [self addAction:titles[i] handler:handler];
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
