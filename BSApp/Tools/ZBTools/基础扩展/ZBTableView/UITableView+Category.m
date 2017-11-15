//
//  UITableView+Category.m
//  BSApp
//
//  Created by 李振彪 on 2017/10/17.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "UITableView+Category.h"

@implementation UITableView (Category)

-(void)estimatedInIOS11{
    if(isIOS11){
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
}

@end
