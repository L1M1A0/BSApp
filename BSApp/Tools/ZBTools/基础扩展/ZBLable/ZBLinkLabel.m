//
//  ZBLinkLabel.m
//  BSApp
//
//  Created by 李振彪 on 2017/8/8.
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
        //self = [[ZBLinkLabel alloc]initWithFrame:frame];
        
        [self addTapToLable];
    }
    return self;
}


-(void)setLink:(NSString *)link{
    _link = link;
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

-(void)setLink:(NSString *)link linkType:(ZBLableLinkType)linkType{
    _link = link;
    _linkType = linkType;
}

-(void)setTap:(UITapGestureRecognizer *)tap{
    _tap = tap;
}

-(void)addTapToLable{
    self.tap =  [self tapGestureRecognizerTarget:self action:@selector(tapAction:)];
}



-(void)tapAction:(UITapGestureRecognizer *)tap{
    
    if (!self.linkType) {
        
        kAlert(nil, @"无法识别链接类型");
        return;
    }
    if(self.linkType != ZBLableLinkSetting){
        if (self.link == nil || [self.link isEqualToString:@""]) {
        kAlert(nil, @"无法链接到网站或者电话号码，因为相关信息为空或不存在");
            return;
        }
    }
    [self checkType];
}


-(void)checkType{
    if (self.linkType == ZBLableLinkPhone) {
        [self openURL:[NSString stringWithFormat:@"tel://%@",self.link]];
    }
    else if (self.linkType == ZBLableLinkURL){
        //@"https://www.baidu.com"
        [self openURL:[NSString stringWithFormat:@"%@",self.link]];

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


        [[UIApplication sharedApplication]openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {
            NSLog(@"链接或媒体跳转成功");
        }];
    }else{

        //        if ([[UIApplication sharedApplication] canOpenURL:url])
        //        {
        //            [[UIApplication sharedApplication] openURL:url];
        //        }
        [[UIApplication sharedApplication]openURL:url];
    }


}



@end
