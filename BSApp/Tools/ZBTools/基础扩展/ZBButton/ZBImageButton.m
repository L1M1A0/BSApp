//
//  ZBImageButton.m
//  BSApp
//
//  Created by 李振彪 on 2016/12/22.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "ZBImageButton.h"
#import "Masonry.h"

#define imageGapToTop 0


@interface ZBImageButton ()
{
    
}

/** <#Description#> */
@property (nonatomic, strong) UIImage *nomalImage;
///** <#Description#> */
@property (nonatomic, assign) BOOL isLeft;

@end

@implementation ZBImageButton



-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image isLeftImage:(BOOL)isLeftImage{
    
    if (self = [super initWithFrame:frame]) {
        [self createViewFrame:frame title:title image:image isImageOnTheLeft:isLeftImage];
    }
    return self;
}

- (void)createViewFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image isImageOnTheLeft:(BOOL)isImageOnTheLeft{
    
    self.imageViewWidth = 17;
    if (isImageOnTheLeft == YES) {
        self.imageView = [self _imgV];
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.width.mas_equalTo(self.imageViewWidth);
        }];
        
        self.titleLabel = [self _lab];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_right).offset(2);
            make.right.equalTo(self.mas_right).offset(0);
        }];
        
    }else{
        
        self.titleLabel = [self _lab];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(2);
            make.right.equalTo(self.mas_right).offset(-self.imageViewWidth-2);
        }];
        
        self.imageView = [self _imgV];
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(0);
            make.width.mas_equalTo(self.imageViewWidth);
        }];
    }
    
    self.titleLabel.text = title;
    self.isLeft = isImageOnTheLeft;
    self.nomalImage = image;
    self.selected = NO;
}

- (UILabel *)_lab{
    UILabel *lab = [[UILabel alloc]init];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.height.equalTo(self.mas_height);
    }];
    return lab;
}

- (UIImageView *)_imgV{
    UIImageView *imgv = [[UIImageView alloc]init];
    imgv.backgroundColor = [UIColor clearColor];
    imgv.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(imageGapToTop);
        make.bottom.equalTo(self.mas_bottom).offset(-imageGapToTop);
    }];
    return imgv;
}

- (void)addTag:(NSInteger)tag target:(id)target action:(SEL)action{
    self.tag = tag;
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

-(void)titleLabTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    self.titleLabel.userInteractionEnabled = YES;
    [self.titleLabel addGestureRecognizer:tap2];
}

-(void)setSelectedImage:(UIImage *)selectedImage{
    _selectedImage = selectedImage;
    
}

-(void)setImageViewWidth:(CGFloat)imageViewWidth{
    
    _imageViewWidth = imageViewWidth;
    
    if (self.isLeft == YES) {
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.imageViewWidth);
        }];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_right).offset(2);
        }];
    }else{
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-self.imageViewWidth-2);
        }];
        
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(0);
            make.width.mas_equalTo(self.imageViewWidth);
        }];
    }
}

-(void)setSelected:(BOOL)selected{
    if (selected == YES) {
        if(self.selectedImage == nil){
            self.selectedImage = self.nomalImage;
        }
        self.imageView.image = self.selectedImage;
        self.isSelected = YES;
    }else{
        self.imageView.image = self.nomalImage;
        self.isSelected = NO;
    }
    
}


-(BOOL)isSelected{
    if (!_isSelected) {
        _isSelected = NO;
    }
    return _isSelected;
}

-(void)layerWidth:(CGFloat)width color:(UIColor *)color masksToBounds:(BOOL)boolValue cornerRadius:(CGFloat)cornerRadius{
    [self.layer setMasksToBounds:boolValue];
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    
}


@end
