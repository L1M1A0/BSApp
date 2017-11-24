//
//  BSLoginVC.m
//  BSApp
//
//  Created by BaoThink on 16/8/17.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSLoginVC.h"
#import "BSLoginManager.h"
#import "FHFileManager.h"
#import "BSListCell.h"
#import "ZBImageButton.h"

@interface BSLoginVC ()<UITextFieldDelegate>
{
    
}

/** 登录按钮 */
@property (strong, nonatomic) UIButton    *loginBtn;
/** 等于2才可登录 */
@property (nonatomic , assign) NSUInteger allowLogin;

/** <#Description#> */
@property (nonatomic, strong) BSListCell *userTF;
/** <#Description#> */
@property (nonatomic, strong) BSListCell *passTF;
@end

@implementation BSLoginVC


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _initView];
    
    
}


- (void)_initView{
    self.title = @"登录";
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.view.y = 64;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_jiantou_left"] style:UIBarButtonItemStyleDone target:self action:@selector(comeBack)];
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(endEditing:)];
    //    [self.view addGestureRecognizer:tap];
    
    CGFloat gap = 20;
    NSArray *places = @[@"用户名/手机号",@"请输入密码"];
    NSArray *titles = @[@"  账号",@"  密码"];
    for (int i = 0; i < 2; i++) {
        BSListCell *cell = [[BSListCell alloc]initWithFrame:CGRectMake(gap, 100+45*i+10*i, kScreenWidth-gap*2, 45) title:titles[i] placeholder:places[i] leftViewWidth:50];
        cell.fontSize = 14;
        cell.bgColor = kWhiteColor;
        cell.inputTF.delegate = self;
        [cell.inputTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell.leftView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.view addSubview:cell];
        
        [ZBLayer layer:CGRectMake(0, cell.height-1, cell.width, 1) color:kGroupTableViewBackgroundColor view:cell];
        
        if (i == 0) {
            self.userTF = cell;
            self.userTF.inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        }else{
            self.passTF = cell;
            self.passTF.inputTF.secureTextEntry = YES;
            cell.width = kScreenWidth-gap*2-30;
            
            UIButton *btn = [UIButton button:CGRectMake(CGRectGetMaxX(cell.frame), CGRectGetMinY(cell.frame), 30, CGRectGetHeight(cell.frame)) title:nil tColor:kClearColor bColor:kClearColor];
            [btn tag:0 target:self action:@selector(securityBtn:)];
            [btn setImage:[UIImage imageNamed:@"securityPassword_hide72"] forState:0];
            btn.contentMode = UIViewContentModeScaleAspectFit;
            btn.selected = YES;
            [self.view addSubview:btn];
            
        }
    }
    
    self.loginBtn = [UIButton button:CGRectMake(gap, CGRectGetMaxY(self.passTF.frame)+30, kScreenWidth-gap*2, 40) title:@"登录" tColor:kWhiteColor target:self action:@selector(loginAction:)];
    self.loginBtn.backgroundColor = kGroupTableViewBackgroundColor;
    self.loginBtn.userInteractionEnabled = NO;
    [self.loginBtn.layer setMasksToBounds:YES];
    [self.loginBtn.layer setCornerRadius:5];
    [self.view addSubview:self.loginBtn];
    
    
    UIButton *registBtn = [UIButton button:CGRectMake(gap, CGRectGetMaxY(self.loginBtn.frame)+10, 100, 25) title:@"手机快速注册" tColor:kGrayColor target:self action:@selector(_regerstAction)];
    registBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    registBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:registBtn];
    
    UIButton *findPassWordBtn = [UIButton button:CGRectMake(kScreenWidth-gap-100, CGRectGetMaxY(self.loginBtn.frame)+10, 100, 25) title:@"忘记密码" tColor:kGrayColor target:self action:@selector(_findPassWord)];
    findPassWordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    findPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:findPassWordBtn];
    
   
    
    //默认显示最后一次登录成功用户的账号
    self.userTF.inputTF.text = [ZBUserDefault defaultValueForKey:kDefaultLastLoginUserEmpCode];
    self.passTF.inputTF.text = @"";
    
    //临时
    //    self.passTF.inputTF.text = @"123456";
    
    
}



