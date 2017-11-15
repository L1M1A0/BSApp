//
//  BSDataEmptyView.m
//  giseGnmGkapp
//
//  Created by baothink on 16/2/29.
//  Copyright © 2016年 baothink. All rights reserved.
//

#import "BSDataEmptyView.h"

#define Gap 20
#define LabelHeight 20
#define ButtonHeight 30
#define ButtonWidth 100
@interface BSDataEmptyView ()

@end

@implementation BSDataEmptyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame click:(void (^)(void))click{
    
    self = [self initWithFrame:frame];
    if (!self.click) {
        self.click = click;
    }
    self.hidden = YES;
    return self;
}

-(void)creatUI
{
    self.backgroundColor=[UIColor whiteColor];
    self.hidden=YES;
    
    //    _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_sad.png"]];
    //    img_empty_box.png
    _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_empty_box.png"]];
    [self addSubview:_imageView];
    
    CGFloat imageWidth=self.bounds.size.width/3.0;
    CGFloat imageX=self.bounds.size.width/2-imageWidth/2.0;
    CGFloat imageY=self.bounds.size.height/2.0-imageWidth*1.2;
    _imageView.frame=CGRectMake(imageX, imageY, imageWidth, imageWidth);
    
    //    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(self.mas_centerX);
    //        make.width.equalTo(self.mas_width).multipliedBy(1/3.0);
    //        make.centerY.equalTo(self.mas_centerY).offset(-_imageView.bounds.size.width/2);
    //        make.height.equalTo(_imageView.mas_width);
    //    }];
    
    _detailLabel=[[UILabel alloc]init];
    _detailLabel.text=@"抱歉，没有找到符合条件的数据~~";
    _detailLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_detailLabel];
    _detailLabel.frame=CGRectMake(Gap, CGRectGetMaxY(_imageView.frame)+Gap,self.bounds.size.width-2*Gap, LabelHeight);
    //    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.mas_left).offset(Gap);
    //        make.right.equalTo(self.mas_right).offset(-Gap);
    //        make.top.equalTo(_imageView.mas_bottom).offset(Gap);
    //        make.height.mas_equalTo(LabelHeight);
    //    }];
    
    _refreshButton=[UIButton buttonWithType:UIButtonTypeSystem];
    _refreshButton.layer.borderWidth=1;
    _refreshButton.layer.cornerRadius=3;
    _refreshButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [_refreshButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _refreshButton.clipsToBounds=YES;
    [_refreshButton setTitle:@"点我刷新" forState:UIControlStateNormal];
    [_refreshButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_refreshButton];
    _refreshButton.frame=CGRectMake((self.bounds.size.width-ButtonWidth)/2.0, CGRectGetMaxY(_detailLabel.frame)+Gap, ButtonWidth, ButtonHeight);
    //    [_refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.mas_equalTo(self.mas_centerX);
    //        make.top.equalTo(_detailLabel.mas_bottom).offset(Gap);
    //        make.height.mas_equalTo(ButtonHeight);
    //        make.width.mas_equalTo(ButtonWidth);
    //    }];
    
}

-(void)setDetailText:(NSString *)detailText
{
    _detailText=detailText;
    _detailLabel.text=detailText;
}

-(void)buttonClick
{
    if(self.click)
    {
        self.click();
    }
}

-(void)judgeHideEmptyViewWithArray:(NSArray *)array
{
    if(array.count){
        self.hidden=YES;
    }else{
        self.hidden=NO;
    }
}
@end
