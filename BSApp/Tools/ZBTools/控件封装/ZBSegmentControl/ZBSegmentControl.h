//
//  ZBSegmentControl.h
//  BSApp
//
//  Created by lizb on 2016/10/31.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZBSegmentControlDelegate;

@interface ZBSegmentControl : UIView

/** 没有选中的item的背景颜色和标题颜色 */
@property (nonatomic, strong) UIColor *nomalBackgroundColor;
@property (nonatomic, strong) UIColor *nomalTitleColor;

/** 当前选中的item的背景颜色和标题颜色 */
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, assign) id <ZBSegmentControlDelegate> delegate ;


- (instancetype )initWithFrame:(CGRect)frame items:(NSArray *)items;


/**
 设置item在各状态下的颜色

 @param nbColor 没有选中状态下，item的背景颜色
 @param ntColor 没有选中状态下，item的标题颜色
 @param sbColor 当前选中状态下，item的背景颜色
 @param stColor 当前选中状态下，item的标题颜色
 */
- (void)itemNomalBackgroundColor:(UIColor *)nbColor nomalTitleColor:(UIColor *)ntColor selectedBackgroundColor:(UIColor *)sbColor selectedTitleColor:(UIColor *)stColor;

- (void)itemNomalBackgroundColor:(UIColor *)nbColor nomalTitleColor:(UIColor *)ntColor selectedBackgroundColor:(UIColor *)sbColor selectedTitleColor:(UIColor *)stColor isUnSelect:(BOOL)isUnSelect;

/** 每两个相邻的item中间显示分割线 */
-(void)showSeparatorHeight:(CGFloat)height;
-(void)removeSeparator;
@end

@protocol ZBSegmentControlDelegate <NSObject>

- (void)segmentControl:(ZBSegmentControl *)segmentControl button:(UIButton *)button;

@end
