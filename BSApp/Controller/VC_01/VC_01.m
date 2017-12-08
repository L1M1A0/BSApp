//
//  VC_01.m
//  BSApp
//
//  Created by BaoThink on 16/8/18.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "VC_01.h"
#import "CustPhoneAlertView.h"
#import "KGModal.h"
#import "ZBAlertController.h"
#import "UILabel+ZBCategory.h"
#import "ZBTableViewCell.h"
#import "BSUpdate.h"
#import "ZBHud.h"

#import "BSControlVC.h"
#import "BSFMDBVC.h"
#import "BSTimeVC.h"



@interface VC_01 ()<UITableViewDelegate,UITableViewDataSource,CustPhoneAlertViewDelegate>{
    NSArray *vctrs;
    NSArray *texts;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KGModal *modalView;

@end

@implementation VC_01


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[[BSUpdate alloc]init]checkAppUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    vctrs = @[@"BSControlVC",@"BSFMDBVC",@"BSTimeVC"];
    texts = @[@"控件页面",@"FMDB数据库",@"时间管理"];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

}




-(void)alertViewLeftBtnAction{
    [self.modalView hide];
}
-(void)alertViewRightBtnAction{
    [self.modalView hideAnimated:YES withCompletionBlock:^{
        NSLog(@"jfspa_-fasdn");
    }];
}


#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return vctrs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idididididiid = @"idijhofsdhfoadoa";
    
    ZBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idididididiid];
    if(!cell){
        cell = [[ZBTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idididididiid];
    }
    cell.textLabel.text = texts[indexPath.row];
//    cell.indexPath = 10+indexPath.row;
    cell.indexPath = indexPath;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZBTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    NSLog(@"cell.index_%ld",cell.indexPath.row);
    
    Class vcName = NSClassFromString(vctrs[indexPath.row]);
    UIViewController * vc = [[vcName alloc]init];
    vc.title = texts[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = kWhiteColor;
    [self.navigationController pushViewController:vc animated:YES];
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
