//
//  BSTimeVC.m
//  BSApp
//
//  Created by lizb on 2017/12/8.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import "BSTimeVC.h"

@interface BSTimeVC ()

@end

@implementation BSTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *time = [ZBTime currentTimeWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"currentTimeWithDateFormat_%@",time);
    time = [ZBTimestamp currentTimeStampIs1000:YES];
    NSLog(@"currentTimeStampIs1000_%@",time);
    time = [ZBTimestamp timestamp:1510824318 format:@"yyyy-MM-dd HH:mm:ss" isX1000:NO];
    NSLog(@"timestamp_%@",time);
    NSLog(@"timestamp_%@",[ZBTimestamp splitCurrentTimeToArray]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
