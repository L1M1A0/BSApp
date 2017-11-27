//
//  BSBaseVCtrl.h
//  BSApp
//
//  Created by BaoThink on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSDataEmptyView.h"

@interface BSBaseVCtrl : UIViewController

/** <#Description#> */
@property (nonatomic, strong) UITableView *tableView;
/** <#Description#> */
@property (nonatomic, strong) NSMutableArray *dataSource;
/** <#Description#> */
@property (nonatomic, assign) NSInteger pageNo;
/** <#Description#> */
@property (nonatomic, strong) BSDataEmptyView *emptyView;



-(void)tableViewInIOS11;
-(void)tableViewFooterEndRefreshWhenNoMoreData:(NSMutableArray *)array;
-(void)tableViewAutomaticallyAdjustsScrollViewInsets;

-(void)enmptyView:(CGRect)frame;
@end
