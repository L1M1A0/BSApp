//
//  BSListCopyView.m
//  BSApp
//
//  Created by 李振彪 on 2017/8/21.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "BSListCopyView.h"

@interface BSListCopyView ()<UITextFieldDelegate>{
    
}


@end


@implementation BSListCopyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




-(instancetype)initWithFrame:(CGRect)frame leftWidth:(CGFloat)leftWidth btnWidth:(CGFloat)btnWidth{
    
    if(self = [super initWithFrame:frame]){
        [self _createView:frame leftWidth:leftWidth btnWidth:btnWidth];
    }
    return self;
    
}

- (void)_createView:(CGRect)frame leftWidth:(CGFloat)leftWidth btnWidth:(CGFloat)btnWidth{
    
    self.listCell = [[BSListCell alloc]initWithFrame:CGRectMake(0, 0, self.width-btnWidth-20, self.height) title:@"" placeholder:@"" leftViewWidth:leftWidth];
    self.listCell.inputTF.delegate = self;
    self.listCell.inputTF.enabled = NO;
    [self addSubview:self.listCell];
    
    UIButton *btn = [UIButton _buttonFrame:CGRectZero title:@"复制" tColor:kBlackColor target:self action:@selector(btnAction:)];
    [btn _layerWidth:1 color:RGBAlpha(0, 0, 0, 0.4) masksToBounds:YES cornerRadius:5];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:btn];
    self.btn = btn;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self.listCell mas_right]).offset(10);
        make.top.equalTo([self.listCell mas_top]).offset(3);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(self.height-3*2);
    }];
    
    self.btnWidth = btnWidth;

}

-(void)btnAction:(UIButton *)sender{

    [BSCommomObject copyStrToPasteboard:self.listCell.inputTF.text];

//    if (self.delegate && [self.delegate respondsToSelector:@selector(BSListCopyView:btn:)]) {
//        [self.delegate BSListCopyView:self btn:sender];
//    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}

-(void)setBtnWidth:(CGFloat)btnWidth{
    _btnWidth = btnWidth;
    if (btnWidth == 0) {
        self.btn.hidden = YES;
    }else{
        self.btn.hidden = NO;
    }
    
    self.listCell.frame = CGRectMake(0, 0, self.width-btnWidth-20, self.height);
    [self.btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnWidth);

    }];
}



@end
