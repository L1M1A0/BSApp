//
//  ZBAlertController.h
//  BSApp
//
//  Created by 李振彪 on 2017/11/10.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import <UIKit/UIKit.h>
//弹出信息
//#define ALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] show]
//#define ALERT_1(msg) [[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] show]
//#define ALERT_2(title,msg) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] show]
#define kAlert(title,msg) [ZBAlertController alert:title message:msg]

@interface ZBAlertController : UIAlertController


+(ZBAlertController *)alert:(NSString *)title messge:(NSString *)message action1:(NSString *)actionTitle1 handler1:(void (^ __nullable)(UIAlertAction *action))handler1 action2:(NSString *)actionTitle2 handler2:(void (^ __nullable)(UIAlertAction *action))handler2;

-(void)alertShow:(void (^ __nullable)(void))completion;

+(ZBAlertController *)alert:(NSString *)title message:(NSString *)messge;
@end
