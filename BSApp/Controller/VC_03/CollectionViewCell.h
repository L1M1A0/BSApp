//
//  CollectionViewCell.h
//  BSApp
//
//  Created by LZBiao on 2021/9/21.
//  Copyright © 2021 李振彪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *text;
@property(nonatomic ,strong)UIButton *btn;
@end

NS_ASSUME_NONNULL_END
