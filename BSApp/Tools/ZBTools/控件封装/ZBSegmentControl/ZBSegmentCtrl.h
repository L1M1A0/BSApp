//
//  ZBSegmentCtrl.h
//  BSApp
//
//  Created by lizb on 2017/10/13.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

//1. 根据title长度设置item宽度
//2. 所有item宽度的和不能铺满屏幕宽度时，剩余长度平局分配到每个item中
//3. 所有item宽度的和超过屏幕宽度时，支持滚动显示
//4. 除了两侧item，其余item选中时，位置在屏幕内。



#import <UIKit/UIKit.h>
#import "ZBSegmentItem.h"

typedef void(^ZBSegmentCtrlBlock)(NSInteger index,ZBSegmentItem *item);


@interface ZBSegmentCtrl : UIScrollView

/** <#Description#> */
@property (nonatomic, strong) NSMutableArray *items;
/** <#Description#> */
@property (nonatomic, assign) NSInteger index;
/** <#Description#> */
@property (nonatomic, assign) CGFloat fontSize;
/** <#Description#> */
@property (nonatomic, strong) UIColor *selectedColor;
/** <#Description#> */
@property (nonatomic, strong) UIColor *nomalColor;

/** <#Description#> */
@property (nonatomic, copy) ZBSegmentCtrlBlock block;

- (instancetype)initWithFrame:(CGRect)frame items:(NSMutableArray *)items block:(ZBSegmentCtrlBlock)block;





@end
