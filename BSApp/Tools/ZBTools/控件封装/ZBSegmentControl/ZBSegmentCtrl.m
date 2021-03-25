//
//  ZBSegmentCtrl.m
//  BSApp
//
//  Created by lizb on 2017/10/13.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "ZBSegmentCtrl.h"
#import "ZBStringSize.h"

@interface ZBSegmentCtrl()
{
    
}

/** <#Description#> */
@property (nonatomic, strong) NSMutableArray *widths;

@end
@implementation ZBSegmentCtrl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame items:(NSMutableArray *)items block:(ZBSegmentCtrlBlock)block{
    if(self = [super initWithFrame:frame]){
        [self createView:frame items:items];
        self.block = block;
    }
    return self;
}


- (void)createView:(CGRect)frame items:(NSMutableArray *)items{
    
    
    self.items = [NSMutableArray array];
    self.widths = [NSMutableArray array];
    CGFloat lineHeight = 0.3;

    CGFloat countWidth = 0;
    for (int i = 0; i < items.count; i++) {
        CGSize size = [ZBStringSize stringCountLong:items[i] fontSize:15];
        CGFloat wid = size.width+10;
        countWidth = wid + countWidth;
        [self.widths addObject:[NSString stringWithFormat:@"%f",wid]];
    }

    if (countWidth < kScreenWidth) {
        CGFloat tempWidth = (kScreenWidth - countWidth)/items.count;
        NSMutableArray *newWidths = [NSMutableArray array];
        for (int i = 0; i < self.widths.count; i++) {
            CGFloat newWidth = [self.widths[i] floatValue];
            newWidth = newWidth + tempWidth;
            [newWidths addObject:[NSString stringWithFormat:@"%f",newWidth]];
        }
        if (newWidths.count > 0 && newWidths.count == self.widths.count) {
            [self.widths removeAllObjects];
            [self.widths addObjectsFromArray:newWidths];
        }
    }
    
    
    CGFloat itemTempX = 0;

    for (int i = 0; i < items.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
        CGFloat wi = [self.widths[i] floatValue];
        
        ZBSegmentItem *item = [[ZBSegmentItem alloc]initWithFrame:CGRectMake(itemTempX, 0, wi, frame.size.height-lineHeight)];
        item.tag = i;
        item.titleLabel.backgroundColor = kWhiteColor;
        item.titleLabel.text = items[i];
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        [item addGestureRecognizer:tap];
        [self addSubview:item];
        [self.items addObject:item];
        
        itemTempX = wi + itemTempX;
        
        if (i == 0) {
            item.selected = YES;
        }else{
            item.selected = NO;
        }
    }
    self.contentSize = CGSizeMake(/*itemWidth*items.count*/itemTempX, frame.size.height);
    self.showsVerticalScrollIndicator   = FALSE;
    self.showsHorizontalScrollIndicator = FALSE;
    self.bounces = NO;
    self.index = 0;
    //self.contentSize.width
    [ZBLayer layer:CGRectMake(0, frame.size.height-lineHeight, itemTempX, lineHeight) color:kBlackColor view:self];
    
    
}

-(void)setBlock:(ZBSegmentCtrlBlock)block{
    _block = block;
}


-(void)setIndex:(NSInteger)index{
    _index = index;
}
-(void)tap:(UITapGestureRecognizer *)tap{
    ZBSegmentItem *item = (ZBSegmentItem *)tap.view;
    self.index = item.tag;
    
    for (int i = 0; i < self.items.count; i++) {
        ZBSegmentItem *view = self.items[i];
        if (view.tag == item.tag) {
            view.selected = YES;
        }else{
            view.selected = NO;
        }
    }
    
    //选中居中 http://www.jianshu.com/p/91756e72c9e5
    CGFloat _margin = 0;
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat offSetX = item.center.x - self.bounds.size.width * 0.5 + _margin;
        CGFloat offsetX1 = (self.contentSize.width - item.center.x) - self.bounds.size.width * 0.5 + _margin;
        if (offSetX > 0 && offsetX1 > 0) {
            self.contentOffset = CGPointMake(offSetX, 0);
        }else if(offSetX < 0){
            self.contentOffset = CGPointMake(0, 0);
        }else if (offsetX1 < 0){
            self.contentOffset = CGPointMake(self.contentSize.width - self.bounds.size.width - _margin, 0);
        }
    }];

    self.block(self.index, item);
}

-(void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    for (int i = 0; i < self.items.count; i++) {
        ZBSegmentItem *view = self.items[i];
        view.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    
    for (int i = 0; i < self.items.count; i++) {
        ZBSegmentItem *view = self.items[i];
        view.selectedColor = selectedColor;
        if (i == self.index) {
            view.selected = YES;
        }else{
            view.selected = NO;
        }
    }
}
-(void)setNomalColor:(UIColor *)nomalColor{
    _nomalColor = nomalColor;
    for (int i = 0; i < self.items.count; i++) {
        ZBSegmentItem *view = self.items[i];
        view.nomalColor = nomalColor;
        if (i == self.index) {
            view.selected = YES;
        }else{
            view.selected = NO;
        }
    }
}



@end
