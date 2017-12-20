//
//  BSGuPiaoVC.m
//  BSApp
//
//  Created by 李振彪 on 2017/12/18.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import "BSGuPiaoVC.h"
@interface BSGuPiaoVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *titles;
    NSArray *vctrls;
}



@end

@implementation BSGuPiaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titles = @[@"股票计算"];
    vctrls = @[];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
   
}
-(void)refreshData{
    self.pageNo = 1;
    [self loadMoreData];
}
-(void)loadMoreData{
    NSString *urlStr = [NSString stringWithFormat:@"%@",KBaseUrl(@"")];
    NSDictionary *para = @{};
    
    [BSHttpTool get:urlStr parameters:para success:^(ZBHttpResult *result) {
        
    } failure:^(ZBHttpResult *result) {
        
    }];
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
    
//    Class vc = NSClassFromString(vctrls[indexPath.row]);
//    UIViewController *vc = [[vc alloc]init];
    
    
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
