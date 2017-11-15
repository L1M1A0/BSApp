//
//  ZBBarButtonItemObject.m
//  BSApp
//
//  Created by 李振彪 on 2017/8/18.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "ZBBarButtonItemObject.h"

@implementation ZBBarButtonItemObject


+(UIBarButtonItem *)leftBar:(UIViewController *)VC target:(id)target action:(SEL)action{
    UIButton *searchBtn = [UIButton _buttonFrame:CGRectMake(0, 10, 25, 25) title:nil tColor:[UIColor clearColor] bgImage:nil target:target action:action];
    [searchBtn setImage:[UIImage imageNamed:@"icon_jiantou_left"] forState:0];
    //    searchBtn.contentMode = UIControl
    searchBtn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    searchBarItem.style = UIBarButtonItemStyleDone;
    return searchBarItem;
}

@end

