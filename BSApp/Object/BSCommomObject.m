//
//  BSCommomObject.m
//  BSApp
//
//  Created by 李振彪 on 2017/8/18.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import "BSCommomObject.h"



@implementation BSCommomObject

+(UIButton *)cycleButton:(CGRect)frame image:(NSString *)image target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton button:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width) title:nil tColor:[UIColor clearColor] bColor:RGBAlpha(255, 255, 255, 0.4) imageName:@""];
    [btn setImage:[UIImage imageNamed:image] forState:0];
    [btn tag:0 target:target action:action];
    [btn layerWidth:0 color:kClearColor masksToBounds:YES cornerRadius:frame.size.width/2];
    return btn;
}

+(UILabel *)lab:(NSString *)text size:(CGFloat)size view:(UIView *)view{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = text;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [UIFont systemFontOfSize:size];
    [view addSubview:lab];
    return lab;
}


/**
 返回格式 如 "¥ %.2f 元/吨  ¥%.2f "

 @param str1 ¥ %.2f 元/吨 中间的金额大写
 @param size str1中的特殊字符的大小
 @param str2 ¥%.2f 字体相对str1更小，中间有删除线
 @return <#return value description#>
 */
+ (NSMutableAttributedString *)atr:(double)str1 color1:(UIColor*)color1 str2:(double)str2 color2:(UIColor *)color2 size:(CGFloat)size decimalLength:(NSInteger)decimalLength{
   
    NSString *stra = @"";
    NSString *strb = @"";

    
    switch (decimalLength) {
        case 0:
            stra = [NSString stringWithFormat:@"¥%.0f /吨 ",str1];
            strb = [NSString stringWithFormat:@" ¥%.0f",str2];
            break;
        case 1:
            stra = [NSString stringWithFormat:@"¥%.1f /吨 ",str1];
            strb = [NSString stringWithFormat:@" ¥%.1f",str2];
            break;
        case 2:
            stra = [NSString stringWithFormat:@"¥%.2f /吨 ",str1];
            strb = [NSString stringWithFormat:@" ¥%.3f",str2];
            break;
        case 3:
            stra = [NSString stringWithFormat:@"¥%.3f /吨 ",str1];
            strb = [NSString stringWithFormat:@" ¥%.3f",str2];
            break;
        default:
            stra = [NSString stringWithFormat:@"¥%.0f /吨 ",str1];
            strb = [NSString stringWithFormat:@" ¥%.0f",str2];
            break;
    }

    
    
    NSMutableAttributedString *atr1 = [ZBAttributedString differentSizeStr:stra size:size sizeRange:NSMakeRange(1, stra.length-5) color:color1];
    
    NSMutableAttributedString *atr2 = [ZBAttributedString deleteLineStr:strb color:color2 lineColor:color2];
    
    [atr1 appendAttributedString:atr2];
    
    return atr1;
    
    
}

+(void)openQQ:(NSString *)str{
    if(str.length == 0){
        [BSProgressHudObject _initHUDWithStr:@"QQ号码不存在！"  view:[UIApplication sharedApplication].keyWindow hideAfter:1.0];
    }else{
        NSString *url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",str];
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:url]];
    }
    

}
+(void)openPhone:(NSString*)str{
    if(str.length == 0){
        [BSProgressHudObject _initHUDWithStr:@"电话号码不存在！"  view:[UIApplication sharedApplication].keyWindow hideAfter:1.0];
    }else{
        NSString *url = [NSString stringWithFormat:@"tel://%@",str];
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:url]];
    }
}
+(void)copyStrToPasteboard:(NSString *)str{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = str;
    NSString *st = [NSString stringWithFormat:@"复制完成：%@",pasteboard.string];
    [BSProgressHudObject _initHUDWithStr:st view:[UIApplication sharedApplication].keyWindow hideAfter:0.5];
}


+(void)loadHeadImage:(UIImageView *)imageView data:(void (^)(NSData *))block{
    BSUserModel * userModel = [BSLoginManager getCurrentUserInfo];
    
    [self loadImage:userModel.headImg imageView:imageView placeholderImage:@"icon_user_header" data:^(NSData *imageData) {
        block(imageData);
    }];
    
}

+(void)loadImage:(NSString *)imgId imageView:(UIImageView *)imageView placeholderImage:(NSString *)placeholderImage data:(void (^)(NSData *))block{

    __block NSData *data = [NSData data];
    if (imgId.length>0) {
        NSString * url = [NSString stringWithFormat:@"%@/%@",kBaseFile(@"loadImage"),imgId];
        NSURL * u = [NSURL URLWithString:url];
        [imageView sd_setImageWithURL:u placeholderImage:[UIImage imageNamed:placeholderImage] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                data = UIImageJPEGRepresentation([UIImage imageNamed:placeholderImage], 0.1);
                NSLog(@"下载图片错误——%@",error);
                block(data);

            }else{
                data = UIImageJPEGRepresentation(image, 0.1);
                block(data);
            }
        }];
    }else{
        imageView.image = [UIImage imageNamed:placeholderImage];
        data = UIImageJPEGRepresentation([UIImage imageNamed:placeholderImage], 0.1);
        block(data);

    }
}



+(NSString *)result_rows:(ZBHttpResult *)result{
    return [NSString stringWithFormat:@"%@",result.object[@"data"][@"result_rows"]];
}


@end
