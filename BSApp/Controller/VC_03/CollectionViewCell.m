//
//  CollectionViewCell.m
//  BSApp
//
//  Created by LZBiao on 2021/9/21.
//  Copyright © 2021 LZBiao. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor purpleColor];
        
        self.contentView.layer.cornerRadius = 10.0;
        self.contentView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        self.contentView.layer.shadowOffset = CGSizeMake(0,10);
        self.contentView.layer.shadowOpacity = 1;
        self.contentView.layer.shadowRadius = 4;
        self.contentView.layer.backgroundColor = kRedColor.CGColor;
        
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetWidth(self.frame)-10)];
        self.imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.imgView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.frame)-10, 20)];
        self.text.backgroundColor = [UIColor brownColor];
        self.text.textAlignment = NSTextAlignmentCenter;
        self.text.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.text];
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = CGRectMake(5, CGRectGetMaxY(self.text.frame), CGRectGetWidth(self.frame)-10,30);
        [self.btn setTitle:@"按钮" forState:UIControlStateNormal];
        self.btn.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.btn];
    }
    return self;
}

-(void)setData:(NSDictionary *)data{
    _data = data;
    UIColor *color =  (UIColor *)data[@"color"];
    self.contentView.layer.backgroundColor = color.CGColor;
    self.imgView.image = [UIImage imageNamed:data[@"image_name"]];
    self.text.text = data[@"main_title"];
    [self.btn setTitle:data[@"btn_title"] forState:0];
}

@end
