//
//  VC_01.m
//  BSApp
//
//  Created by BaoThink on 16/8/18.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "VC_01.h"
#import "CustPhoneAlertView.h"
#import "KGModal.h"
#import "ZBAlertController.h"
#import "ZBLinkLabel.h"
#import "UILabel+ZBCategory.h"
@interface VC_01 ()<UITableViewDelegate,UITableViewDataSource,CustPhoneAlertViewDelegate>{
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KGModal *modalView;

@end

@implementation VC_01

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    UIButton *btn = [UIButton _buttonFrame:CGRectMake(100, 100, 100, 100) title:@"显示弹窗" tColor:kRedColor target:self action:@selector(btnaction)];
    [self.view addSubview:btn];

    ZBLinkLabel *link = [[ZBLinkLabel alloc]initWithFrame:CGRectMake(100, 250, 100, 100)];
    link.text = @"fasf";
    link.backgroundColor = kYellowColor;
    [link setLink:@"sddfas" linkType:nil];
    [self.view addSubview:link];
    
    UISpringLoadedInteraction *springInteraction = [[UISpringLoadedInteraction alloc] initWithActivationHandler:^(UISpringLoadedInteraction * _Nonnull interaction, id<UISpringLoadedInteractionContext>  _Nonnull context) {
//        HandleViewActivationBlock block = [weakSelf getHandleViewActivationBlock];
        // Do something here
    }];
    
    [link addInteraction:springInteraction];
    

    
}


-(void)btnaction{
////    self.view.backgroundColor = [UIColor grayColor];
//    CustPhoneAlertView *ale = [[CustPhoneAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-100, 300)];
//    ale.backgroundColor = [UIColor whiteColor];
//    ale.userInteractionEnabled = YES;
//    ale.delegate = self;
////    [self.view addSubview:ale];
//
//    NSLog(@"asdghda-pfbj_%f,%f,%f,%f",ale.contentView.width,ale.contentView.height,ale.contentViewRect.width,ale.contentViewRect.height);
//
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ale.contentViewRect.width, ale.contentViewRect.height) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
////    ale.contentView = self.tableView;
//    [ale.contentView addSubview:self.tableView];
//
//    self.modalView= [KGModal sharedInstance];
//    self.modalView.showCloseButton = NO;
//    [self.modalView showWithContentView:ale andAnimated:YES];
//
//
//
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    ZBAlertController *aler = [ZBAlertController alert:@"bafd" messge:@"asdhaodhgo1" action1:@"asdf8asdf" handler1:^(UIAlertAction *action) {

        NSLog(@"aler1");
    } action2:@"3248" handler2:^(UIAlertAction *action) {
        NSLog(@"aler2");

    }];

//    [aler.view addSubview:datePicker];
    [aler alertShow:^{
        NSLog(@"allllshow");
    }];
    
//    [ZBAlertController alert:@"111" message:@"fdf" show:self];
//    kAlert(@"1", nil);
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:@"dfasdf "preferredStyle:UIAlertControllerStyleActionSheet];
//    [alert.view addSubview:datePicker];
//    [self presentViewController:alert animated:YES completion:nil];
    

   
    
  
}


-(void)alertViewLeftBtnAction{
    [self.modalView hide];
}
-(void)alertViewRightBtnAction{
    [self.modalView hideAnimated:YES withCompletionBlock:^{
        NSLog(@"jfspa_-fasdn");
    }];
}


#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idididididiid = @"idijhofsdhfoadoa";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idididididiid];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idididididiid];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"dshfaosd_%ld",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
