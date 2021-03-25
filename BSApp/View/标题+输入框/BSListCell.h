//
//  BSListCell.h
//  BSApp
//
//  Created by lizb on 2016/11/15.
//  Copyright © 2016年 lizb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSListCell : UIView


/** <#Description#> */
@property (nonatomic, strong) UIButton *leftView;//UILabel
/** 监听输入数据变化：
    [self.inputTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
 */
@property (nonatomic, strong) UITextField  *inputTF;
/** <#Description#> */
@property (nonatomic, strong) UIImageView *rightView;

/** <#Description#> */
@property (nonatomic, strong) UIColor *bgColor;
/** <#Description#> */
@property (nonatomic, assign) CGFloat fontSize;
/** <#Description#> */
@property (nonatomic, assign) CGFloat leftViewWidth;
/** <#Description#> */
@property (nonatomic, assign) CGFloat rightViewWidth;

-(instancetype)initWithFrame:(CGRect)frame
                       title:(NSString *)title
                 placeholder:(NSString *)placeholder
               leftViewWidth:(CGFloat)leftViewWidth;


/**
 显示边框图层
 */
- (void)showDefaultLayer:(UIColor *)color;

-(void)rightViewLeftLayer:(CGRect)frame hide:(BOOL)isHide color:(UIColor *)color;

/**
 设置rightView的宽度和显示模式

 @param width 宽
 @param viewMode 显示模式
 注意：1.在使用 rightView 的时候，clearButton会被覆盖掉
      2.在UITextFieldViewModeWhileEditing 模式下，当输入框变成第一响应者的时候，leftView会消失，在正式输入的时候才能显示
 */
//- (void)rightView:(CGFloat)width viewMode:(UITextFieldViewMode)viewMode;

@end
