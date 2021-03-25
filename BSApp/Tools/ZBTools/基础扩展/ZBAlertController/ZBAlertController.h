//
//  ZBAlertController.h
//  BSApp
//
//  Created by lizb on 2017/11/10.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import <UIKit/UIKit.h>
//弹出信息 UIAlertView 在iOS13中完全彻底弃用，使用就崩溃
//#define ALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] show]
//#define ALERT_1(msg) [[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] show]
//#define ALERT_2(title,msg) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] show]


/** 标题，详细信息  ~注：参考快速初始化部分*/
#define kAlert(title,msg) [ZBAlertController alert:title message:msg]
/** 标题，详细信息 ，按钮标题（单个），viewController  ~ 注：参考快速初始化部分 */
#define kAlertSelf(title,msg,act,vc) [ZBAlertController alert:title message:msg action:act viewController:vc];

#define kAlertActions @[@"取消",@"确定"]
#define kAlertActionCancel @"取消"
#define kAlertActionConfirm @"确定"


@interface ZBAlertController : UIAlertController

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 基本初始化 alert ZBAlertController ，可随意增加action

/// 初始化  创建一个 action 的 ZBAlertController
/// @param title 标题
/// @param message  信息
/// @param action  action按钮标题
/// @param handler  点击action按钮的方法回调
+(instancetype)alert:(NSString *)title messge:(NSString *)message action:(nullable NSString *)action handler:(void (^ _Nullable)(UIAlertAction *action))handler;

/// 初始化，创建多个 actions 的 ZBAlertController
/// @param title 标题
/// @param message 信息
/// @param actions action标题数组，回调中通过action.title区别
/// @param handler 回调
+(instancetype)alert:(NSString *)title messge:(NSString *)message actions:(NSArray *)actions handler:(void (^ _Nullable)(UIAlertAction *action))handler;

/// 初始化 包含两个 action  的 ZBAlertController 推荐使用批量创建
/// @param title 标题
/// @param message  信息
/// @param action1  左标题
/// @param handler1  点击左标题的方法回调
/// @param action2 右标题
/// @param handler2 点击右标题的方法回调
+(instancetype)alert:(NSString *)title messge:(NSString *)message action1:(NSString *)action1 handler1:(void (^ _Nullable)(UIAlertAction *action))handler1 action2:(NSString *)action2 handler2:(void (^ _Nullable)(UIAlertAction *action))handler2;



#pragma mark - 基本初始化 sheet ZBAlertController ，可随意增加action

/// 批量创建一个包含多个 action 的 sheet 类型 ZBAlertController
/// @param title 标题
/// @param message 信息
/// @param actions  action标题数组，回调中通过action.title区别
/// @param handler 回调，通过action.title区别action
+(instancetype)sheet:(NSString *)title messge:(NSString *)message actions:(NSArray *)actions handler:(void (^ _Nullable)(UIAlertAction *action))handler;



#pragma mark - 快速初始化 ZBAlertController 不支持添加action，否则会奔溃，如果需要，请使用其他基本初始化方式

/// 快速初始化 ZBAlertController 指定标题和内容
/// @param title 标题
/// @param messge 信息
+(void)alert:(NSString *)title message:(NSString *)messge;

/// 快速初始化 ZBAlertController 快速初始化 ZBAlertController 指定title、messge、viewController，一个按钮标题
/// @param title 标题
/// @param messge 信息
/// @param action 按钮标题 ，允许为nil，会默认设置为 @“关闭”
/// @param viewController 当前显示的viewController 允许为nil。会默认显示在[UIApplication sharedApplication].keyWindow.rootViewController;
+(void)alert:(NSString *)title message:(NSString *)messge action:(nullable NSString *)action viewController:(nullable UIViewController *)viewController;


#pragma mark - 显示窗口

/// 显示窗口，不指定显示viewController，在当前keyWindow中显示
/// @param completion 显示完成后回调
-(void)alertShow:(void (^ __nullable)(void))completion;

/// 显示窗口，并指定显示viewController
/// @param viewController 指定显示viewController
/// @param completion 显示完成后回调
-(void)alertShow:(UIViewController *)viewController completion:(void (^ _Nullable)(void))completion;



#pragma mark - action

/// 给alertController 增加一个action
/// @param title <#title description#>
/// @param handler <#handler description#>
-(UIAlertAction *)addAction:(NSString *)title handler:(void (^ _Nullable)(UIAlertAction *action))handler;


/// 批量创建action，根据action标题来区分，原则上是不支持titles里面的元素重复出现
/// @param titles 标题数组
/// @param handler 回吊
-(void)addActions:(NSArray *)titles handler:(void (^ _Nullable)(UIAlertAction *action))handler;

NS_ASSUME_NONNULL_END

@end
 
