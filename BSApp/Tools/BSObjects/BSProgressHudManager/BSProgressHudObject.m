//
//  BSProgressHudObject.m
//  giseGnmGkapp
//
//  Created by baothink on 16/5/5.
//  Copyright © 2016年 baothink. All rights reserved.
//

#import "BSProgressHudObject.h"

@implementation BSProgressHudObject

+ (void)_initHUD:(MBProgressHUD *)hud str:(NSString *)str view:(UIView *)superView{
    
    hud.detailsLabelText = str;
    [hud show:YES];
    [superView addSubview:hud];
}


+ (void)_hideHUD:(MBProgressHUD *)hud str:(NSString *)str After:(CGFloat)time {
    
    hud.detailsLabelText = str;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
        [hud removeFromSuperview];
    });
}


+ (void)_initHUD:(MBProgressHUD *)hud str:(NSString *)str view:(UIView *)superView hideAfter:(CGFloat)time{
    
    hud.detailsLabelText = str;
    [hud show:YES];
    [superView addSubview:hud];
    [hud hide:YES afterDelay:time];
}
+ (void)_initHUDWithStr:(NSString *)str view:(UIView *)superView hideAfter:(CGFloat)time{
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
    hud.detailsLabelText = str;
    [hud show:YES];
    [superView addSubview:hud];
    [hud hide:YES afterDelay:time];
    
}


+ (void)_hideWithArray:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource view:(UIView *)superView after:(CGFloat)time{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
    [self _hideHUD:hud array:currentArray dataSource:dataSource view:superView after:time];
}


+ (void)_hideHUD:(MBProgressHUD *)hud array:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource view:(UIView *)superView after:(CGFloat)time{
    
    NSString *text = [self array:currentArray dataSource:dataSource];
    [BSProgressHudObject _initHUD:hud str:text view:superView hideAfter:time];
}

+ (void)_hideHUD:(MBProgressHUD *)hud array:(NSArray *)currentArray dataSource:(NSMutableArray *)dataSource after:(CGFloat)time{
    
    
    if(dataSource.count > 0){
        if ([currentArray count] > 0) {
            time = 0;
        }
    }
   
    hud.detailsLabelText = [self array:currentArray dataSource:dataSource];
    [hud hide:YES afterDelay:time];
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

//+ (void)_initHudWithStr:(NSString *)str view:(UIView *)superView{
//
//    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
//    hud.labelText = str;
//    [hud show:YES];
//    [superView addSubview:hud];
//}
//
//
//+ (void)_hideHudWithStr:(NSString *)str view:(UIView *)superView After:(CGFloat)time{
//
//    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
//    hud.labelText = str;
//    [hud show:YES];
//    [superView addSubview:hud];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [hud hide:YES];
//        [hud removeFromSuperview];
//    });
//}



@end
