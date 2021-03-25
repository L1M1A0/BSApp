//
//  UITableView+ZBCategory.m
//  BSApp
//
//  Created by lizb on 2017/10/17.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "UITableView+ZBCategory.h"

@implementation UITableView (ZBCategory)

-(void)estimatedInIOS11{
    if(isIOS11){
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
}

- (UITableView *)tableView:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delegate{
    UITableView *tab = [[UITableView alloc]initWithFrame:frame style:style];
    tab.delegate   = delegate;
    tab.dataSource = delegate;
    return tab;
}

- (void)headerRefreshAction:(void (^)(void))action{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:action];
}
- (void)footerLoadMoreAction:(void (^)(void))action{
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:action];
}

@end
