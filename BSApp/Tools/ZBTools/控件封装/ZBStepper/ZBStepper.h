//
//  ZBStepper.h
//  BSApp
//
//  Created by lizb on 2017/7/19.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 步进器，点击不同按钮可以按一定幅度增减（改变数据）
 */
@interface ZBStepper : UIView{
    
}


/** 左侧按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
/** 右侧按钮 */
@property (nonatomic, strong) UIButton *rightBtn;
/** 中间输入框 */
@property (nonatomic, strong) UITextField *textField;
/** 当前输入的值 */
@property (nonatomic, strong) NSString *string;
/** 是否在输入的时候检测数值超过指定范围 */
@property (nonatomic, assign) BOOL isCheckWhenValueChanged;

/** 初始值、默认值，当前值 */
@property (nonatomic, assign) double value;
/**
 最小值,等0或0.00~~时会无效，所以需要需要将值设置成所需要得到小数位长度的后面加多一位数字
 如，需要得到3位小数，但是在最小值设置为0或0.000的时候是无效的，所以需要在0.000之后加多任意位小数值，使其变成0.0001或者0.000003等更多小数位的数字，以此类推
 */
@property (nonatomic, assign) double minValue;

/**
 最大值,等0或0.00~~时会无效，所以需要需要将值设置成所需要得到小数位长度的后面加多一位数字
 如，需要得到3位小数，但是在最大值设置为0或0.000的时候是无效的，所以需要在0.000之后加多任意位小数值，使其变成0.0001或者0.000003等更多小数位的数字
 */
@property (nonatomic, assign) double maxValue;

/** 是否需要使用极限值。 */
@property (nonatomic, assign) BOOL isUseLimitValue;
/** 当数字低于minValue时，修改当前值为最小极限值，*/
@property (nonatomic, assign) double minLimitValue;
/** 当数字高于maxValue时，修改当前值为最大极限值， */
@property (nonatomic, assign) double maxLimitValue;

/**
 步进增长幅度，必须设置
 */
@property (nonatomic, assign) double increment;

/** 小数位长度（精确度） */
@property (nonatomic, assign) NSInteger decimalLength;



//@property BOOL valueWraps;

/**
 自动改变（加减）
 */
@property (nonatomic, assign) BOOL autorepeat;

- (void)showLayer;


@end
