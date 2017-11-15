//
//  SegmentControl.m
//  GT
//
//  Created by tage on 14-2-26.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import "XTSegmentControl.h"
//#import "ProjectMember.h"
//#import "Projects.h"
//#import <SDWebImage/UIImageView+WebCache.h>

#define XTSegmentControlItemFont (15)

#define XTSegmentControlHspace (0)

#define XTSegmentControlLineHeight (2)

#define XTSegmentControlAnimationTime (0.01)

#define XTSegmentControlIconWidth (50.0)


typedef NS_ENUM(NSInteger, XTSegmentControlItemType)
{
    XTSegmentControlItemTypeTitle = 0,
    XTSegmentControlItemTypeIconUrl
};

@interface XTSegmentControlItem : UIView

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleIconView;
@property (nonatomic, assign) XTSegmentControlItemType type;

@property (nonatomic , strong) UILabel *badgeLabel;//zhudw

/** <#Description#> */
//@property (nonatomic, strong) UIColor *singleColor;




- (void)setSelected:(BOOL)selected;

@end

@implementation XTSegmentControlItem

- (id)initWithFrame:(CGRect)frame title:(NSString *)title type:(XTSegmentControlItemType)type tag:(NSInteger)tag
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _type = type;
        switch (_type) {
            case XTSegmentControlItemTypeIconUrl:
            {
                _titleIconView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-40)/2, (CGRectGetHeight(self.bounds)-40)/2, 40, 40)];
                //                [_titleIconView doCircleFrame];
                //                if (title) {
                //                    [_titleIconView sd_setImageWithURL:[title urlImageWithCodePathResizeToView:_titleIconView] placeholderImage:kPlaceholderMonkeyRoundView(_titleIconView)];
                //                }else{
                //                    [_titleIconView setImage:[UIImage imageNamed:@"tasks_all"]];
                //                }
                [self addSubview:_titleIconView];
            }
                break;
            case XTSegmentControlItemTypeTitle:
            default:
            {
                _titleLabel = ({
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(XTSegmentControlHspace, 0, CGRectGetWidth(self.bounds) - 2 * XTSegmentControlHspace, CGRectGetHeight(self.bounds))];
                    label.font = [UIFont systemFontOfSize:XTSegmentControlItemFont];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.text = title;
                    label.textColor = [UIColor blackColor];
                    label.backgroundColor = [UIColor clearColor];
                    label;
                });
                
                _badgeLabel = [self badgeLabel:title tag:tag];
                [_titleLabel addSubview:_badgeLabel];
                
                [self addSubview:_titleLabel];
            }
                break;
        }
    }
    return self;
}

//此处的tag不能为0,所以index = 0的时候，tag = 1，以此类推
-(UILabel *)badgeLabel:(NSString *)title tag:(NSInteger)tag{
    
    UILabel * badgeLabel =({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_titleLabel.frame)-24 , 3, 24, 20)];
        label.font = [UIFont systemFontOfSize:XTSegmentControlItemFont];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"";
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor redColor];
        label.tag = tag;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 10;
        label;
    });
    badgeLabel.hidden = YES;
    return badgeLabel;
}

- (void)setSelected:(BOOL)selected{
    switch (_type) {
        case XTSegmentControlItemTypeIconUrl:
        {
        }
            break;
        default:
        {
            if (_titleLabel) {
                //设置选中的时候的颜色
                [_titleLabel setTextColor:(selected? [UIColor redColor]:[UIColor blackColor])];
                
            }
        }
            break;
    }
}


//- (void)setCurrentItembgColor:(UIColor *)currentItembgColor{
//    if (currentItembgColor == nil){
//        self.currentItembgColor = [UIColor whiteColor];
//    }else{
//        self.currentItembgColor = currentItembgColor;
//    }
//}


@end

@interface XTSegmentControl ()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *contentView;

@property (nonatomic , strong) UIView *leftShadowView;

@property (nonatomic , strong) UIView *rightShadowView;


@property (nonatomic , strong) NSMutableArray *itemFrames;

@property (nonatomic , strong) NSMutableArray *items;

//@property (nonatomic) NSInteger currentIndex;

@property (nonatomic , assign) id <XTSegmentControlDelegate> delegate;

@property (nonatomic , copy) XTSegmentControlBlock block;

@end

@implementation XTSegmentControl

- (void)createComonItems:(NSArray *)titleItem{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.isShowLeftShadowView = NO;
    self.isShowRightShadowView = NO;
    
    _contentView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        [self addSubview:scrollView];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [scrollView addGestureRecognizer:tapGes];
        [tapGes requireGestureRecognizerToFail:scrollView.panGestureRecognizer];
        scrollView;
    });
    
    
    [self initItemsWithTitleArray:titleItem];
}

