//ZBCategory.m
//  Marketing
//
//  Created by lizb on 15/12/25.
//  Copyright © 2015年 forr. All rights reserved.
//

#import "UILabel+ZBCategory.h"
#import "UIPasteboard+ZBPasteboard.h"


@implementation UILabel (ZBCategory)


#pragma mark - 公共

+ (UILabel *)label:(CGRect)frame text:(NSString *)text tColor:(UIColor *)tColor bColor:(UIColor *)bColor{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = tColor;
    label.backgroundColor = bColor;
    return label;
}

+ (UILabel *)label:(CGRect)frame text:(NSString *)text size:(CGFloat)size view:(UIView *)view{
    UILabel *lab = [self label:frame text:text tColor:kBlackColor bColor:kWhiteColor];
    lab.font = [UIFont systemFontOfSize:size];
    [view addSubview:lab];
    return lab;
}


#pragma mark - 扩展方法

#pragma mark 复制文字到剪贴板
- (void)copyTextToPasteboardWhenLongTouch:(CFTimeInterval)duration{
    [self longPressGestureRecognizerTaget:self action:@selector(longPressAction:) duration:duration];
}

-(void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [UIPasteboard copyString:self.text];
    }
}




@end
