//
//  UISearchBar+ZBCategory.m
//  CloudShop
//
//  Created by BaoThink on 16/6/28.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "UISearchBar+ZBCategory.h"

@implementation UISearchBar (ZBCategory)



#pragma mark - 初始化
+(UISearchBar *)searchBarFrame:(CGRect)frame placeholder:(NSString *)placeholder isRemoveBarBackgroundView:(BOOL)remove{
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:frame];
//    searchBar.searchBarStyle = UISearchBarStyleDefault;
    searchBar.placeholder = placeholder;
    //    self.searchBar.backgroundColor = [UIColor redColor];
   
    searchBar.barTintColor = [UIColor redColor];


    if (remove == YES) {
        [self removeBarBackgroundView:searchBar];
    }

    return searchBar;
}


#pragma mark - 扩展

+ (void)removeBarBackgroundView:(UISearchBar *)searchBar{
    
    //    UISearchBar *searchBar = [[UISearchBar alloc]init];
    for (UIView *view in searchBar.subviews) {
        
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
            
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
}

+ (void)removeBarBorderLine:(UISearchBar *)searchBar{
    [searchBar setBackgroundImage:[UIImage new]];
}


+ (void)setSearchBar:(UISearchBar *)searchBar cancelTitle:(NSString *)title{

    searchBar.showsCancelButton = YES;
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:title forState:UIControlStateNormal];
        }
    }
}




@end
