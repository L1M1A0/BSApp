//
//  BSListCell.m
//  BSApp
//
//  Created by 李振彪 on 2016/11/15.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSListCell.h"
#import "Masonry.h"

@interface BSListCell ()<UITextFieldDelegate>{
}
/** <#Description#> */
@property (nonatomic, strong) CALayer *rightViewLeftLay;

@end

@implementation BSListCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder leftViewWidth:(CGFloat)leftViewWidth{
    
    if(self = [super initWithFrame:frame]){
        [self _createView:frame title:title placeholder:placeholder leftViewWidth:leftViewWidth];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if(self = [super initWithFrame:frame]){
//        [self _createView:frame];
//    }
//    return self;
//}


- (void)_createView:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder leftViewWidth:(CGFloat)leftViewWidth{
    
    self.leftViewWidth = leftViewWidth;
    CGFloat fontSize = 16;

    
    //titleLab.backgroundColor = [UIColor yellowColor];
    self.leftView = [self createView:fontSize title:title tag:1];
    
    
    
    self.inputTF = [[UITextField alloc]init];
    self.inputTF.leftView = self.leftView;
    self.inputTF.leftViewMode = UITextFieldViewModeAlways;
//    self.inputTF.rightView = self.rightView;
//    self.inputTF.rightViewMode = UITextFieldViewModeNever;
    self.inputTF.placeholder = placeholder;
//    self.inputTF.delegate=  self;
//    self.inputTF.secureTextEntry = YES;
    self.inputTF.backgroundColor = RGB(252, 252, 252);
    //[textV setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    if (systemVersionInt < 13) {
        [self.inputTF setValue:[UIFont boldSystemFontOfSize:fontSize] forKeyPath:@"_placeholderLabel.font"];
    }else{
        self.inputTF.font = [UIFont systemFontOfSize:fontSize];
    }
    //self.inputTF = [self _tfFrame:CGRectZero title:title placeholder:placeholder];
    [self addSubview:self.inputTF];

    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputTF.leftView.mas_left);
        make.top.equalTo(self.inputTF.leftView.mas_top);
        make.width.mas_equalTo(leftViewWidth);
        make.bottom.equalTo(self.inputTF.leftView.mas_bottom);
    }];
    
    
   
    
    self.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];//[self createView:fontSize title:@"" tag:2];
    self.rightView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputTF.mas_right);
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(leftViewWidth);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    CALayer *rightViewLeftLay = [CALayer layer];
    rightViewLeftLay.frame = CGRectMake(0.2, 5, 0.35, frame.size.height-5);
    rightViewLeftLay.backgroundColor = kGroupTableViewBackgroundColor.CGColor;
    [self.rightView.layer addSublayer:rightViewLeftLay];
    self.rightViewLeftLay = rightViewLeftLay;
    rightViewLeftLay.hidden = YES;
    
    //默认隐藏rightView
    [self setRightViewWidth:0];

}

-(UIButton *)createView:(CGFloat)fontSize title:(NSString *)title tag:(NSInteger)tag{
    
    UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.leftView.text = title;
    //    self.leftView.font = [UIFont systemFontOfSize:fontSize];
    //    self.leftView.textAlignment = NSTextAlignmentRight;
    leftView.backgroundColor = RGB(252, 252, 252);
    [leftView setTitle:title forState:0];
    [leftView setTitleColor:[UIColor blackColor] forState:0];
    leftView.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    leftView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [leftView addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    return leftView;
}

-(void)setLeftViewWidth:(CGFloat)leftViewWidth{
    _leftViewWidth = leftViewWidth;
    [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(leftViewWidth);
    }];
}




-(void)setRightViewWidth:(CGFloat)rightViewWidth{
    
    _rightViewWidth = rightViewWidth;
    
    if (rightViewWidth == 0) {
        self.rightView.hidden = YES;
    }else{
        self.rightView.hidden = NO;
    }
    
    [self.inputTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-rightViewWidth);
    }];
    
    [self.rightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rightViewWidth);
    }];
}
-(void)rightViewLeftLayer:(CGRect)frame hide:(BOOL)isHide color:(UIColor *)color{
    self.rightViewLeftLay.backgroundColor = color.CGColor;
    self.rightViewLeftLay.hidden = isHide;
    self.rightViewLeftLay.frame = frame;
}


- (void)showDefaultLayer:(UIColor *)color{
    [self.layer setBorderWidth:1];
    [self.layer setBorderColor:color.CGColor];
    [self.layer setCornerRadius:1];
}



//仅限于点击当前的lefeView
-(void)tapAction:(UIButton *)sender{
//    [self.inputTF endEditing:YES];
    [self.inputTF resignFirstResponder];

}

-(void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    self.inputTF.font = [UIFont systemFontOfSize:fontSize];
    self.leftView.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.inputTF.backgroundColor = bgColor;
    self.leftView.backgroundColor = bgColor;
    self.rightView.backgroundColor = bgColor;
    self.backgroundColor = bgColor;
}



@end
