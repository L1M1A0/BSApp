//
//  BSTableViewCell.h
//  BSApp
//
//  Created by 李振彪 on 2017/8/14.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTableViewCell : UITableViewCell

/** cell所在的tableleView的 section 和 row 位置 */
@property (nonatomic, strong) NSIndexPath *indexPath;



@end
