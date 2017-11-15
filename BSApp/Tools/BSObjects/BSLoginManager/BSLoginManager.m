//
//  BSLoginManager.m
//  BSApp
//
//  Created by 李振彪 on 16/8/16.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "BSLoginManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "FHFileManager.h"
#import "AppDelegate.h"

static BOOL isSavedataInDefault = YES;


@implementation BSLoginManager

/**
 *  获取当前用户模型
 *
 *  @return 用户模型
 */
+ (BSUserModel *)getCurrentUserInfo
{
  
    BSUserModel *model;
    if (isSavedataInDefault == YES) {
        NSDictionary *dic = [ZBUserDefault _defaultObjectForKey:USER_DIC_KEY];
        model = [BSUserModel mj_objectWithKeyValues:CONVERTER(dic)];
    }else{
        model = CONVERTER([FHFileManager unarchiverAtPath:kPATH_DOCUMENT fileName:USER_FILE encodeObjectKey:USER_FILE_KEY]);
        NSLog(@"filePath_%@",kPATH_DOCUMENT);
    }
    
    if (!model) {
        model = [BSUserModel new];
        model.empCode = @"";
        model.loginId = @"";
        model.ptId = kPtId;
    }
    if (model.empCode == nil) {
        model.empCode = @"";
    }
    if (model.loginId == nil) {
        model.loginId = @"";
    }
    return model;
}

/**
 *  退出清空本地用户信息
 */
+ (void)removeCurrentUserInfo
{
    
    if(isSavedataInDefault == YES){
        [ZBUserDefault _defaultObject:@{} key:USER_DIC_KEY];

    }else{
        [FHFileManager deleteFileAtPath:kPATH_DOCUMENT fileName:USER_FILE];
    }
  
    //注销远程通知(不接收推送) 
    AppDelegate *delegare = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegare.jPushObject cancelRemoteMessagePush];
    
}

/**
 *  当前用户是否存在
 *
 *  @return 是否存在
 */
+ (BOOL)isLoginOfCurrentUser
{
    BOOL exist = NO;
    BSUserModel *user = [self getCurrentUserInfo];
//    NSLog(@"__user_%@",user);
    if (user.empCode.length != 0 || ![user.empCode isEqualToString:@""])
    {
        exist = YES;
    }
    return exist;
}

- (BSUserModel *)currentUser{

 
    if(isSavedataInDefault == YES){
        NSDictionary *dic = [ZBUserDefault _defaultObjectForKey:USER_DIC_KEY];
        BSUserModel *user = [BSUserModel mj_objectWithKeyValues:CONVERTER(dic)];
        return user;

    }else{
       return [FHFileManager unarchiverAtPath:kPATH_DOCUMENT fileName:USER_FILE encodeObjectKey:USER_FILE_KEY];
    }

}

+ (void)saveUserDic:(id)model{
    if ([model isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)model;
        [ZBUserDefault _defaultObject:dic key:USER_DIC_KEY];
    }else if ([model isKindOfClass:[BSUserModel class]]){
        BSUserModel *user = (BSUserModel *)model;
        [FHFileManager archiverAtPath:kPATH_DOCUMENT fileName:USER_FILE object:user encodeObjectKey:USER_FILE_KEY];
        //读取
        //[FHFileManager unarchiverAtPath:kPATH_DOCUMENT fileName:USER_FILE encodeObjectKey:USER_INFO_KEY];
    }
    
}




/**
 将model保存成dic

 @param model userModel
 */
