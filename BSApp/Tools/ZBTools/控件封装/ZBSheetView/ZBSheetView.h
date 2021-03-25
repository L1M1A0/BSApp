//
//  ZBSheetView.h
//  BSApp
//
//  Created by lizb on 2017/8/19.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, ZBSheetViewWidthModel) {
    ZBSheetViewWidthAverage,        //平均宽度
    ZBSheetViewWidthSpecifyTheFirst,//需要指定第一列的宽度，其余的平分剩余宽度
    ZBSheetViewWidthSpecifyAll      //需要分别指定每列的宽度
};
static CGFloat ZBSheetViewlabHeight = 35;

static CGFloat ZBSheetViewOffset  = 25*2;


//Excel表格
@interface ZBSheetView : UIView

/** 根据行数计算后的高度 */
@property (nonatomic, assign) CGFloat viewHeight;


/** 格子数组 */
@property (nonatomic, strong) NSMutableArray *labArr;

/** 线条数组 */
@property (nonatomic, strong) NSMutableArray *lays;

/** 每列的宽度模式 */
@property (nonatomic, assign) ZBSheetViewWidthModel widthModel;
/** ZBSheetViewWidthSpecifyTheFirst 的时候需要指定，默认为每列平均 */
@property (nonatomic, assign) CGFloat firstColoumWidth;
/** ZBSheetViewWidthSpecifyAll 用于指定每一列的宽度，存数字。默认为每列平均 */
@property (nonatomic, strong) NSArray *itemWidths;



/**
 <#Description#>

 @param items 数据量
 @param coloum 列数
 @param widthModel <#widthModel description#>
 */
- (void)items:(NSArray *)items coloum:(NSInteger)coloum widthModel:(ZBSheetViewWidthModel)widthModel ;
- (void)frame:(CGRect)frame items:(NSArray *)items coloum:(NSInteger)coloum;
- (void)frame:(CGRect)frame items:(NSArray *)items coloum:(NSInteger)coloum widthModel:(ZBSheetViewWidthModel)widthModel;

@end
