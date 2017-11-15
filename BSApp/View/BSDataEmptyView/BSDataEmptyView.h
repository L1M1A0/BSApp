//
//  BSDataEmptyView.h
//  giseGnmGkapp
//
//  Created by baothink on 16/2/29.
//  Copyright © 2016年 baothink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSDataEmptyView : UIView

/** 点击刷新按钮的回调 */
@property (nonatomic,copy)void (^click)(void);
/** 详情标题，默认“抱歉，没有找到符合条件的数据~~” */
@property (nonatomic,copy)NSString * detailText;
/** 传入数据源，数据源为空显示，不为空隐藏 */
-(void)judgeHideEmptyViewWithArray:(NSArray *)array;

@property (nonatomic,strong)UIButton * refreshButton;

@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UILabel * detailLabel;


/**
 初始化方法一：
 
 @param frame <#frame description#>
 @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame;

/**
 初始化方法二：
 
 @param frame <#frame description#>
 @param click 点击按钮执行回调
 @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame click:(void (^)(void))click;
@end
