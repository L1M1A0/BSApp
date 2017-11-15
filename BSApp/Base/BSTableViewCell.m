//
//  BSTableViewCell.m
//  BSApp
//
//  Created by 李振彪 on 2017/8/14.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "BSTableViewCell.h"

@implementation BSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

@end
