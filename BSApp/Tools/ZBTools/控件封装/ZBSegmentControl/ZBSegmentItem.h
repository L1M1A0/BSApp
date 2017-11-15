//
//  ZBSegmentItem.h
//  BSApp
//
//  Created by 李振彪 on 2017/10/13.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBSegmentItem : UIView{
    
}
/** <#Description#> */
@property (nonatomic, strong) UILabel *titleLabel;
/** <#Description#> */
@property (nonatomic, strong) CALayer *bottomLine;
/** <#Description#> */
@property (nonatomic, assign) BOOL selected;
/** <#Description#> */
@property (nonatomic, strong) UIColor *selectedColor;
/**  */
@property (nonatomic, strong) UIColor *nomalColor;


@end
