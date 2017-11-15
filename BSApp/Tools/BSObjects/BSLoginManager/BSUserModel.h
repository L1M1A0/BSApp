//
//  BSUserModel.h
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import <Foundation/Foundation.h>

//警告: 此处模型将会根据实际项目的返回数据做定义,每开始一个新项目都要重新定义此处的模型

@interface BSUserModel : NSObject


/** <#Description#> */
@property (nonatomic, copy) NSString *address;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *admin;//1;
/** <#Description#> */
@property (nonatomic, copy) NSString *bankAccountNo;//6291837193713733131;
/** <#Description#> */
@property (nonatomic, copy) NSString *bankAddress;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *bankName;//"\U5e7f\U5dde\U94f6\U884c";
/** <#Description#> */
@property (nonatomic, copy) NSString *cityid;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *cityname;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *districtid;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *districtname;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *email;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *empCode;//E2017041300017;
/** <#Description#> */
@property (nonatomic, copy) NSString *empName;//"\U4e70\U5bb6";
/** <#Description#> */
@property (nonatomic, copy) NSString *empStatus;//10;
/** <#Description#> */
@property (nonatomic, copy) NSString *empType;//10;
/** <#Description#> */
@property (nonatomic, copy) NSString *entAddress;//"\U5e7f\U5dde\U5929\U6cb3";
/** <#Description#> */
@property (nonatomic, copy) NSString *entCertificae;//20;
/** <#Description#> */
@property (nonatomic, copy) NSString *entCode;//S00029;
/** <#Description#> */
@property (nonatomic, copy) NSString *entName;//"\U4e0a\U6d77\U95f5\U5b81\U5efa\U6750\U6709\U9650\U516c\U53f8";
/** <#Description#> */
@property (nonatomic, copy) NSString *entNature;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *entShortName;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *entStatus;//3;
/** <#Description#> */
@property (nonatomic, copy) NSString *groupCode;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *headImg;//9c14f3a0e77b421f808150f423ae6089;
/** <#Description#> */
@property (nonatomic, copy) NSString *id;//817a78a9f60a496c83df29d1dd16404b;
/** <#Description#> */
@property (nonatomic, copy) NSString *invoiceAddress;//"\U5e7f\U5dde\U5929\U6cb3";
/** <#Description#> */
@property (nonatomic, copy) NSString *invoicePhone;//020131311414;
/** <#Description#> */
@property (nonatomic, copy) NSString *invoiceRecipientMan;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *isCheckEmail;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *isCheckPhone;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *legalRepresentMan;//"\U80e1\U5b9d\U5fe0";
/** <#Description#> */
@property (nonatomic, copy) NSString *licenceNo;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *loginCode;//buyer;
/** <#Description#> */
@property (nonatomic, copy) NSString *loginId;//22bce2b9836e404da4d0d1a484e8dbf9;
/** <#Description#> */
@property (nonatomic, copy) NSString *lxrName;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *lxrPhone;//0207283133;
/** <#Description#> */
@property (nonatomic, copy) NSString *memberType;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *name;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *notes;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *passwordStrong;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *phone;//15920148107;
/** <#Description#> */
@property (nonatomic, copy) NSString *provinceid;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *provincename;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *ptId;//PT10000;
/** <#Description#> */
@property (nonatomic, copy) NSString *ptName;//"\U4f17\U7eba\U8054\U7535\U5546\U5e73\U53f0";
/** <#Description#> */
@property (nonatomic, copy) NSString *qq;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *recSrc;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *recipientAddr;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *recipientPhone;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *registerAddress;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *sex;//0;
/** <#Description#> */
@property (nonatomic, copy) NSString *socialCreditCode;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *systemFlag;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *taxNo;//981469104614621;
/** <#Description#> */
@property (nonatomic, copy) NSString *thereInOne;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *vaildFlag;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *vocationCode;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *vocationName;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *workFax;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *workTel;//"";
/** <#Description#> */
@property (nonatomic, copy) NSString *zipCode;//"";


/** <#Description#> */
//@property (nonatomic, strong) UIImage *headImage;
/** <#Description#> */
@property (nonatomic, strong) NSData *headImageData;

@end
