//
//  VC_04.m
//  BSApp
//
//  Created by BaoThink on 16/8/18.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "VC_04.h"
#import "BSLoginVC.h"
#import "BSLoginManager.h"
#import "BSJPushSeviceObject.h"
#import "BSAboutVC.h"
#import "AppDelegate.h"
#import "ZBUserDefault.h"

#define RowHeight 50
@interface VC_04 ()<UITableViewDelegate,UITableViewDataSource>


/** 头部视图 */
@property (nonatomic, strong) UIImageView *headView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray * dataTitleArr;
@property (nonatomic, strong) NSArray *imgArr;


@end

@implementation VC_04


- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
    [self creatUI];
}

- (void)prepare{
    _dataTitleArr = @[@"关于",@"修改密码"];
    self.imgArr = @[[UIImage imageNamed:@"set.png"],[UIImage imageNamed:@"set.png"]];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)creatUI{
    _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 120)];
    _headView.image = [UIImage imageNamed:@"head.png"];
    _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //    CSUserModel * user = [CSLoginManager getCurrentUserInfo];
    //    _headView.rightAccount.text = user.userId;
    //    _headView.rightPhone.text = user.empPhone;
    [self.view addSubview:_headView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame)+50, kScreenWidth, kScreenHeight-_headView.height-49-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.rowHeight=RowHeight;
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_tableView];
    
    UIButton * exitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exitBtn.frame = CGRectMake(20, 15, kScreenWidth - 20 * 2, 45);
    [exitBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitBtn.backgroundColor = [UIColor redColor];
    exitBtn.layer.masksToBounds = YES;
    exitBtn.layer.cornerRadius = 5;
    [exitBtn addTarget:self action:@selector(exitLoginAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    [footView addSubview:exitBtn];
    _tableView.tableFooterView = footView;
    
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataTitleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.imageView.image = self.imgArr[indexPath.row];
    cell.textLabel.text = _dataTitleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //关于
        BSAboutVC * vc = [[BSAboutVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //修改密码
       
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}


#pragma mark - 退出登录
- (void)exitLoginAction{
    
    //注销远程通知(不接收推送)
    [[[BSJPushSeviceObject alloc]init] cancelRemoteMessagePush];
    
    //移除当前登陆的用户的信息
    [BSLoginManager removeCurrentUserInfo];
    [ZBUserDefault defaultValue:@"" key:@"loginIdVerification"];
    //管理应用，跳转到登陆页面
    AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [dele _initRootViewController];
    
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
