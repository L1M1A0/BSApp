//
//  BSControlVC.m
//  BSApp
//
//  Created by lizb on 2017/12/8.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import "BSControlVC.h"
#import "ZBLinkLabel.h"

@interface BSControlVC ()

@end

@implementation BSControlVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
  
}

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
    

    
    UIButton *btn = [UIButton button:CGRectMake(200, 100, 80, 50) title:@"ZBAlert"];
    [btn shadowColor:kPurpleColor opacity:0.9 radius:10 offset:CGSizeMake(0, -3)];
    [btn layerWidth:3 color:kGreenColor masksToBounds:NO cornerRadius:25];
    [btn tag:0 target:self action:@selector(btnaction)];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton button:CGRectMake(CGRectGetMaxX(btn.frame)+10, 100, 80, 50) title:@"ZBSheet"];
    btn2.backgroundColor = kRedColor;
    [btn2 target:self action:@selector(btnaction2)];
    [self.view addSubview:btn2];
    
    
    if(systemVersionInt >= 13){
        
        UIView *tem = [UIView viewFrame:CGRectMake(CGRectGetMaxX(btn.frame), 180, 50, 50) bgColor:kYellowColor superView:self.view];
        [tem shadowColor:kGrayColor opacity:1 radius:10 offset:CGSizeMake(0, -5)];
    }else{
        UISearchBar *search = [UISearchBar searchBarFrame:CGRectMake(170, 180, 150, 50) placeholder:@"fasdgew" removeBarBackgroundView:YES];
        [self.view addSubview:search];
        
        UIView *tem = [UIView viewFrame:CGRectMake(CGRectGetMaxX(search.frame), 180, 50, 50) bgColor:kYellowColor superView:self.view];
        [tem shadowColor:kGrayColor opacity:1 radius:10 offset:CGSizeMake(0, -5)];
    }

    
    
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

    
    //    kAlert(@"sdfa", @"ddd");
    //    [ZBAlertController alert:@"fdf" message:@"dsd"];
    //    kAlertSelf(@"承fasfa", @"",@"我知道了", self);
    //    [ZBAlertController alert:@"ddad" message:@"dfas" btnTitle:@"aaa" viewController:self];
        
    //    ZBAlertController *ac = [ZBAlertController alert:@"fasf" messge:@"afsdfhoahf" action1:@"1111" handler1:^(UIAlertAction *action) {
    //        NSLog(@"111");
    //    } action2:@"222" handler2:^(UIAlertAction *action) {
    //        NSLog(@"222");
    //    }];
        
    //    ZBAlertController *ac = [ZBAlertController alert:@"fasdfa" messge:@"fasdhofash" action:@"111" handler:^(UIAlertAction *action) {
    //        NSLog(@"%@",action.title);
    //    }];
    ZBAlertController *ac = [ZBAlertController alert:@"biati" messge:@"沙发背诵" actions:@[@"11",@"22"] handler:^(UIAlertAction *action) {
       NSLog(@"%@",action.title);

    }];
    [ac addAction:@"4444" handler:^(UIAlertAction *action) {
        NSLog(@"4444");
    }];
    [ac addActions:@[@"5555",@"6666"] handler:^(UIAlertAction *action) {
       NSLog(@"%@",action.title);
    }];

    [ac alertShow:self completion:^{
       NSLog(@"alert打开完成");
    }];
    

}
-(void)btnaction2{
    ZBAlertController *sheet = [ZBAlertController sheet:@"sheet" messge:@"sheet测试" actions:kAlertActions handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
    }];
    [sheet alertShow];
//    [sheet alertShow:^{
//        NSLog(@"sheet显示");
//    }];
    
    
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
