//
//  ZBSegmentItem.m
//  BSApp
//
//  Created by lizb on 2017/10/13.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "ZBSegmentItem.h"

@implementation ZBSegmentItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self _createView:frame];
    }
    return self;
}


- (void)_createView:(CGRect)frame{
    
    CGFloat gap = 0.1;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectZero];
    lab.text = @"";
    lab.textColor = kRedColor;
    lab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(gap);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right).offset(-gap);
        make.bottom.equalTo(self.mas_bottom).offset(-2);
    }];
    self.titleLabel = lab;
 
    self.bottomLine = [CALayer layer];
    self.bottomLine.frame = CGRectMake(0, frame.size.height-2, frame.size.width, 2);
    self.bottomLine.backgroundColor = kRedColor.CGColor;
    [self.layer addSublayer:self.bottomLine];
    
    
    
    
}
-(void)setSelected:(BOOL)selected{
    _selected = selected;
    if (self.selectedColor == nil) {
        self.selectedColor = kRedColor;
    }
    if (self.nomalColor == nil) {
        self.nomalColor = kYellowColor;
    }
    
    if (selected == YES) {
        self.titleLabel.textColor = self.selectedColor;
        self.bottomLine.backgroundColor = self.selectedColor.CGColor;
    }else{
        self.titleLabel.textColor = kBlackColor;
        self.bottomLine.backgroundColor = kWhiteColor.CGColor;
    }
}


-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
}


-(void)setNomalColor:(UIColor *)nomalColor{
    _nomalColor = nomalColor;
}







@end
