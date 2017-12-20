//
//  BSControlVC.m
//  BSApp
//
//  Created by 李振彪 on 2017/12/8.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import "BSControlVC.h"
#import "ZBLinkLabel.h"

@interface BSControlVC ()

@end

@implementation BSControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    ZBLinkLabel *link = [[ZBLinkLabel alloc]initWithFrame:CGRectMake(50, 100, 50, 50)];
    [link shadowColor:kRedColor opacity:1.0 radius:50 offset:CGSizeMake(10.0f, 30.0f)];
    link.text = @"链接";
    link.backgroundColor = kGreenColor;
    [link urlStr:@"http://index.baidu.com/" linkType:ZBLableLinkURL];
    [self.view addSubview:link];
    
    UILabel *lab = [UILabel label:CGRectMake(120, 100, 50, 50) text:@"copy" tColor:kRedColor bColor:kGreenColor];
    [lab shadowColor:kRedColor opacity:1.0 radius:50 offset:CGSizeMake(10.0f, 30.0f)];
    [lab copyTextToPasteboardWhenLongTouch:0];
    [self.view addSubview:lab];
    
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 180, 130, 60)];
    [imgv shadowColor:kRedColor opacity:1.0 radius:50 offset:CGSizeMake(10.0f, 30.0f)];
    [imgv tapGestureRecognizerTarget:self action:@selector(labAction)];
    [imgv imageUrl:@"http://img.zcool.cn/community/014bfd577a0da00000018c1b587a4a.png@900w_1l_2o_100sh.jpg" placeholderImage:@"head.png" data:^(NSData *imageData) {

    }];
    [self.view addSubview:imgv];
    
    UIButton *btn = [UIButton button:CGRectMake(200, 100, 80, 50) title:@"弹窗" tColor:kWhiteColor bColor:kBlueColor];
    [btn shadowColor:kPurpleColor opacity:0.9 radius:10 offset:CGSizeMake(0, -3)];
    [btn layerWidth:3 color:kGreenColor masksToBounds:NO cornerRadius:25];
    [btn tag:0 target:self action:@selector(btnaction)];
    [self.view addSubview:btn];
  
    UISearchBar *search = [UISearchBar searchBarFrame:CGRectMake(170, 180, 150, 50) placeholder:@"fasdgew" removeBarBackgroundView:YES];
    [self.view addSubview:search];
    
    UIView *tem = [UIView viewFrame:CGRectMake(CGRectGetMaxX(search.frame), 180, 50, 50) bgColor:kYellowColor superView:self.view];
    [tem shadowColor:kGrayColor opacity:1 radius:10 offset:CGSizeMake(0, -5)];
    
}
-(void)labAction{
    ZBHud *hud = [[ZBHud alloc] initWithStr:@"hud1" view:self.view];
    //    [hud hideWithStr:@"fasd" after:1.0];
//    hud.hud.mode = MBProgressHUDModeText;
    hud.hud.color = kRedColor;
//    hud.hud.xOffset = 100;
//    hud.hud.yOffset = kScreenHeight-64;
    [hud hideWithArray:@[] dataSource:[NSMutableArray arrayWithArray:@[@"",@""]]  after:1.0];
    
}


-(void)btnaction{
    //[ZBHud initWithStr:@"afshifh" hideAfter:1.0 view:self.view];
    //[ZBHud initWithArray:@[@""] dataSource:[NSMutableArray arrayWithArray:@[@"",@""]] after:1.0 view:self.view];

    ZBAlertController *aler = [ZBAlertController alert:@"弹窗" messge:@"傻逼吗？" action1:@"不是" handler1:^(UIAlertAction *action) {

        NSLog(@"aler1");
    } action2:@"是" handler2:^(UIAlertAction *action) {
        NSLog(@"aler2");
    }];

    [aler alertShow:^{
        NSLog(@"弹窗打开完成");
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
