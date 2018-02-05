//
//  ZBAlertController.m
//  BSApp
//
//  Created by 李振彪 on 2017/11/10.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import "ZBAlertController.h"

@interface ZBAlertController ()

@end

@implementation ZBAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    for (int i = 0; i < 3; i++) {
//        
//        UIButton *btn = [UIButton _buttonFrame:CGRectMake(20, 20+40*i+5*i, 70, 40) title:@"dfd" tColor:kRedColor target:self action:@selector(btnaction:)];
//        btn.tag = i;
//        [alertController.view addSubview:btn];
//        
//    }
   
    
}

//-(void)btnaction:(UIButton *)sender{
//    NSLog(@"btn.tag_%ld",sender.tag);
//}



+(ZBAlertController *)alert:(NSString *)title messge:(NSString *)message action1:(NSString *)actionTitle1 handler1:(void (^)(UIAlertAction *))handler1 action2:(NSString *)actionTitle2 handler2:(void (^)(UIAlertAction *))handler2{
    
    ZBAlertController *alertController = [ZBAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (actionTitle1 == nil) {
        if (actionTitle2 == nil) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:handler1];
            [alertController addAction:cancelAction];
        }else{
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:actionTitle2 style:UIAlertActionStyleDefault handler:handler2];
            [alertController addAction:OKAction];
        }
    }else{
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:actionTitle1 style:UIAlertActionStyleDefault handler:handler1];
        [alertController addAction:cancelAction];
    
        if (actionTitle2 != nil) {
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:actionTitle2 style:UIAlertActionStyleDefault handler:handler2];
            [alertController addAction:OKAction];
        }
    }
//    [self presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

-(void)alertShow:(void (^)(void))completion{
    
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController presentViewController:self animated:YES completion:completion];
}

+(ZBAlertController *)alert:(NSString *)title message:(NSString *)messge{
    ZBAlertController *alert = [self alert:title messge:messge action1:@"关闭" handler1:nil action2:nil handler2:nil];
    [alert alertShow:nil];
    return alert;
    
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
