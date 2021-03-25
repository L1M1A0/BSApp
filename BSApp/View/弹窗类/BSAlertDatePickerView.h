//
//  BSAlertDatePickerView.h
//  BSApp
//
//  Created by lizb on 2016/12/13.
//  Copyright © 2016年 lizb. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "BSAlertView.h"

@protocol BSAlertDatePickerViewDelegate;


@interface BSAlertDatePickerView : BSAlertView


/** <#Description#> */
@property (nonatomic, strong) UIDatePicker *datePicker;

/** <#Description#> */
@property (nonatomic, assign) id <BSAlertDatePickerViewDelegate> pickerDelegate;


/** 根据格式返回当前picker中选定的时间 */
-(NSString *)dateWithDateFormat:(NSString *)dateFormat;

@end

@protocol BSAlertDatePickerViewDelegate <NSObject>

- (void)alertView:(BSAlertDatePickerView *)alertView datePickerDidChangeValue:(UIDatePicker *)datePicker;


@end