- (id)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem currentItemColor:(UIColor *)currentItemColor otherItemColor:(UIColor *)otherItemColor{
    
    if (self = [super initWithFrame:frame]) {
        [self createComonItems:titleItem];
        self.otherItemColor = otherItemColor;
        self.currentItemColor = currentItemColor;
        
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem
{
    if (self = [super initWithFrame:frame]) {
        [self createComonItems:titleItem];
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem delegate:(id<XTSegmentControlDelegate>)delegate
{
    if (self = [self initWithFrame:frame Items:titleItem]) {
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem selectedBlock:(XTSegmentControlBlock)selectedHandle
{
    if (self = [self initWithFrame:frame Items:titleItem]) {
        self.block = selectedHandle;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem currentItemColor:(UIColor *)currentItemColor otherItemColor:(UIColor *)otherItemColor selectedBlock:(XTSegmentControlBlock)selectedHandle
{
    if (self = [self initWithFrame:frame Items:titleItem currentItemColor:currentItemColor otherItemColor:otherItemColor]) {
        
        self.block = selectedHandle;
    }
    return self;
}


/*
 -(void)setBadgeArr:(NSArray *)badgeArr{
 _badgeArr = badgeArr;
 for (int i = 0; i < 2; i++) {
 UILabel  * badgeLab = [self viewWithTag:i+1];
 badgeLab.text = badgeArr[i];
 }
 }
 */

- (void)doTap:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:sender.view];
    
    __weak typeof(self) weakSelf = self;
    
    [_itemFrames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CGRect rect = [obj CGRectValue];
        
        if (CGRectContainsPoint(rect, point)) {
            
            [weakSelf selectIndex:idx];
            
            [weakSelf transformAction:idx];
            
            *stop = YES;
        }
    }];
}

- (void)transformAction:(NSInteger)index
{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(XTSegmentControlDelegate)] && [self.delegate respondsToSelector:@selector(segmentControl:selectedIndex:)]) {
        
        [self.delegate segmentControl:self selectedIndex:index];
        
    }else if (self.block) {
        
        self.block(index);
    }
}

- (void)initItemsWithTitleArray:(NSArray *)titleArray
{
    _itemFrames = @[].mutableCopy;
    _items = @[].mutableCopy;
    float y = 0;
    float height = CGRectGetHeight(self.bounds);
    
    NSObject *obj = [titleArray firstObject];
    if ([obj isKindOfClass:[NSString class]]) {
        for (int i = 0; i < titleArray.count; i++) {
            float x = i > 0 ? CGRectGetMaxX([_itemFrames[i-1] CGRectValue]) : 0;
            //            NSString *title = titleArray[i];
            //            CGSize size = [title getSizeWithFont:[UIFont systemFontOfSize:XTSegmentControlItemFont] constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds))];
            //            float width = 2 * XTSegmentControlHspace + size.width;
            float width = [UIScreen mainScreen].bounds.size.width/titleArray.count;
            
            CGRect rect = CGRectMake(x, y, width, height);
            [_itemFrames addObject:[NSValue valueWithCGRect:rect]];
        }
        
        for (int i = 0; i < titleArray.count; i++) {
            CGRect rect = [_itemFrames[i] CGRectValue];
            NSString *title = titleArray[i];
            XTSegmentControlItem *item = [[XTSegmentControlItem alloc] initWithFrame:rect title:title type:XTSegmentControlItemTypeTitle tag:i+1];
            //            item.tag = i;
            
            //            item.currentItembgColor = self.currentItemColor;
            if (i == 0) {
                [item setSelected:YES];
            }
            
            
            [_items addObject:item];
            [_contentView addSubview:item];
        }
        
    }
    
    
    [_contentView setContentSize:CGSizeMake(CGRectGetMaxX([[_itemFrames lastObject] CGRectValue]), CGRectGetHeight(self.bounds))];
    self.currentIndex = 0;
    [self selectIndex:0];
    //    [self resetShadowView:_contentView];
}

- (void)addRedLine
{
    if (!_lineView) {
        CGRect rect = [_itemFrames[0] CGRectValue];
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(
                                                             CGRectGetMinX(rect),
                                                             CGRectGetHeight(rect) - XTSegmentControlLineHeight,
                                                             CGRectGetWidth(rect) - 2 * XTSegmentControlHspace,
                                                             XTSegmentControlLineHeight)];
        _lineView.backgroundColor = [UIColor redColor];
        [_contentView addSubview:_lineView];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(rect)-0.5, CGRectGetWidth(self.bounds), 0.5)];
        bottomLineView.backgroundColor = [UIColor grayColor];
        [self addSubview:bottomLineView];
    }
}