-(void)securityBtn:(UIButton *)sender{
    if (sender.selected == YES) {
        self.passTF.inputTF.secureTextEntry  = NO;
        sender.selected = NO;
        [sender setImage:[UIImage imageNamed:@"securityPassword_show72"] forState:0];
    }else{
        self.passTF.inputTF.secureTextEntry  = YES;
        sender.selected = YES;
        [sender setImage:[UIImage imageNamed:@"securityPassword_hide72"] forState:0];
        
    }
}
- (void)loginAction:(UIButton *)sender
{
    
    [self.userTF.inputTF resignFirstResponder];
    [self.passTF.inputTF resignFirstResponder];
    NSString *userId = self.userTF.inputTF.text;
    NSString *password = self.passTF.inputTF.text;
    
    
    if (userId.length==0)
    {
        kAlert(nil, @"请您输入登录帐号");
        return;
    }
    if (userId.length < 4 || userId.length > 20) {
        kAlert(nil, @"您输入的账号长度不对(4-20位)");
        return;
    }
    if (password.length==0)
    {
        kAlert(nil, @"请输入登录密码");

        return;
    }
    if (password.length < 4 || password.length > 16){
        kAlert(nil,@"您输入的密码长度不对(6-16位)");

        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
    [BSProgressHudObject _initHUD:hud str:@"" view:self.view];
    
    
    NSString *urlStr  = [NSString stringWithFormat:@"%@",KBaseUrl(@"login")];
    password          = [BSSecurityParameters rsaEncryptPassWord:password];
    NSDictionary *dic = [BSSecurityParameters getLoginSecurityParameters];
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:@{@"password":password,@"BRSS_UserId":userId/*,@"entType":@"2"*/}];
    [para addEntriesFromDictionary:dic];
    
    __weak BSLoginVC *weakSelf = self;
    [BSHttpTool get:urlStr parameters:para success:^(ZBHttpResult *result) {
        
        NSLog(@"登录成功_%@",result.responseObject);
        //保存当前登录用户信息到本地
        //        BSUserModel *user = [BSUserModel mj_objectWithKeyValues:CONVERTER(result.object[@"data"])];
        
        NSDictionary *dic = result.object[@"data"];
        [BSLoginManager saveUserDic:dic];
        
        NSString *empcode = weakSelf.userTF.inputTF.text;//dic[@"empCode"]==nil?@"":dic[@"empCode"];
        [ZBUserDefault defaultValue:empcode key:kDefaultLastLoginUserEmpCode];
        
        weakSelf.isLoginSuccess = YES;
        if (_loginSuccess) {
            _loginSuccess();
        }
        
        AppDelegate *delegare = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegare.jPushObject setupJpushAlias];
        [BSProgressHudObject _hideHUD:hud str:@"登录成功!" After:1.0];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(ZBHttpResult *result) {
        
        kAlert(@"登录失败", result.message);
        [BSProgressHudObject _hideHUD:hud str:@"" After:0];
        //NSLog(@"登录失败_%@",result.message);
        
    }];
}



- (void)comeBack
{
    self.isLoginSuccess = NO;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)textFieldDidChange:(UITextField *)textField{
    if (self.passTF.inputTF.text.length > 0 && self.userTF.inputTF.text.length > 0 ) {
        self.loginBtn.backgroundColor = kDefaultBlueColor;
        self.loginBtn.userInteractionEnabled = YES;
    }else{
        self.loginBtn.backgroundColor = kGroupTableViewBackgroundColor;
        self.loginBtn.userInteractionEnabled = NO;
    }
}


/** 注册按钮 */
- (void)_regerstAction{
//    DXRegistrationPhoneVC *viewC = [[DXRegistrationPhoneVC alloc]init];
//    //    viewC.title = @"免费注册";
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:viewC animated:YES];
    
}
-(void)_findPassWord{
//    DXFindPasswordPicVC *viewC = [[DXFindPasswordPicVC alloc]init];
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:viewC animated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

