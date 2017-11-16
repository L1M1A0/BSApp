//
//  UITableViewCell+ZBCategory.h
//  BSApp
//
//  Created by 李振彪 on 2017/11/16.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ZBCategory)

/** cell所在的tableleView的 section 和 row 位置 */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
