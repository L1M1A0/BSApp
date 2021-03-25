//
//  CustPhoneAlertView.m
//  Marketing
//
//  Created by lizb on 16/8/25.
//  Copyright © 2016年 forr. All rights reserved.
//

#import "CustPhoneAlertView.h"
#import "Masonry.h"
@implementation CustPhoneAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView:frame];
    }
    return self;
}

- (void)createView:(CGRect)frame{
    
    CGFloat leftGap = 5;
    CGFloat titleViewHeight  = 10+30+5;
    CGFloat buttonViewHeight = 35;
    
    CGFloat contentViewHeight = frame.size.height-titleViewHeight-buttonViewHeight;
    self.contentViewRect = CGSizeMake(frame.size.width-leftGap-leftGap, contentViewHeight);
    NSLog(@"dfasdnpnb_%f,%f",self.contentViewRect.width,self.contentViewRect.height);
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"标题";
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftGap);
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(-leftGap);
        make.height.mas_equalTo(30);
    }];
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftGap);
        make.top.equalTo(self.titleLab.mas_bottom).offset(leftGap);
        make.right.equalTo(self.mas_right).offset(-leftGap);
        make.height.mas_equalTo(contentViewHeight-5);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.contentView.mas_bottom).offset(7);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.leftBtn.backgroundColor = [UIColor orangeColor];
    [self.leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setTitle:@"1" forState:0];
    [self addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.contentView.mas_bottom).offset(7.5);
        make.width.mas_equalTo(frame.size.width/2);
        make.height.mas_equalTo(buttonViewHeight-2.5);
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right).offset(-0.5);
        make.top.equalTo(self.contentView.mas_bottom).offset(7);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(32.5);
    }];

    self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.rightBtn setTitle:@"2" forState:0];
    [self.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
//    self.rightBtn.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right);
        make.top.equalTo(self.contentView.mas_bottom).offset(7.5);
        make.width.mas_equalTo(frame.size.width/2);
        make.height.mas_equalTo(buttonViewHeight-2.5);
    }];
    
    
}
-(void)leftAction{
    if([self.delegate respondsToSelector:@selector(alertViewLeftBtnAction)]){
        [self.delegate alertViewLeftBtnAction];
    }
}

-(void)rightAction{
    if ([self.delegate respondsToSelector:@selector(alertViewRightBtnAction)]) {
        [self.delegate alertViewRightBtnAction];
    }
}


@end
