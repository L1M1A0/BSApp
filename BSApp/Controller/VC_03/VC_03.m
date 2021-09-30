//
//  VC_03.m
//  BSApp
//
//  Created by BaoThink on 16/8/18.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "VC_03.h"

@interface VC_03 ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation VC_03
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    self.hidesBottomBarWhenPushed = NO;//解决push页面之后，返回后切换tabbarItem导致的tabbar隐藏问题
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = @[
    @{@"title":@"UICollectionView",@"vctr":@"CollectionVCtr"}];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kNavigationBarHeight(self), kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *IDE = @"cellinv3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDE];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDE];
    }
    cell.textLabel.text = [self.dataSource[indexPath.row] valueForKey:@"title"];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hidesBottomBarWhenPushed = YES;
    
    Class vc = NSClassFromString([self.dataSource[indexPath.row] valueForKey:@"vctr"]);
    UIViewController *vctr = [[vc alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
    
    
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
