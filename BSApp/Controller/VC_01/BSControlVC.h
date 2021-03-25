//
//  BSControlVC.h
//  BSApp
//
//  Created by lizb on 2017/12/8.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import "BSBaseVCtrl.h"

@interface BSControlVC : BSBaseVCtrl

@property (nonatomic, assign) int ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, assign) int score;


@end
