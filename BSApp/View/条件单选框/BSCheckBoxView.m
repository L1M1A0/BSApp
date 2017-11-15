//
//  BSCheckBoxView.m
//  BSApp
//
//  Created by 李振彪 on 2016/11/15.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSCheckBoxView.h"
#import "Masonry.h"

@implementation BSCheckBoxView

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
    
    CGFloat leftX = 5;
    self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkBtn setImage:[UIImage imageNamed:@"baf_btn_radio_on"] forState:0];
    self.checkBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.checkBtn];
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftX);
        make.top.equalTo(self.mas_top).offset(leftX);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    
    self.rightLab = [[UILabel alloc]init];
    self.rightLab.text = @"标题";
    self.rightLab.textAlignment = NSTextAlignmentLeft;
    self.rightLab.backgroundColor = [UIColor clearColor];
    [self addSubview:self.rightLab];
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkBtn.mas_right).offset(leftX);
        make.top.equalTo(self.mas_top).offset(leftX);
        make.right.equalTo(self.mas_right).offset(-leftX);
        make.height.mas_equalTo(30);
    }];
    
}


- (void)addTag:(NSInteger)tag target:(id)target action:(SEL)action{
    self.checkBtn.tag = tag;
    [self.checkBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.tag = tag;
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}




@end
