//
//  ZBSegmentControl.m
//  BSApp
//
//  Created by 李振彪 on 2016/10/31.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "ZBSegmentControl.h"

@interface ZBSegmentControl (){
    
}
/** <#Description#> */
@property (nonatomic, strong) NSArray *items;
/** <#Description#> */
@property (nonatomic, assign) CGFloat itemW;
/** <#Description#> */
@property (nonatomic, assign) CGFloat itemH;
/** <#Description#> */
@property (nonatomic, strong) NSMutableArray *lays;

@end

@implementation ZBSegmentControl



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items{
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUIWithFrame:frame items:items];
    }
    
    return self;
}

- (void)createUIWithFrame:(CGRect)frame items:(NSArray *)items{
    self.items = items;
    self.lays = [NSMutableArray array];
    
    
    CGFloat gap = 1;
    self.itemH = frame.size.height;
    self.itemW = frame.size.width / items.count;
    
   
    
    self.buttonArray = [NSMutableArray array];
    for (int i = 0; i < items.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =  CGRectMake(self.itemW * i, gap, self.itemW-gap, self.itemH-gap*2);
        [btn setTitle:items[i] forState:0];
        [btn setTitleColor:[UIColor redColor] forState:0];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];

        btn.tag = i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor whiteColor];
        [self addSubview:btn];
        [self.buttonArray addObject:btn];

    }
    if (!self.currentIndex) {
        self.currentIndex = 0;

    }
    
}

- (void)btnAction:(UIButton *)sender{
    //任何情况下都响应
    [self _minTag:0 maxTag:self.buttonArray.count-1 subviews:self.subviews currentSelect:sender.tag];
    
    //    NSLog(@"btn.tag = %ld",sender.tag);
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControl:button:)]) {
        [self.delegate segmentControl:self button:sender];
    }


}



//执行时间：初始化或修改索引时，设置颜色时，响应代理时
- (void)_minTag:(NSInteger)minTag maxTag:(NSInteger)maxTag subviews:(NSArray<__kindof UIView *> *)subViews currentSelect:(NSInteger)currentSelect{
    _currentIndex = currentSelect;

    //NSLog(@"currentSelect_%ld",currentSelect);
    //默认初始化的颜色
    if (self.nomalBackgroundColor == nil || self.nomalTitleColor == nil || self.selectedBackgroundColor == nil || self.selectedTitleColor == nil ) {
        
        [self itemNomalBackgroundColor:[UIColor whiteColor] nomalTitleColor:[UIColor redColor] selectedBackgroundColor:[UIColor redColor] selectedTitleColor:[UIColor whiteColor]];
    }
    
    for (UIButton *btn in subViews)
    {
        if (btn.tag>=minTag && btn.tag<=maxTag && [btn isKindOfClass:[UIControl class]])
        {
            
            
            if (btn.tag != currentSelect) {
                [self _btn:btn selected:NO bColor:self.nomalBackgroundColor tColor:self.nomalTitleColor];
            }else{
                [self _btn:btn selected:YES bColor:self.selectedBackgroundColor tColor:self.selectedTitleColor];
            }
        }
    }

    
    
}

- (void)_btn:(UIButton *)sender selected:(BOOL)selected bColor:(UIColor *)bColor tColor:(UIColor *)tColor{
    sender.selected = selected;
    sender.backgroundColor = bColor;
    [sender setTitleColor:tColor forState:0];
}


- (void)itemNomalBackgroundColor:(UIColor *)nbColor nomalTitleColor:(UIColor *)ntColor selectedBackgroundColor:(UIColor *)sbColor selectedTitleColor:(UIColor *)stColor{
    self.nomalBackgroundColor    = nbColor;
    self.nomalTitleColor         = ntColor;
    self.selectedBackgroundColor = sbColor;
    self.selectedTitleColor      = stColor;
    
    
    [self _minTag:0 maxTag:self.buttonArray.count-1 subviews:self.subviews currentSelect:self.currentIndex];
}

/** 初始化时必须设置 */
-(void)setCurrentIndex:(NSInteger)currentIndex{

    [self _minTag:0 maxTag:self.buttonArray.count-1 subviews:self.subviews currentSelect:currentIndex];
    
}
-(void)setFontSize:(CGFloat)fontSize{
    
    for (UIButton *button in self.buttonArray) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
}

- (void)itemNomalBackgroundColor:(UIColor *)nbColor nomalTitleColor:(UIColor *)ntColor selectedBackgroundColor:(UIColor *)sbColor selectedTitleColor:(UIColor *)stColor isUnSelect:(BOOL)isUnSelect{
    self.nomalBackgroundColor    = nbColor;
    self.nomalTitleColor         = ntColor;
    self.selectedBackgroundColor = sbColor;
    self.selectedTitleColor      = stColor;
    
    NSInteger max = self.currentIndex;
    
    if (isUnSelect == YES) {
        max++;
    }
    
    [self _minTag:0 maxTag:self.buttonArray.count-1 subviews:self.subviews currentSelect:max];
}


-(void)showSeparatorHeight:(CGFloat)height{
    for (int i = 1; i < self.items.count; i++) {
        CALayer *lay = [ZBLayer layer:CGRectMake(self.itemW * i-0.5, (self.itemH-height)/2, 0.5, height) color:kGroupTableViewBackgroundColor view:self];
        [self.lays addObject:lay];
    }
}
-(void)removeSeparator{
    for (CALayer *lay in self.lays) {
        [lay removeFromSuperlayer];
    }
    [self.lays removeAllObjects];
}

@end
