//
//  WebVC.h
//  BROnlineLearning
//
//  Created by forr on 14/12/10.
//  Copyright (c) 2014年 Bori Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebVC : UIViewController
@property (nonatomic, retain) UIWebView *scanResultWebView;
/** 地址 */
@property (nonatomic, retain) NSString *urlStr;
/** 显示进度，默认为NO显示, YES不显示 */
@property (nonatomic, assign) BOOL hideProgress;

/** 数据来源，
 默认为NO,数据通过网络请求获得；
 手动YES,数据来自本地沙盒；
 */
@property (nonatomic, assign) BOOL isLocalFile;



@end
