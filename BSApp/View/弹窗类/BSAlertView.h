//
//  BSAlertView.h
//  BSApp
//
//  Created by 李振彪 on 2016/11/14.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BSAlertViewDelegate;


@interface BSAlertView : UIView

/** 设置弹窗的相关属性点的时候用，而不是是用self
比如设置 BSAlertView *view的背景颜色的时候，应该使用view.alertView.backgroundColor，而不是是用view.backgroundColor
 */
@property (nonatomic, strong) UIView *alertView;


@property (nonatomic, strong) UILabel *titleLab;
/** 添加自定义视图 */
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, assign) CGSize contentViewRect;

@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

/** 是否可以通过点击背景移除视图,优先响应点击事件而导致其他响应方法不执行 */
//@property (nonatomic, assign) BOOL canTouchBackGroundView;

/**
  是否仅仅显示contentView中的界面元素，其他的隐藏
 */
@property (nonatomic, assign) BOOL isContenViewModel;

@property (nonatomic, assign) id <BSAlertViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame alertPointX:(CGFloat)pointX contentViewHeight:(CGFloat)contentViewHeight;

/** 主要用于子类继承时直接添加自定义视图 */
- (void)addContentView;

- (void)show;

- (void)hide;

- (void)hideTitleLable;


- (void)alertViewUpdateFrame:(CGRect)alertViewFrame;
//- (void)alertViewUpdateFrame:(CGFloat)contentViewHeight;
//- (void)alertViewUpdatePointX:(CGFloat)x;


@end

@protocol BSAlertViewDelegate <NSObject>

-(void)bsAlertView:(BSAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
