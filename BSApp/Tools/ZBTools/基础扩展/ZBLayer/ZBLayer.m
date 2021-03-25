//
//  ZBLayer.m
//  BSApp
//
//  Created by lizb on 2017/8/30.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "ZBLayer.h"

@implementation ZBLayer

#pragma mark - CAShapeLayer

+ (CAShapeLayer *)dottedLine:(CGPoint)pointA pointB:(CGPoint)pointB lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor lineDashPattern:(NSArray *)lineDashPattern{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:pointA];// 起点
    [linePath addLineToPoint:pointB];// 其他点
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = lineWidth;
    lineLayer.strokeColor = strokeColor.CGColor;
    lineLayer.path = linePath.CGPath;
    //lineLayer.fillColor = nil; // 默认为blackColor
    lineLayer.lineDashPattern = lineDashPattern;//@[@1, @1];//虚线边框
    
    return lineLayer;
}

+ (NSArray *)dottedBox:(CGSize)size lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor lineDashPattern:(NSArray *)lineDashPattern{
    
    CGFloat width  = size.width;
    CGFloat height = size.height;
    
    CAShapeLayer *lineLayer1 = [self dottedLine:CGPointMake(0, 0) pointB:CGPointMake(width, 0) lineWidth:lineWidth strokeColor:strokeColor lineDashPattern:lineDashPattern];
    CAShapeLayer *lineLayer2 = [self dottedLine:CGPointMake(width, 0) pointB:CGPointMake(width, height) lineWidth:lineWidth strokeColor:strokeColor lineDashPattern:lineDashPattern];
    CAShapeLayer *lineLayer3 = [self dottedLine:CGPointMake(width, height) pointB:CGPointMake(0, height) lineWidth:lineWidth strokeColor:strokeColor lineDashPattern:lineDashPattern];
    CAShapeLayer *lineLayer4 = [self dottedLine:CGPointMake(0, height) pointB:CGPointMake(0, 0) lineWidth:lineWidth strokeColor:strokeColor lineDashPattern:lineDashPattern];
    
    NSArray *layArr = @[lineLayer1,lineLayer2,lineLayer3,lineLayer4];

    return layArr;
}

+ (void)dottedBoxForView:(UIView *)view lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor lineDashPattern:(NSArray *)lineDashPattern{
//    CGFloat width = view.frame.size.width;
//    CGFloat height = view.frame.size.height;

    NSArray *layArr = [self dottedBox:CGSizeMake(view.frame.size.width, view.frame.size.height) lineWidth:lineWidth strokeColor:strokeColor lineDashPattern:lineDashPattern];
    
    [self addShapeLayers:layArr view:view];
    
}

+(void)addShapeLayers:(NSArray *)layers view:(UIView *)view {
    for (int i = 0; i < layers.count; i++) {
        [view.layer addSublayer:layers[i]];
    }
}


-(CAShapeLayer *)shapeLay{

    CAShapeLayer *borderLayer = [CAShapeLayer layer];

    //borderLayer.position = CGPointMake(0, 95);//起点
    borderLayer.frame = CGRectMake(10, 95, kScreenWidth-10, 5);//范围
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.frame].CGPath;//矩形
    //borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;//椭圆形

    borderLayer.lineWidth = 0.5;// 1. / [[UIScreen mainScreen] scale];//边线宽
    borderLayer.lineDashPattern = @[@10, @10];//虚线边框
    //borderLayer.lineDashPattern = nil;//实线边框

    borderLayer.fillColor = [UIColor clearColor].CGColor;//内容色
    borderLayer.strokeColor = [UIColor grayColor].CGColor;//虚线颜色
//    [self.contentView.layer addSublayer:borderLayer];
    return borderLayer;
}

+(void)removeShapeLayerFromView:(UIView *)view{
    
    for (id lay in view.layer.sublayers) {
        if ([lay isKindOfClass:[CAShapeLayer class]]) {
            CAShapeLayer *alay = (CAShapeLayer *)lay;
            [alay removeFromSuperlayer];
        }
    }
}

#pragma mark - CALayer

+(CALayer *)layer:(CGRect)frame color:(UIColor *)color view:(UIView *)view{
    CALayer *lay = [CALayer layer];
    lay.frame = frame;
    lay.backgroundColor = color.CGColor;
    [view.layer addSublayer:lay];
    return lay;
}

+(void)shadow:(UIView *)view color:(UIColor *)color opacity:(float)opacity radius:(CGFloat)radius offset:(CGSize)offset{
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = opacity;
    view.layer.shadowRadius = radius;
    view.layer.shadowOffset = offset;
}
@end
