//
//  SegmentControl.h
//  GT
//
//  Created by tage on 14-2-26.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

/**
 *  左右切换的pageControl
 *
 *  效果为X易的效果
 */

#import <UIKit/UIKit.h>

typedef void(^XTSegmentControlBlock)(NSInteger index);

@class XTSegmentControl;

@protocol XTSegmentControlDelegate <NSObject>

- (void)segmentControl:(XTSegmentControl *)control selectedIndex:(NSInteger)index;

@end



@interface XTSegmentControl : UIView

/** 将标题颜色设置为单一颜色，不随index改变发生改变 */
//@property (nonatomic, strong) UIColor *singleTitleColor;


/** <#Description#> */
@property (nonatomic, assign) BOOL isShowLeftShadowView;

/** <#Description#> */
@property (nonatomic, assign) BOOL isShowRightShadowView;

///** 是否需要修改当前选中菜单Item的背景颜色 */
//@property (nonatomic, assign) BOOL isNeedUpdateCurrentItemColor;
///** 当前选中菜单Item的背景颜色 */
@property (nonatomic, strong) UIColor *currentItemColor;
/** <#Description#> */
@property (nonatomic, strong) UIColor *otherItemColor;

/** 当前选中位置 */
@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem delegate:(id <XTSegmentControlDelegate>)delegate;

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem selectedBlock:(XTSegmentControlBlock)selectedHandle;

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem currentItemColor:(UIColor *)currentItemColor otherItemColor:(UIColor *)otherItemColor selectedBlock:(XTSegmentControlBlock)selectedHandle;

- (void)selectIndex:(NSInteger)index;

- (void)moveIndexWithProgress:(float)progress;

- (void)endMoveIndex:(NSInteger)index;

/* 设置红色角标 注意：此处的tag不能为0,所以index = 0的时候，tag = 1，以此类推*/
- (void)setBadgeCount:(NSInteger)badgeCount tag:(NSInteger)tag;

@property (nonatomic , strong) UIView *lineView;

@end
