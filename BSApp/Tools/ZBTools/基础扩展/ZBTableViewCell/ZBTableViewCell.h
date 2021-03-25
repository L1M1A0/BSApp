//
//  ZBTableViewCell.h
//  BSApp
//
//  Created by lizb on 2017/11/16.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBTableViewCell : UITableViewCell

/** cell所在的tableleView的 section 和 row 位置 */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