//切换索引下标，当前索引下标位置
- (void)selectIndex:(NSInteger)index
{
    [self otherItemColor:self.otherItemColor];
    [self currentItemColor:self.currentItemColor];
    
    [self addRedLine];
    //原版未屏蔽
    //    if (index != _currentIndex) {
    XTSegmentControlItem *curItem = [_items objectAtIndex:index];
    CGRect rect = [_itemFrames[index] CGRectValue];
    CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
    [UIView animateWithDuration:XTSegmentControlAnimationTime animations:^{
        _lineView.frame = lineRect;
    } completion:^(BOOL finished) {
        [_items enumerateObjectsUsingBlock:^(XTSegmentControlItem *item, NSUInteger idx, BOOL *stop) {
            
            item.backgroundColor = self.otherItemColor;
            [item setSelected:NO];
            
        }];
        curItem.backgroundColor = self.currentItemColor;
        [curItem setSelected:YES];
        _currentIndex = index;
    }];
    //    }
    [self setScrollOffset:index];
}

- (void)moveIndexWithProgress:(float)progress
{
    float delta = progress - _currentIndex;
    
    CGRect origionRect = [_itemFrames[_currentIndex] CGRectValue];;
    
    CGRect origionLineRect = CGRectMake(CGRectGetMinX(origionRect) + XTSegmentControlHspace, CGRectGetHeight(origionRect) - XTSegmentControlLineHeight, CGRectGetWidth(origionRect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
    
    CGRect rect;
    
    if (delta > 0) {
        //        如果delta大于1的话，不能简单的用相邻item间距的乘法来计算距离
        if (delta > 1) {
            self.currentIndex += floorf(delta);
            delta -= floorf(delta);
            origionRect = [_itemFrames[_currentIndex] CGRectValue];;
            origionLineRect = CGRectMake(CGRectGetMinX(origionRect) + XTSegmentControlHspace, CGRectGetHeight(origionRect) - XTSegmentControlLineHeight, CGRectGetWidth(origionRect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
        }
        
        
        
        if (_currentIndex == _itemFrames.count - 1) {
            return;
        }
        
        rect = [_itemFrames[_currentIndex + 1] CGRectValue];
        
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
        
        CGRect moveRect = CGRectZero;
        
        moveRect.size = CGSizeMake(CGRectGetWidth(origionLineRect) + delta * (CGRectGetWidth(lineRect) - CGRectGetWidth(origionLineRect)), CGRectGetHeight(lineRect));
        moveRect.origin = CGPointMake(CGRectGetMidX(origionLineRect) + delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)) - CGRectGetMidX(moveRect), CGRectGetMidY(origionLineRect) - CGRectGetMidY(moveRect));
        _lineView.frame = moveRect;
        //        _lineView.center = CGPointMake(CGRectGetMidX(origionLineRect) + delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)), CGRectGetMidY(origionLineRect));
    }else if (delta < 0){
        
        if (_currentIndex == 0) {
            return;
        }
        rect = [_itemFrames[_currentIndex - 1] CGRectValue];
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
        CGRect moveRect = CGRectZero;
        moveRect.size = CGSizeMake(CGRectGetWidth(origionLineRect) - delta * (CGRectGetWidth(lineRect) - CGRectGetWidth(origionLineRect)), CGRectGetHeight(lineRect));
        moveRect.origin = CGPointMake(CGRectGetMidX(origionLineRect) - delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)) - CGRectGetMidX(moveRect), CGRectGetMidY(origionLineRect) - CGRectGetMidY(moveRect));
        _lineView.frame = moveRect;
        //        _lineView.center = CGPointMake(CGRectGetMidX(origionLineRect) - delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)), CGRectGetMidY(origionLineRect));
        if (delta < -1) {
            self.currentIndex -= 1;
        }
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    if (currentIndex != _currentIndex) {
        XTSegmentControlItem *preItem = [_items objectAtIndex:_currentIndex];
        XTSegmentControlItem *curItem = [_items objectAtIndex:currentIndex];
        [preItem setSelected:NO];
        [curItem setSelected:YES];
        _currentIndex = currentIndex;
    }
}

- (void)endMoveIndex:(NSInteger)index
{
    [self selectIndex:index];
}

- (void)setScrollOffset:(NSInteger)index
{
    if (_contentView.contentSize.width <= [UIScreen mainScreen].bounds.size.width) {
        return;
    }
    
    CGRect rect = [_itemFrames[index] CGRectValue];
    
    float midX = CGRectGetMidX(rect);
    
    float offset = 0;
    
    float contentWidth = _contentView.contentSize.width;
    
    float halfWidth = CGRectGetWidth(self.bounds) / 2.0;
    
    if (midX < halfWidth) {
        offset = 0;
    }else if (midX > contentWidth - halfWidth){
        offset = contentWidth - 2 * halfWidth;
    }else{
        offset = midX - halfWidth;
    }
    
    [UIView animateWithDuration:XTSegmentControlAnimationTime animations:^{
        [_contentView setContentOffset:CGPointMake(offset, 0) animated:NO];
        _contentView.backgroundColor = [UIColor yellowColor];
    }];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self resetShadowView:scrollView];
//}
//
//- (void)resetShadowView:(UIScrollView *)scrollView
//{
//    _leftShadowView.hidden = (scrollView.contentOffset.x <= 0.1);
//
//    _rightShadowView.hidden = ((scrollView.contentOffset.x + CGRectGetWidth(_contentView.bounds)) >= _contentView.contentSize.width-0.1);
//
//}


//int ExceMinIndex(float f)
//{
//    int i = (int)f;
//    if (f != i) {
//        return i+1;
//    }
//    return i;
//}


//-(void)setSingleTitleColor:(UIColor *)singleTitleColor{
////    for (int i = 0; i<_items.count; i++) {
////        XTSegmentControlItem *item = _items[i];
////        item.titleLabel.textColor = singleTitleColor;
////    }
//}

//设置红色角标 注意：此处的tag不能为0,所以index = 0的时候，tag = 1，以此类推
- (void)setBadgeCount:(NSInteger)badgeCount tag:(NSInteger)tag{
    UILabel  * badgeLab = [self viewWithTag:tag];
    badgeLab.font = [UIFont systemFontOfSize:11];
    badgeLab.text = [NSString stringWithFormat:@"%ld",badgeCount];
    if (badgeCount > 99) {
        badgeLab.text = @"99+";
    }
    if (badgeCount == 0) {
        badgeLab.hidden = YES;
    }else{
        badgeLab.hidden = NO;
    }
}


-(void)setIsShowLeftShadowView:(BOOL)isShowLeftShadowView{
    
    if (isShowLeftShadowView == YES) {
        _leftShadowView = ({
            UIImageView *imageView = [self shadowView:CGRectMake(0, 0, 30, CGRectGetHeight(self.bounds)) imageName:@"icon_jiantou_gray_right"];
            //            [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, CGRectGetHeight(self.bounds))];
            //            [imageView setImage:[UIImage imageNamed:@"icon_jiantou_gray_right"]];
            //            imageView.userInteractionEnabled = NO;
            imageView;
        });
        [self addSubview:_leftShadowView];
    }else{
        if (_leftShadowView) {
            _leftShadowView.hidden = YES;
        }
    }
    
}

-(void)setIsShowRightShadowView:(BOOL)isShowRightShadowView{
    if(isShowRightShadowView == YES){
        _rightShadowView = ({
            UIImageView *imageView = [self shadowView:CGRectMake(CGRectGetMaxX(self.bounds)-30, 0, 30, CGRectGetHeight(self.bounds)) imageName:@"baf_btn_radio_on"];
            //            [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.bounds)-30, 0, 30, CGRectGetHeight(self.bounds))];
            //            [imageView setImage:[UIImage imageNamed:@"baf_btn_radio_on"]];
            //            imageView.userInteractionEnabled = NO;
            imageView;
        });
        [self addSubview:_rightShadowView];
    }else{
        if (_rightShadowView) {
            _rightShadowView.hidden = YES;
        }
    }
    
    
}

- (UIImageView *)shadowView:(CGRect)frame imageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    [imageView setImage:[UIImage imageNamed:imageName]];
    imageView.userInteractionEnabled = NO;
    return imageView;
}

-(void)currentItemColor:(UIColor *)currentItemColor{
    if(currentItemColor == nil){
        self.currentItemColor = [UIColor whiteColor];
    }else{
        self.currentItemColor = currentItemColor;
    }
}
-(void)otherItemColor:(UIColor *)otherItemColor{
    if(otherItemColor == nil){
        self.otherItemColor = [UIColor whiteColor];
    }else{
        self.otherItemColor = otherItemColor;
    }
}

@end

