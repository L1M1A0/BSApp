//
//  BSAboutVC.m
//  CloudShop
//
//  Created by BaoThink on 15/11/17.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import "BSAboutVC.h"

@interface BSAboutVC ()


@end

@implementation BSAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initView];
    
}


- (void)_initView{
    self.title = @"关于";
    //self.view.y = 64;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //logo
    //y=5
    CGFloat y_new = kScreenHeight/3-90;
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-110, y_new, 220, 90)];
    //    logoView.backgroundColor = [UIColor redColor];
    logoView.image = [UIImage imageNamed:@"log_about"];
    [self.view addSubview:logoView];

    //版本
    NSString *verStr = [ZBAppObject customAppVersion1];
    
    UILabel *editionLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoView.frame)+10, kScreenWidth, 20)];
    editionLab.text = [NSString stringWithFormat:@"%@",verStr];
    editionLab.font = [UIFont systemFontOfSize:12];
    editionLab.textAlignment = NSTextAlignmentCenter;
    if (![kBaseUrl isEqualToString:kDistributionUrl]){
        editionLab.text = [NSString stringWithFormat:@"%@(测试 vc:%@)",verStr,VERSION_CODE];
    }
    [self.view addSubview:editionLab];
    
    
    //二维码
    //    UIImageView *QrCode = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-70, 115, 140, 140)];
    ////    QrCode.backgroundColor = [UIColor redColor];
    //    QrCode.image = [UIImage imageNamed:@"icon_qr_code.png"];
    //    [self.view addSubview:QrCode];
    //
    //    //二维码描述
    //    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, kScreenWidth, 20)];
    //    detailLab.text = @"扫描二维码,您的朋友也可以下载博汇大宗客户端";
    //    detailLab.font = [UIFont systemFontOfSize:12];
    //    detailLab.textAlignment = NSTextAlignmentCenter;
    //    [self.view addSubview:detailLab];
    //
    
    //[self _createCheckUpdateButton];
    
    
    //editionLab
    UILabel *copyRightLab = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-144, kScreenWidth, 20)];
    copyRightLab.text = @"Copyright@2014-2016";
    copyRightLab.font = [UIFont systemFontOfSize:15];
    copyRightLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:copyRightLab];
    
    UILabel *companyDetailLab = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-114, kScreenWidth, 20)];
    companyDetailLab.text = @"广州宝锶科技信息技术有限公司版权所有";
    companyDetailLab.font = [UIFont systemFontOfSize:15];
    companyDetailLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:companyDetailLab];
    
}


@end
