//
//  BSAlertDatePickerView.m
//  BSApp
//
//  Created by lizb on 2016/12/13.
//  Copyright © 2016年 lizb. All rights reserved.
//

#import "BSAlertDatePickerView.h"

@implementation BSAlertDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)addContentView{
    //    self.datePickerAlertView = [self _alertView:CGRectMake(0, 0, kScreenWidth, kScreenHeight) height:250];
    [self.leftBtn setTitle:@"取消" forState:0];
    [self.rightBtn setTitle:@"确定" forState:0];
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, self.contentViewRect.width, self.contentViewRect.height)];
    [self.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker addTarget:self action:@selector(datePickerValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.datePicker];

}


- (void)datePickerValueDidChange:(UIDatePicker *)datePicker{
    if ([self.pickerDelegate respondsToSelector:@selector(alertView:datePickerDidChangeValue:)]) {
        [self.pickerDelegate alertView:self datePickerDidChangeValue:datePicker];
    }
}

-(NSString *)dateWithDateFormat:(NSString *)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:self.datePicker.date];
}

@end
