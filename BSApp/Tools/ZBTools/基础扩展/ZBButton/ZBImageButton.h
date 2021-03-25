//
//  ZBImageButton.h
//  BSApp
//
//  Created by lizb on 2016/12/22.
//  Copyright © 2016年 BaoThink. All rights reserved.
//



///

#import <UIKit/UIKit.h>



@interface ZBImageButton : UIControl
{
    
}


/** <#Description#> */
@property (nonatomic, strong) UIImageView *imageView;

/** <#Description#> */
@property (nonatomic, strong) UIImage *selectedImage;

/** <#Description#> */
@property (nonatomic, strong) UILabel *titleLabel;

/** <#Description#> */
@property (nonatomic, assign) CGFloat imageViewWidth;

/** <#Description#> */
@property (nonatomic, assign) BOOL isSelected;

//初始化

/**
 BSImageButton
 
 @param frame frame
 @param title 标题
 @param image 常态下的图片
 @param isLeftImage 图片是否在左边
 @return BSImageButton
 */
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image isLeftImage:(BOOL)isLeftImage;



/**
 对整个control添加方法，点图片和标题位置都能响应相同的事件。
 */
- (void)addTag:(NSInteger)tag target:(id)target action:(SEL)action;

/**
 给点击标题的位置另外添加方法。实现点击图片和标题有不同的响应事件。
 注意：需要先设置【addTag:target:action:】方法，否则无响应。

 @param target <#target description#>
 @param action <#action description#>
 */
-(void)titleLabTarget:(id)target action:(SEL)action;

//-(instancetype)initWithCustomView:(UIView *)customView isImageOnTheLeft:(BOOL)isImageOnTheLeft;
@end
