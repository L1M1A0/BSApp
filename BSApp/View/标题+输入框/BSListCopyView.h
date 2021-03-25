//
//  BSListCopyView.h
//  BSApp
//
//  Created by lizb on 2017/8/21.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSListCell.h"
//@protocol BSListCopyViewDelegate;
@interface BSListCopyView : UIView

/** c */
@property (nonatomic, strong) BSListCell *listCell;
/** <#Description#> */
@property (nonatomic, strong) UIButton *btn;

/** <#Description#> */
@property (nonatomic, assign) CGFloat btnWidth;


///** <#Description#> */
//@property (nonatomic, assign) id<BSListCopyViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame leftWidth:(CGFloat)leftWidth btnWidth:(CGFloat)btnWidth;


@end

//@protocol BSListCopyViewDelegate <NSObject>
//
//-(void)BSListCopyView:(BSListCopyView *)view btn:(UIButton *)sender;
//
//@end
