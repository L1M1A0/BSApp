//
//  VC_02.m
//  BSApp
//
//  Created by BaoThink on 16/8/18.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "VC_02.h"
#import "BSGuPiaoVC.h"

@interface VC_02 ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *titles;
    NSArray *vctrls;
}
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation VC_02

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titles = @[@"股票计算",@"html"];
    vctrls = @[@"BSGuPiaoVC",@""];
    
    
   
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView headerRefreshAction:^{
        NSLog(@"刷新开始");
        [self.tableView.mj_header beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"刷新完成");
            [self.tableView.mj_header endRefreshing];
        });
    }];
    
    [self.tableView footerLoadMoreAction:^{
        
    }];
    
    
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titles.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"gupiaodide";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    Class vcclass = NSClassFromString(vctrls[indexPath.row]);
    UIViewController *vc = [[vcclass alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    
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
