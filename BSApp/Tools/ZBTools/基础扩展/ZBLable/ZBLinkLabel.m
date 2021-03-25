//
//  ZBLinkLabel.m
//  BSApp
//
//  Created by lizb on 2017/8/8.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "ZBLinkLabel.h"
@interface ZBLinkLabel(){
    
}


@end;



@implementation ZBLinkLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self addTapToLable];
    }
    return self;
}



-(void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
}
-(void)setLinkType:(ZBLableLinkType)linkType{
    _linkType = linkType;
}
-(void)setAlertTitle:(NSString *)alertTitle{
    _alertTitle = alertTitle;
}
-(void)setAlertMessage:(NSString *)alertMessage{
    _alertMessage = alertMessage;
}

-(void)urlStr:(NSString *)urlStr linkType:(ZBLableLinkType)linkType{
    _urlStr = urlStr;
    _linkType = linkType;
}


//-(void)setTap:(UITapGestureRecognizer *)tap{
//    _tap = tap;
//}
//
//-(void)setLongTap:(UILongPressGestureRecognizer *)longTap{
//    _longTap = longTap;
//}


-(void)addTapToLable{
    [self tapGestureRecognizerTarget:self action:@selector(tapAction:)];
}


-(void)tapAction:(UITapGestureRecognizer *)tap{
    
    if (!self.linkType) {
        
        kAlert(nil, @"无法识别链接类型");
        return;
    }
    if(self.linkType != ZBLableLinkSetting){
        if (self.urlStr == nil || [self.urlStr isEqualToString:@""]) {
            kAlert(nil, @"无法链接到网站或者电话号码，因为相关信息为空或不存在");
            return;
        }
    }
    [self checkType];
}


-(void)checkType{
    if (self.linkType == ZBLableLinkPhone) {
        [self openURL:[NSString stringWithFormat:@"tel://%@",self.urlStr]];
    }
    else if (self.linkType == ZBLableLinkURL){
        //@"https://www.baidu.com"
        [self openURL:[NSString stringWithFormat:@"%@",self.urlStr]];

    }
    else if (self.linkType == ZBLableLinkSetting){
        if (isAfterIOS10) {
            [self openURL:UIApplicationOpenSettingsURLString];
        }else{
            [self openURL:@"prefs:root=WIFI"];
        }
    }
    else if (self.linkType == ZBLableLinkE_Mail){
        
    }else{
        NSLog(@"无法识别链接类型，请检查ZBLableLinkType");
    }

}

- (void)openURL:(NSString *)urlStr{

    NSURL *url = [NSURL URLWithString:urlStr];

    //打开设置
    //iOS 10以前
    //NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];

    //iOS 10 以后
    //NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];//YES：失败;NO:成功

    if (isIOS10 || isAfterIOS10) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication]openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {
                NSLog(@"链接或媒体跳转成功");
            }];
        } else {
            // Fallback on earlier versions
        }
    }else{
        [[UIApplication sharedApplication]openURL:url];
    }

}




@end
