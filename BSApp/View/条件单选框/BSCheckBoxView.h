//
//  BSCheckBoxView.h
//  BSApp
//
//  Created by 李振彪 on 2016/11/15.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSCheckBoxView : UIControl{
    
}

/** <#Description#> */
@property (nonatomic, strong) UIButton *checkBtn;

@property (nonatomic, strong) UILabel *rightLab;

- (void)addTag:(NSInteger)tag target:(id)target action:(SEL)action;


@end
