//
//  ZBStepper.m
//  BSApp
//
//  Created by 李振彪 on 2017/7/19.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "ZBStepper.h"
#import <Masonry.h>


@interface ZBStepper ()<UITextFieldDelegate>
{
    
}
/** 是否通过点击按钮来进行加减数据 */
@property (nonatomic, assign) BOOL isClickBtn;

/** 填充小数位 */
//@property (nonatomic, assign) BOOL isFillDecimal;

@end

@implementation ZBStepper

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self _createView:frame];
    }
    return self;
}


- (void)_createView:(CGRect)frame{
    CGFloat leftGap = 1;
    CGFloat btnWidth = frame.size.height-leftGap*2;
    CGFloat textFWidth = frame.size.width - btnWidth * 2 - leftGap * 3;
    
    self.leftBtn = [UIButton button:CGRectZero title:@"" tColor:kBlackColor target:self action:@selector(btnAction:)];
    self.leftBtn.backgroundColor = RGB(0, 146, 255);
    [self.leftBtn image:@"icon_jian"];
    self.leftBtn.tag = 1;
    [self addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftGap);
        make.top.equalTo(self.mas_top).offset(leftGap);
        make.width.mas_equalTo(btnWidth);
        make.bottom.equalTo(self.mas_bottom).offset(-leftGap);
    }];
    
    self.textField = [[UITextField alloc]init];
    self.textField.backgroundColor = kClearColor;
    self.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.textField.delegate = self;
    self.textField.font = [UIFont systemFontOfSize:14];
    [self.textField addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged|UIControlEventValueChanged];
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right).offset(leftGap/2);
        make.top.equalTo(self.mas_top).offset(leftGap);
        make.width.mas_equalTo(textFWidth);
        make.bottom.equalTo(self.mas_bottom).offset(-leftGap);
    }];
    
    
    self.rightBtn = [UIButton button:CGRectZero title:@"" tColor:kBlackColor target:self action:@selector(btnAction:)];
    self.rightBtn.tag = 2;
    self.rightBtn.backgroundColor = RGB(0, 146, 255);
    [self.rightBtn image:@"icon_jia"];
    [self addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField.mas_right).offset(leftGap/2);
        make.top.equalTo(self.mas_top).offset(leftGap);
        make.width.mas_equalTo(btnWidth);
        make.bottom.equalTo(self.mas_bottom).offset(-leftGap);
    }];

    self.backgroundColor = kClearColor;
 
    
}

- (void)btnAction:(UIButton *)sender{
    
    self.isClickBtn = YES;
    if (self.textField.text.length == 0) {
        NSLog(@"stepper未设置textField的值");
        return;
    }else if (!self.increment) {
        NSLog(@"stepper未设置步进值increment");
        return;
    }else{
        
    }
    
    if(sender.tag == 1){//减
        double num = [self.textField.text doubleValue];
        double number = num - self.increment;
        [self writeText:self.textField value:number];
    }else{//加
        double num = [self.textField.text doubleValue];
        double number = num + self.increment;
        [self writeText:self.textField value:number];
    }
    [self textFieldValueChange:self.textField];
}