+(void)modelToDicAndSaveWithDic:(BSUserModel *)model{
    
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [self mDic:mdic key:@"address" value:model.address];//"";
    [self mDic:mdic key:@"admin" value:model.admin];//1;
    [self mDic:mdic key:@"bankAccountNo" value:model.bankAccountNo];//6291837193713733131;
    [self mDic:mdic key:@"bankAddress" value:model.bankAddress];//"";
    [self mDic:mdic key:@"bankName" value:model.bankName];//"\U5e7f\U5dde\U94f6\U884c";
    [self mDic:mdic key:@"cityid" value:model.cityid];//"";
    [self mDic:mdic key:@"cityname" value:model.cityname];//"";
    [self mDic:mdic key:@"districtid" value:model.districtid];//"";
    [self mDic:mdic key:@"districtname" value:model.districtname];//"";
    [self mDic:mdic key:@"email" value:model.email];//"";
    [self mDic:mdic key:@"empCode" value:model.empCode];//E2017041300017;
    [self mDic:mdic key:@"empName" value:model.empName];//"\U4e70\U5bb6";
    [self mDic:mdic key:@"empStatus" value:model.empStatus];//10;
    [self mDic:mdic key:@"empType" value:model.empType];//10;
    [self mDic:mdic key:@"entAddress" value:model.entAddress];//"\U5e7f\U5dde\U5929\U6cb3";
    [self mDic:mdic key:@"entCertificae" value:model.entCertificae];//20;
    [self mDic:mdic key:@"entCode" value:model.entCode];//S00029;
    [self mDic:mdic key:@"entName" value:model.entName];//"\U4e0a\U6d77\U95f5\U5b81\U5efa\U6750\U6709\U9650\U516c\U53f8";
    [self mDic:mdic key:@"entNature" value:model.entNature];//"";
    [self mDic:mdic key:@"entShortName" value:model.entShortName];//"";
    [self mDic:mdic key:@"entStatus" value:model.entStatus];//3;
    [self mDic:mdic key:@"groupCode" value:model.groupCode];//"";
    [self mDic:mdic key:@"headImg" value:model.headImg];//9c14f3a0e77b421f808150f423ae6089;
    [self mDic:mdic key:@"id" value:model.id];//817a78a9f60a496c83df29d1dd16404b;
    [self mDic:mdic key:@"invoiceAddress" value:model.invoiceAddress];//"\U5e7f\U5dde\U5929\U6cb3";
    [self mDic:mdic key:@"invoicePhone" value:model.invoicePhone];//020131311414;
    [self mDic:mdic key:@"invoiceRecipientMan" value:model.invoiceRecipientMan];//"";
    [self mDic:mdic key:@"isCheckEmail" value:model.isCheckEmail];//"";
    [self mDic:mdic key:@"isCheckPhone" value:model.isCheckPhone];//"";
    [self mDic:mdic key:@"legalRepresentMan" value:model.legalRepresentMan];//"\U80e1\U5b9d\U5fe0";
    [self mDic:mdic key:@"licenceNo" value:model.licenceNo];//"";
    [self mDic:mdic key:@"loginCode" value:model.loginCode];//buyer;
    [self mDic:mdic key:@"loginId" value:model.loginId];//22bce2b9836e404da4d0d1a484e8dbf9;
    [self mDic:mdic key:@"lxrName" value:model.lxrName];//"";
    [self mDic:mdic key:@"lxrPhone" value:model.lxrPhone];//0207283133;
    [self mDic:mdic key:@"memberType" value:model.memberType];//"";
    [self mDic:mdic key:@"name" value:model.name];//"";
    [self mDic:mdic key:@"notes" value:model.notes];//"";
    [self mDic:mdic key:@"passwordStrong" value:model.passwordStrong];//"";
    [self mDic:mdic key:@"phone" value:model.phone];//15920148107;
    [self mDic:mdic key:@"provinceid" value:model.provinceid];//"";
    [self mDic:mdic key:@"provincename" value:model.provincename];//"";
    [self mDic:mdic key:@"ptId" value:model.ptId];//PT10000;
    [self mDic:mdic key:@"ptName" value:model.ptName];//"\U4f17\U7eba\U8054\U7535\U5546\U5e73\U53f0";
    [self mDic:mdic key:@"qq" value:model.qq];//"";
    [self mDic:mdic key:@"recSrc" value:model.recSrc];//"";
    [self mDic:mdic key:@"recipientAddr" value:model.recipientAddr];//"";
    [self mDic:mdic key:@"recipientPhone" value:model.recipientPhone];//"";
    [self mDic:mdic key:@"registerAddress" value:model.registerAddress];//"";
    [self mDic:mdic key:@"sex" value:model.sex];//0;
    [self mDic:mdic key:@"socialCreditCode" value:model.socialCreditCode];//"";
    [self mDic:mdic key:@"systemFlag" value:model.systemFlag];//"";
    [self mDic:mdic key:@"taxNo" value:model.taxNo];//981469104614621;
    [self mDic:mdic key:@"thereInOne" value:model.thereInOne];//"";
    [self mDic:mdic key:@"vaildFlag" value:model.vaildFlag];//"";
    [self mDic:mdic key:@"vocationCode" value:model.vocationCode];//"";
    [self mDic:mdic key:@"vocationName" value:model.vocationName];//"";
    [self mDic:mdic key:@"workFax" value:model.workFax];//"";
    [self mDic:mdic key:@"workTel" value:model.workTel];//"";
    [self mDic:mdic key:@"zipCode" value:model.zipCode];//"";
    //    [mdic addEntriesFromDictionary:@{@"headImage":model.headImage}];
    if (model.headImageData != nil) {
        [mdic addEntriesFromDictionary:@{@"headImageData":model.headImageData}];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:mdic];
    [BSLoginManager saveUserDic:dic];
    
    
}

+(NSMutableDictionary *)mDic:(NSMutableDictionary *)mdic key:(NSString *)key value:(NSString *)value{
    
    if (value == nil) {
        value = @"";
    }
    
    [mdic  addEntriesFromDictionary:@{key:value}];
    return mdic;
    
}



@end
