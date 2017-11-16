//
//  ZBTableViewCell.m
//  BSApp
//
//  Created by 李振彪 on 2017/11/16.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import "ZBTableViewCell.h"

@implementation ZBTableViewCell


-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
