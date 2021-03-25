//
//  BSFMDBModel.h
//  BSApp
//
//  Created by lizb on 2018/9/17.
//  Copyright © 2018年 lizb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSFMDBModel : NSObject
@property (nonatomic, assign) int ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, assign) int score;

@end
