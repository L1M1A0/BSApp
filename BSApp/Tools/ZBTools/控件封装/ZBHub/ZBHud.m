//
//  ZBHud.m
//  BSApp
//
//  Created by 李振彪 on 2017/11/28.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import "ZBHud.h"


@interface ZBHud (){

}


@end

@implementation ZBHud

-(MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc]init];
    }
    return _hud;
}


- (instancetype)initWithStr:(NSString *)str view:(UIView *)superView{
    self.hud.detailsLabelText = str;
    [self.hud show:YES];
    [superView addSubview:self.hud];
    return self;
}

- (void)hideWithStr:(NSString *)str after:(CGFloat)time {
    self.hud.detailsLabelText = str;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    });
}

+ (void)initWithStr:(NSString *)str hideAfter:(CGFloat)time view:(UIView *)superView {
    
    ZBHud *object = [[ZBHud alloc] initWithStr:str view:superView];
    [object hideWithStr:str after:time];
}

- (void)hideWithArray:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource after:(CGFloat)time{
    
    if(dataSource.count > 0){
        if ([currentArray count] > 0) {
            time = 0;
        }
    }
    
    self.hud.detailsLabelText = [ZBHud array:currentArray dataSource:dataSource];
    [self.hud hide:YES afterDelay:time];
}

+ (void)initWithArray:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource after:(CGFloat)time view:(UIView *)superView{
    
    NSString *text = [self array:currentArray dataSource:dataSource];
    [self initWithStr:text hideAfter:time view:superView];
}

+ (NSString *)array:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource{
    
    if(dataSource.count > 0){
        if ([currentArray count] > 0) {
            return kHudMessage_loadSuccess;
        }else{
            return kHudMessage_noMoreData;
        }
    }else{
        return kHudMessage_noMoreData;
    }
}


@end
