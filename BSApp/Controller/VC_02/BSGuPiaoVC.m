//
//  BSGuPiaoVC.m
//  BSApp
//
//  Created by lizb on 2017/12/18.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import "BSGuPiaoVC.h"
#import "BSListCell.h"
#import "ZBStock.h"

@interface BSGuPiaoVC ()<UITextFieldDelegate>{
    NSMutableArray *cells;
    UITextView *textView;
    ZBStock *object;
    UISegmentedControl *seg;
}

@end

@implementation BSGuPiaoVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    object = [[ZBStock alloc]init];
    cells  = [NSMutableArray array];
    NSInteger tg = 0;
    CGFloat gap = 10;
    CGFloat hei = 40;
    NSArray *titles = @[@[@"已购股价：",@"已持股数："],@[@"变仓股价：",@"变仓股数："]];
    for (int i = 0; i < titles.count; i++) {
        for (int j = 0; j < 2; j++) {
            
            CGFloat wid =  (kScreenWidth-gap*3)/2;
            BSListCell *cell = [[BSListCell alloc]initWithFrame:CGRectMake(gap+(gap+wid)*j, kNavigationBarHeight(self)+10+(gap+hei)*i,wid, hei) title:titles[i][j] placeholder:@"0" leftViewWidth:75];
            cell.inputTF.tag = tg;
            cell.fontSize = 13;
            cell.inputTF.delegate = self;
            cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
            [cell.inputTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [self.view addSubview:cell];
            [cells addObject:cell];
            tg = tg+1;
        }
    }
    seg = [self segment:CGRectGetMaxY([[cells lastObject]frame])+10 items:@[@"持仓总额",@"变仓总额",@"买后股价",@"卖后股价"]];



    textView = [[UITextView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(seg.frame)+10, kScreenWidth-10*2, 100)];
    [self.view addSubview:textView];
    
}
-(UISegmentedControl *)segment:(CGFloat)y items:(NSArray *)titles{
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:titles];
    segment.frame = CGRectMake(10, y, kScreenWidth-10*2, 30);
//    [seg setTitle:@"总额" forSegmentAtIndex:0];
//    [seg setTitle:@"买入" forSegmentAtIndex:1];
//    [seg setTitle:@"卖出" forSegmentAtIndex:2];
//    [seg setTitle:@"卖出" forSegmentAtIndex:3];
    
    //设置普通状态下(未选中)状态下的文字颜色和字体
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    //设置选中状态下的文字颜色和字体
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateSelected];
    [segment addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    segment.tintColor = kYellowColor;
    segment.selectedSegmentIndex = 0;

    [self.view addSubview:segment];
    return segment;
}

-(void)textFieldDidChange:(UITextField *)textField{
    NSLog(@"tag_%ld,%@",textField.tag,textField.text);
//    [self updateText];
    [self updateData];
}
-(void)segAction:(UISegmentedControl *)seg{
    NSLog(@"seg.index_%ld",seg.selectedSegmentIndex);

    [self updateText];
}

-(void)updateData{
    NSMutableArray *texts = [self texts];
    NSString *countStr = [NSString stringWithFormat:@"持仓总金额：%f",[object amountWithPrice:[texts[0] floatValue] total:[texts[1] floatValue]]];
    NSString *priceAfterBuy  = [NSString stringWithFormat:@"买入后股价：%f",[object priceAfterBuy:[texts[2] floatValue] buyTotal:[texts[3] floatValue] price:[texts[0] floatValue] total:[texts[1] floatValue]]];
    NSString *priceAfterSell = [NSString stringWithFormat:@"卖出后股价：%f",[object priceAfterSell:[texts[2] floatValue] sellTotal:[texts[3] floatValue] price:[texts[0] floatValue] total:[texts[1] floatValue]]];
    NSString *amountAfterBuy = [NSString stringWithFormat:@"买入后总额：%f",[object amountAfterBuy:[texts[2] floatValue] buyTotal:[texts[3] floatValue] price:[texts[0] floatValue] total:[texts[1] floatValue]]];
    NSString *amountAfterSell = [NSString stringWithFormat:@"卖出后总额：%f",[object amountAfterSell:[texts[2] floatValue] sellTotal:[texts[3] floatValue] price:[texts[0] floatValue] total:[texts[1] floatValue]]];
    
    
    textView.text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n",countStr,priceAfterBuy,priceAfterSell,amountAfterBuy,amountAfterSell];
    
}

-(void)updateText{
    NSMutableArray *texts = [self texts];

    switch (seg.selectedSegmentIndex) {
        case 0: {
            textView.text = [NSString stringWithFormat:@"%f",[object amountWithPrice:[texts[0] floatValue] total:[texts[1] floatValue]]] ;
            
        } break;
        case 1: {
            
            textView.text = [NSString stringWithFormat:@"%f",[object priceAfterBuy:[texts[2] floatValue] buyTotal:[texts[3] floatValue] price:[texts[0] floatValue] total:[texts[1] floatValue]]];
        } break;
        case 2: {
            textView.text = [NSString stringWithFormat:@"%f",[object priceAfterSell:[texts[2] floatValue] sellTotal:[texts[3] floatValue] price:[texts[0] floatValue] total:[texts[1] floatValue]]];
        } break;
        default:
            break;
    }
}

- (NSMutableArray *)texts{
    NSMutableArray *tes = [NSMutableArray array];
    for (int i = 0; i < cells.count; i++) {
        BSListCell *cell = cells[i];
        NSString *str = [cell.inputTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (str.length == 0) {
            str = @"0";
        }
        [tes addObject:str];
    }
    return tes;
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