-(void)textFieldValueChange:(UITextField *)textField{
    

    //判断是否在输入的时候检测数值, 或者通过点击按钮改变数值
    if (self.isCheckWhenValueChanged == YES || self.isClickBtn == YES) {
        //判断当前是否是点击了键盘空格或者键盘删除键
        if (![self.string isEqualToString:@""]) {
            //判断当前值是否为@""
            if(![textField.text isEqualToString:@""]){
                //判断当前值时候小于最小值
                if ([textField.text doubleValue] < self.minValue) {
                    //判断是否最小值是否已经初始化
                    if (self.minValue) {
                        //是否使用极限最小值
                        if(self.isUseLimitValue == YES){
                            //是否初始化了极限值
                            if(self.minLimitValue){
                                [self writeText:textField value:self.minLimitValue];
                            }else{
                                NSLog(@"stepper没有设置minLimitValue，默认将minValue设置为当前值");
                                [self writeText:textField value:self.minValue];
                            }
                        }else{
                            NSLog(@"stepper未开启使用最小值minValue");
                        }                        
                    }else{
                        NSLog(@"stepper未设置最小值minValue，或者设置无效，请查看属性备注");
                    }
                    
                }
                else if ([textField.text doubleValue] > self.maxValue){
                    
                    if(self.maxValue){
                        if(self.isUseLimitValue == YES){
                            if(self.maxLimitValue){
                                [self writeText:textField value:self.maxLimitValue];
                            }else{
                                NSLog(@"stepper没有设置maxLimitValue，默认将maxValue设置为当前值");
                                [self writeText:textField value:self.maxValue];
                            }
                        }else{
                            NSLog(@"stepper未开启使用最大值maxValue");
                            
                        }
                    }else{
                        NSLog(@"stepper未设置最大maxValue，或者设置无效，请查看属性备注");
                    }
                }else{
                    
                }
            }
        }
    }
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //当删除完所有的字符之后，隐藏键盘（取消输入）时，设置默认值
    
    NSString *str = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    double num = [str doubleValue];
    if(str.length == 0){
        num = 0;
    }
    //如果当前值小于默认值，且最小值等于默认值
    if(num < self.value && self.value == self.minValue){
        textField.text = [NSString stringWithFormat:@"%.3f",self.value];
    }
    
    if(num > self.value && self.value == self.maxValue){
        textField.text = [NSString stringWithFormat:@"%.3f",self.value];

    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
 
    self.isClickBtn = NO;
    return YES;
}

- (void)writeText:(UITextField *)textField value:(double)value{

    if(!self.decimalLength){
        
        NSLog(@"stepper未设置小数位长度，将默认设置长度为0");
        //小数点长度为0，
        self.decimalLength = 0;
    }
    
    
    switch (self.decimalLength) {
        case 0:
            textField.text = [NSString stringWithFormat:@"%.0f",value];
            break;
        case 1:
            textField.text = [NSString stringWithFormat:@"%.1f",value];
            break;
        case 2:
            textField.text = [NSString stringWithFormat:@"%.2f",value];
            break;
        case 3:
            textField.text = [NSString stringWithFormat:@"%.3f",value];
            break;
        case 4:
            textField.text = [NSString stringWithFormat:@"%.4f",value];
            break;
        case 5:
            textField.text = [NSString stringWithFormat:@"%.5f",value];
            break;
        case 6:
            textField.text = [NSString stringWithFormat:@"%.6f",value];
            break;
        default:
            textField.text = [NSString stringWithFormat:@"%.0f",value];
            break;
    }
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //string的值为@""时，表示输入的是删除键；@" "表示空格键。
    self.string = string;
//    NSLog(@"当前输入——%@。",string);
    
    //第一位不能是小数点。
    if((textField.text.length==0)&([string isEqualToString:@"."])){
        return NO;
    }
    //小数长度为0的时候，且输入的是小数点，返回，不允许输入小数点
    if(self.decimalLength == 0 && [string isEqualToString:@"."]){
        return NO;
    }
    //判断是否是非法字符，（数字 & 小数点 & 删除键，这三个是正确字符）
    if ((![NSString isPureInt:string])&(![string isEqualToString:@"."])&(![string isEqualToString:@""])) {
        return NO;
    }
    
    //如果首位字符是@"0",但之后输入的不是小数点@"."，且按下的额不是删除键@""
    if (([textField.text isEqualToString:@"0"])&(![string isEqualToString:@"."]&(![string isEqualToString:@""]))) {
        return NO;
    }
    
    
    //判断是否有两个点--正常数字
    NSArray * pointArray = [textField.text componentsSeparatedByString:@"."];
    if (pointArray.count==2) {//小数点长度
        //在有一个小数点的情况小，不允许继续输入小数点
        if ([string isEqualToString:@"."]) {
            return NO;
        }
        
        NSString * lastString = [pointArray lastObject];
        //如果小数点后面的字符长度超过指定长度，且当前点击的按钮不是删除键
        if ((lastString.length>self.decimalLength-1)&(![string isEqualToString:@""])) {
            
            
            NSRange rangeP = [textField.text rangeOfString:@"."];
            //NSLog(@"rangeP_%ld,%@,%@,loc_%ld,len_%ld",rangeP.location,string,textField.text,range.location,range.length);
            
            //再如果当前输入的字符所在location在小数点之后，则不允许输入；
            if (range.location > rangeP.location) {
                return NO;

            }else{//在小数点之前，允许输入
                return YES;

            }
        }
    }
    return YES;
}

- (void)showLayer{
//    [self.leftBtn _layerWidth:0.5 color:kGroupTableViewBackgroundColor masksToBounds:NO cornerRadius:0];
//    [self.rightBtn _layerWidth:0.5 color:kGroupTableViewBackgroundColor masksToBounds:NO cornerRadius:0];
    self.textField.layer.borderWidth = 0.5;
    self.textField.layer.borderColor = kGroupTableViewBackgroundColor.CGColor;
    self.layer.borderColor = kGroupTableViewBackgroundColor.CGColor;
    self.layer.borderWidth = 0.5;
    
}





-(void)setValue:(double)value{
    _value = value;
    [self writeText:self.textField value:value];
}


-(void)setMinValue:(double)minValue{
    _minValue = minValue;
}
-(void)setMaxValue:(double)maxValue{
    _maxValue = maxValue;
}
-(void)setIsCheckWhenValueChanged:(BOOL)isCheckWhenValueChanged{
    _isCheckWhenValueChanged = isCheckWhenValueChanged;
}
-(void)setIsUseLimitValue:(BOOL)isUseLimitValue{
    _isUseLimitValue = isUseLimitValue;
}
-(void)setMinLimitValue:(double)minLimitValue{
    _minLimitValue = minLimitValue;
}
-(void)setMaxLimitValue:(double)maxLimitValue{
    _maxLimitValue = maxLimitValue;
}

-(void)setIncrement:(double)increment{
    _increment = increment;
}

-(void)setAutorepeat:(BOOL)autorepeat{
    _autorepeat = autorepeat;
}


-(void)setDecimalLength:(NSInteger)decimalLength{
    _decimalLength = decimalLength;
}
-(void)setString:(NSString *)string{
    _string = string;
}
@end
