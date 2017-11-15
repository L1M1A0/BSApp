//
//  CustPhoneAlertView.h
//  Marketing
//
//  Created by 李振彪 on 16/8/25.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustPhoneAlertViewDelegate;

@interface CustPhoneAlertView : UIView

@property (nonatomic, strong) UILabel *titleLab;
/** 添加自定义视图 */
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, assign) CGSize contentViewRect;

@property (nonatomic, assign) id <CustPhoneAlertViewDelegate> delegate;
@end

@protocol CustPhoneAlertViewDelegate <NSObject>

-(void)alertViewLeftBtnAction;
-(void)alertViewRightBtnAction;

@end
