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
#import "ZBTableViewCell.h"
#import "BSUpdate.h"
#import "ZBHud.h"

@interface VC_01 ()<UITableViewDelegate,UITableViewDataSource,CustPhoneAlertViewDelegate>{
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KGModal *modalView;

@end

@implementation VC_01


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[[BSUpdate alloc]init]checkAppUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    ZBLinkLabel *link = (ZBLinkLabel *)[UILabel label:CGRectMake(100, 100, 50, 50) text:@"124" tColor:kRedColor bColor:kGreenColor];
//    ZBLinkLabel *link = [[ZBLinkLabel alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    
//    UIImageView *link = [[UIImageView alloc]initWithFrame:CGRectMake(100, 250, 100, 100)];
    [link shadowColor:kRedColor opacity:1.0 radius:50 offset:CGSizeMake(10.0f, 30.0f)];
//    link.text = @"fasf";
//    link.backgroundColor = kGreenColor;
//    [link setLink:@"http://www.baidu.com" linkType:ZBLableLinkURL];
    [link copyTextToPasteboardWhenLongTouch:1];
//    [link tapGestureRecognizerTarget:self action:@selector(labAction)];

//    [link imageUrl:@"http://img.zcool.cn/community/014bfd577a0da00000018c1b587a4a.png@900w_1l_2o_100sh.jpg" placeholderImage:@"" data:^(NSData *imageData) {
//
//    }];
    [self.view addSubview:link];
    

    UIButton *btn = [UIButton button:CGRectMake(200, 100, 80, 50) title:@"anniu" tColor:kWhiteColor bColor:kBlueColor];
    [btn shadowColor:kPurpleColor opacity:0.9 radius:10 offset:CGSizeMake(0, -3)];
    [btn layerWidth:3 color:kGreenColor masksToBounds:NO cornerRadius:25];
    [btn tag:0 target:self action:@selector(btnaction)];
    [self.view addSubview:btn];
    
    NSString *time = [ZBTime currentTimeWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"currentTimeWithDateFormat_%@",time);
    time = [ZBTimestamp currentTimeStampIs1000:YES];
    NSLog(@"currentTimeStampIs1000_%@",time);
    time = [ZBTimestamp timestamp:1510824318 format:@"yyyy-MM-dd HH:mm:ss" isX1000:NO];
    NSLog(@"timestamp_%@",time);
    NSLog(@"timestamp_%@",[ZBTimestamp splitCurrentTimeToArray]);
    
    UISearchBar *search = [UISearchBar searchBarFrame:CGRectMake(50, 200, 200, 50) placeholder:@"fasdgew" removeBarBackgroundView:YES];
    [self.view addSubview:search];

    UIView *tem = [UIView viewFrame:CGRectMake(CGRectGetMaxX(search.frame), 200, 50, 50) bgColor:kYellowColor superView:self.view];
    
    
}

-(void)labAction{
    ZBHud *hud = [[ZBHud alloc] initWithStr:@"hud1" view:self.view];
//    [hud hideWithStr:@"fasd" after:1.0];
    [hud hideWithArray:@[] dataSource:[NSMutableArray arrayWithArray:@[@"",@""]]  after:1.0];
    
}


-(void)btnaction{

//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.view addSubview:self.tableView];

    
//    ZBAlertController *aler = [ZBAlertController alert:@"bafd" messge:@"asdhaodhgo1" action1:@"asdf8asdf" handler1:^(UIAlertAction *action) {
//
//        NSLog(@"aler1");
//    } action2:@"3248" handler2:^(UIAlertAction *action) {
//        NSLog(@"aler2");
//
//    }];
//
//    [aler alertShow:^{
//        NSLog(@"allllshow");
//    }];
//
    
//    [ZBHud initWithStr:@"afshifh" hideAfter:1.0 view:self.view];
    [ZBHud initWithArray:@[@""] dataSource:[NSMutableArray arrayWithArray:@[@"",@""]] after:1.0 view:self.view];

   
    
  
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
    
    ZBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idididididiid];
    if(!cell){
        cell = [[ZBTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idididididiid];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"dshfaosd_%ld",indexPath.row];
//    cell.indexPath = 10+indexPath.row;
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZBTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    NSLog(@"cell.index_%ld",cell.indexPath.row);
    
    
    
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
