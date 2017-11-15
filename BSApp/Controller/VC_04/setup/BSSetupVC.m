//
//  BSSetupVC.m
//  CloudShop
//
//  Created by Forr on 15/11/15.
//  Copyright © 2015年 XY. All rights reserved.
//

#import "BSSetupVC.h"
#import "BSLoginManager.h"
#import "BSAboutVC.h"
#import "ZBUserDefault.h"


@interface BSSetupVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mainTableView;
}


@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imgArr;
@end

@implementation BSSetupVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMainUI];
}

- (void)setupMainUI{
    self.title = @"设置";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    

    mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) style:UITableViewStyleGrouped];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [self.view addSubview:mainTableView];
    
    BSUserModel *user = [BSLoginManager getCurrentUserInfo];
    NSString *userName = user.empName;
    NSString *userId = user.empCode;
    
    if ([userId isEqualToString:@""]&&[userName isEqualToString:@""]) {

        self.titleArr = @[@"关于"];
        self.imgArr = @[[UIImage imageNamed:@"set_about"]];

    }else{
        self.titleArr = @[@"关于",@"修改密码"];
        self.imgArr = @[[UIImage imageNamed:@"set_about"],[UIImage imageNamed:@"set_about"]];
        UIButton *quitBtn = [[UIButton alloc ]initWithFrame:CGRectMake(20, 270, kScreenWidth-40,44)];
        [quitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        quitBtn.backgroundColor = [UIColor redColor];
        quitBtn.layer.cornerRadius = 5;
        [quitBtn addTarget:self action:@selector(clickQuitAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:quitBtn];
    }
    
}

//退出程序
- (void)clickQuitAction{
    if ([BSLoginManager isLoginOfCurrentUser]) {
        [BSLoginManager removeCurrentUserInfo];
//        [[NSNotificationCenter defaultCenter]postNotificationName:NOTI_QUIT_LOGIN_SUCCESS object:nil];
        
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idente = @"mesetingIdent";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idente];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idente];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = self.imgArr[indexPath.section];
    cell.textLabel.text = self.titleArr[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        BSAboutVC *AA = [[BSAboutVC alloc]init];
        [self.navigationController pushViewController:AA
                                             animated:YES];
    }
}



@end
