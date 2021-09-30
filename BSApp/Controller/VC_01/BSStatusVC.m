//
//  BSStatusVC.m
//  BSApp
//
//  Created by lizb on 2019/9/22.
//  Copyright © 2019 lizb. All rights reserved.
//

#import "BSStatusVC.h"

@interface BSStatusVC ()

@end

@implementation BSStatusVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
