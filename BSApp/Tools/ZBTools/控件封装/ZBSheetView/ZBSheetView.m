//
//  ZBSheetView.m
//  BSApp
//
//  Created by lizb on 2017/8/19.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "ZBSheetView.h"

@implementation ZBSheetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (instancetype)initWithFrame:(CGRect)frame items:(NSMutableArray *)items coloum:(NSInteger)coloum{
//    if(self = [super initWithFrame:frame]){
//        [self createView:frame items:items coloum:coloum];
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.frame = frame;
    }
    return self;
}

- (void)createView:(CGRect)frame items:(NSArray *)items coloum:(NSInteger)coloum{
    self.labArr = [NSMutableArray array];
    self.lays = [NSMutableArray array];
    for (int i = 0; i < coloum; i++) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:@[]];
        [self.labArr addObject:arr];
    }

    self.viewHeight = frame.size.height;
//    NSLog(@"asdhfodgjslfbajwfka_%f,%lf",frame.size.height,self.viewHeight);

    CGFloat width = frame.size.width;
    
    [self checkWidthModel];

    
    CGFloat leftGap = 10;
    CGFloat labHeight = ZBSheetViewlabHeight;//(frame.size.height-leftGap*2)/tttt.count;//除以每列
    CGFloat averageWidth = (width-leftGap*2)/coloum;
    CGFloat labwidth = 0;//(kScreenWidth-leftGap*(coloum+1))/coloum;

    NSMutableArray *titles = [NSMutableArray array];
    UILabel *temp = [UILabel new];


    
    for (int i = 0; i < [items[0] count]; i++) {
        
        
//        NSMutableArray *otherWidths = [NSMutableArray array];
        for (int j = 0; j < coloum; j++) {
            UILabel *lab = [self lab:@"" size:kFontDefaultSize view:self];
//            lab.backgroundColor = kRedColor;
//            lab.numberOfLines = 0;
            
            NSString *str = [self str:items[j][i]];
            NSMutableAttributedString *astr = [ZBAttributedString attributedStr:str firstLineHeadIndent:5 headIndent:5 tailIndent:0 alignment:NSTextAlignmentJustified];
            lab.attributedText = astr;
            
            [lab layerWidth:0.25 color:kGroupTableViewBackgroundColor masksToBounds:YES cornerRadius:0];
            
            //根据类型，计算每列宽度
            if(self.widthModel == ZBSheetViewWidthAverage){
                labwidth = averageWidth;
            }else if (self.widthModel == ZBSheetViewWidthSpecifyTheFirst){
                if (j == 0) {
                    
                    //未设置第一列宽度的时候使用平均值
                    if(!self.firstColoumWidth){
                        labwidth = averageWidth;
                        self.firstColoumWidth = averageWidth;
                    }else{
                        labwidth = self.firstColoumWidth;
                    }
                }else{
                    //减去第一列宽度，其余的平均分
                    labwidth = (width-leftGap*2-self.firstColoumWidth)/(coloum-1);
                }
                
            }else if (self.widthModel == ZBSheetViewWidthSpecifyAll){
                if(!self.itemWidths || self.itemWidths.count == 0){
                    labwidth = averageWidth;
                }else{
                    
                    //数组小于列数，数组中不足的部分，剩余的列平分剩余的宽度。
                    if( self.itemWidths.count<coloum){
                        if(self.itemWidths.count-1 >= j){
                            labwidth = [self.itemWidths[j] floatValue];
                        }else{
                            CGFloat tempWidth = 0;
                            for (int k = 0; k < self.itemWidths.count; k++) {
                                CGFloat a = [self.itemWidths[k] floatValue];
                                tempWidth = tempWidth + a;
                            }
                            labwidth = (width-leftGap*2-tempWidth)/(coloum - self.itemWidths.count);
                        }

                    }else{
                        labwidth = [self.itemWidths[j] floatValue];
                    }
                }
            }else{
                
            }
            
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {

                if (i == 0) {
                    make.top.equalTo(self.mas_top).offset(leftGap);
                }else{
                    if (j == 0) {
                        make.top.equalTo(temp.mas_bottom).offset(0);
                    }else{
                        make.top.equalTo(temp.mas_top).offset(0);
                    }
                }
                if (j == 0) {
                    make.left.equalTo(self.mas_left).offset(leftGap);
                }else{
                    make.left.equalTo(temp.mas_right).offset(0);
                }
                make.width.mas_equalTo(labwidth);
                make.height.mas_equalTo(labHeight);

            }];
            
            if (j < coloum-1) {
                temp = lab;
                [titles addObject:lab];
            }
            
            [self.labArr[j] addObject:lab];
        }
    }
    

}
-(UILabel *)lab:(NSString *)text size:(CGFloat)size view:(UIView *)view{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = text;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [UIFont systemFontOfSize:size];
    [view addSubview:lab];
    return lab;
}


-(void)frame:(CGRect)frame items:(NSArray *)items coloum:(NSInteger)coloum{
    [self removeSubViewAndLayer];
    [self createView:frame items:items coloum:coloum];

}
-(void)frame:(CGRect)frame items:(NSArray *)items coloum:(NSInteger)coloum widthModel:(ZBSheetViewWidthModel)widthModel{
    self.widthModel = widthModel;
    [self frame:frame items:items coloum:coloum];
}
-(void)items:(NSArray *)items coloum:(NSInteger)coloum widthModel:(ZBSheetViewWidthModel)widthModel{
    [self frame:self.frame items:items coloum:coloum widthModel:widthModel];
}

-(void)removeSubViewAndLayer{
    for(id view in self.subviews){
        if([view isKindOfClass:[UILabel class]]){
            UILabel * lab = (UILabel *)view;
            [lab removeFromSuperview];
        }
    }
    
    NSLog(@"layer.cont_%ld,%ld",self.layer.sublayers.count,self.lays.count);
    
    for (CALayer *lay in self.lays) {
        [lay removeFromSuperlayer];
    }
    
    [self.labArr removeAllObjects];
    [self.lays removeAllObjects];
}

-(void)checkWidthModel{
    if(!self.widthModel){
        self.widthModel = ZBSheetViewWidthAverage;
    }

}
-(void)setWidthModel:(ZBSheetViewWidthModel)widthModel{
    _widthModel = widthModel;

}

-(NSString *)str:(NSString *)str{
    if (str.length == 0) {
        return @"--";
    }else{
        return str;
    }
}
-(void)setViewHeight:(CGFloat)viewHeight{
    _viewHeight = viewHeight;
}

@end
