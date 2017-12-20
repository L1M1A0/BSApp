//
//  ZBLinkLabel.h
//  BSApp
//
//  Created by 李振彪 on 2017/8/8.
//  Copyright © 2017年 BaoThink. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 链接类型 */
typedef NS_ENUM(NSInteger, ZBLableLinkType) {
    ZBLableLinkPhone   = 1,    //拨打电话
    ZBLableLinkURL     = 2,    //打开网站
    ZBLableLinkSetting = 3,    //打开设置
    ZBLableLinkE_Mail  = 4,    //打开邮件
};

/**
 可用于点击的lable的时候，可以跳转到其他媒体地址，如拨打电话等。
 */
@interface ZBLinkLabel : UILabel

/** 链接地址 */
@property (nonatomic, copy) NSString *urlStr;

/** 链接类型 */
@property (nonatomic, assign) ZBLableLinkType linkType;

///** <#Description#> */
//@property (nonatomic, strong) UITapGestureRecognizer *tap;
//
///** <#Description#> */
//@property (nonatomic, strong) UILongPressGestureRecognizer *longTap;

/** <#Description#> */
@property (nonatomic, copy) NSString *alertTitle;
/** <#Description#> */
@property (nonatomic, copy) NSString *alertMessage;


- (void)urlStr:(NSString *)urlStr linkType:(ZBLableLinkType)linkType;

@end
