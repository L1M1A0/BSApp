//
//  BSAlertView.m
//  BSApp
//
//  Created by lizb on 2016/11/14.
//  Copyright © 2016年 lizb. All rights reserved.
//

#import "BSAlertView.h"

#import "Masonry.h"



@interface BSAlertView (){
    
}
/** <#Description#> */
@property (nonatomic, strong) UITapGestureRecognizer *tap;

/** <#Description#> */
@property (nonatomic, assign) CGFloat alertViewHeight;

@end


@implementation BSAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame alertPointX:(CGFloat)pointX contentViewHeight:(CGFloat)contentViewHeight{

    if (self = [super initWithFrame:frame]) {
        [self createView:frame alertPointX:pointX  contentViewHeight:contentViewHeight];
        
    }
    return self;
}



/**
 初始化的时候，frame的最小高度是100 //满屏
 */
- (void)createView:(CGRect)frame alertPointX:(CGFloat)alertX contentViewHeight:(CGFloat)contentViewHeight{
//    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    
    CGFloat leftGap = 5;
    CGFloat titleViewHeight  = 10+30+5;
    CGFloat buttonViewHeight = 45;
    
    CGFloat alertH = titleViewHeight + buttonViewHeight + contentViewHeight;
//    CGFloat alertX = x;
    CGFloat alertY = (frame.size.height - alertH)/2.5;
    CGFloat alertW = frame.size.width - alertX*2;
    self.alertViewHeight = alertH;

    
    self.alertView = [[UIView alloc]init];
    self.alertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.alertView];
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(alertX);
        make.top.equalTo(self.mas_top).offset(alertY);
        make.right.equalTo(self.mas_right).offset(-alertX);
        make.height.mas_equalTo(alertH);
    }];
    
    
   // CGFloat contentViewHeight = frame.size.height-titleViewHeight-buttonViewHeight;
    self.contentViewRect = CGSizeMake(alertW - leftGap * 2, contentViewHeight);
    //NSLog(@"dfasdnpnb_%f,%f",self.contentViewRect.width,self.contentViewRect.height);
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"标题";
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.backgroundColor = [UIColor clearColor];
    [self.alertView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView.mas_left).offset(leftGap);//
        make.top.equalTo(self.alertView.mas_top).offset(leftGap);//
        make.right.equalTo(self.alertView.mas_right).offset(-leftGap);//-leftGap
        make.height.mas_equalTo(titleViewHeight - leftGap * 2);//35
    }];
    
    CALayer *layer = [CALayer layer];

    layer.frame = CGRectMake(0, titleViewHeight - leftGap * 2+0.5, alertW, 0.5);
    layer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.alertView.layer addSublayer:layer];
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView removeGestureRecognizer:self.tap];
    [self.alertView addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView.mas_left).offset(leftGap);
        make.top.equalTo(self.titleLab.mas_bottom).offset(leftGap);
        make.right.equalTo(self.alertView.mas_right).offset(-leftGap);
        make.height.mas_equalTo(contentViewHeight-5);
    }];
    
    self.line1 = [[UIView alloc]init];
    self.line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.alertView addSubview:self.line1];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView.mas_left);
        make.top.equalTo(self.contentView.mas_bottom).offset(7);
        make.right.equalTo(self.alertView.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    
    CGFloat btnWidth = alertW / 2;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.tag = 0;
    [self.leftBtn addTarget:self action:@selector(actionForButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.leftBtn setTitle:@"0" forState:0];
    [self.leftBtn setTitleColor:kButtonSystemColor forState:0];
    [self.alertView addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView.mas_left);
        make.top.equalTo(self.contentView.mas_bottom).offset(7.5);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(buttonViewHeight-2.5);
    }];
    
    self.line2 = [[UIView alloc]init];
    self.line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.alertView addSubview:self.line2];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right).offset(-0.5);
        make.top.equalTo(self.contentView.mas_bottom).offset(7);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(buttonViewHeight-2.5);
    }];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitle:@"1" forState:0];
    self.rightBtn.tag = 1;
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.rightBtn addTarget:self action:@selector(actionForButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitleColor:kButtonSystemColor forState:0];
    [self.alertView addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right);
        make.top.equalTo(self.contentView.mas_bottom).offset(7.5);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(buttonViewHeight-2.5);
    }];
    
    self.backgroundColor = RGBAlpha(0, 0, 0, 0.4);
    [self.alertView.layer setMasksToBounds:YES];
    [self.alertView.layer setCornerRadius:3.0];
    
    [self addContentView];
}


- (void)addContentView{
    
}

//- (void)setCanTouchBackGroundView:(BOOL)canTouchBackGroundView{
//    if (canTouchBackGroundView == YES) {
//        [self addGestureRecognizer:self.tap];
//    }else{
//        [self removeGestureRecognizer:self.tap];
//    }
//}
//

- (void)actionForButtonAtIndex:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(bsAlertView:clickedButtonAtIndex:)]) {
        [self.delegate bsAlertView:self clickedButtonAtIndex:sender.tag];
    }
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}



- (void)hide{
    
    [self removeFromSuperview];
}

- (void)hideTitleLable{

    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(-35);
    }];
    [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.alertViewHeight-35);
    }];
}


//- (void)alertViewUpdateFrame:(CGFloat)contentViewHeight{
//    
//    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(contentViewHeight);
//    }];
//    [self.line1 mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_bottom).offset(7);
//    }];
//    [self.leftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_bottom).offset(7.5);
//    }];
//    [self.line2 mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_bottom).offset(7);
//    }];
//    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_bottom).offset(7.5);
//    }];
//}

-(void)alertViewUpdateFrame:(CGRect)alertViewFrame{
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            
        }];
        [self.line1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_bottom).offset(7);
        }];
        [self.leftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_bottom).offset(7.5);
        }];
        [self.line2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_bottom).offset(7);
        }];
        [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_bottom).offset(7.5);
        }];
}

-(void)setIsContenViewModel:(BOOL)isContenViewModel{
    _isContenViewModel = isContenViewModel;
    self.titleLab.hidden = isContenViewModel;
    //    alertView.canTouchBackGroundView = hide;
    self.line1.hidden = isContenViewModel;
    self.line2.hidden = isContenViewModel;
    self.leftBtn.hidden = isContenViewModel;
    self.rightBtn.hidden = isContenViewModel;
    
    if(isContenViewModel == YES){
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(-35);
        }];
        [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            //减去标题高度，减去按钮高度
            make.height.mas_equalTo(self.alertViewHeight-35-35);
        }];
    }else{
        //还原
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(5);
        }];
        [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.alertViewHeight);
        }];
    }
    
  

    
}



@end
