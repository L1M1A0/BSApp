//
//  BSBaseVCtrl.m
//  BSApp
//
//  Created by BaoThink on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSBaseVCtrl.h"

@interface BSBaseVCtrl()<UIAlertViewDelegate>{
    
}

/** <#Description#> */
@property (nonatomic, copy) NSString *appUrl;

/** <#Description#> */
@property (nonatomic, assign) NSInteger updateType;

@end

@implementation BSBaseVCtrl

-(void)tableViewInIOS11{
    if(isIOS11){
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
}
-(void)tableViewFooterEndRefreshWhenNoMoreData:(NSMutableArray *)array{
    
    if (array.count == 0 && self.pageNo > 1) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

-(void)tableViewAutomaticallyAdjustsScrollViewInsets{
    if (isIOS11) {
        self.tableView.contentInsetAdjustmentBehavior = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}


-(void)enmptyView:(CGRect)frame{
    __weak typeof(self) weakSelf = self;
    self.emptyView = [[BSDataEmptyView alloc]initWithFrame:frame click:^{
        
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    [self.view addSubview:self.emptyView];
}



@end
