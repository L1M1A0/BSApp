//
//  DefaultKeys.h
//  CloudShop
//
//  Created by Forr on 15/11/12.
//  Copyright © 2015年 XY. All rights reserved.
//


//文件名称
#define USER_FILE        @"userModel.md"
//对用户模型归档的key
#define USER_FILE_KEY    @"USER_FILE_KEY"
#define USER_DIC_KEY    @"USER_DIC_KEY"



/** 最后一次登录的用户的账号 */
#define kDefaultLastLoginUserEmpCode @"kDefaultLastLoginUserEmpCode"
/** 最后一次登录时的app版本，下载新版本后，初次打开会需要重新登录 */
#define kDefaultLastLoginVersion @"kDefaultLastLoginVersion"

#pragma mark - HUD 默认提示文字
//hud菊花的默认显示文字
#define kHudMessage_loadData    @"正在加载数据..."
#define kHudMessage_loadSuccess @"数据加载完成！"
#define kHudMessage_loadFailure @"数据加载失败！"
#define kHudMessage_noMoreData  @"没有更多数据了！"

#define kHudMessage_deleteData    @"正在删除数据..."
#define kHudMessage_deleteSuccess @"数据删除成功！"
#define kHudMessage_deleteFailure @"数据删除失败！"

#define kHudMessage_upLoadData @"正在提交数据..."
#define kHudMessage_modifyData @"正在修改数据..."

#define kHudMessage_saveData    @"正在保存数据..."
#define kHudMessage_saveSuccess @"数据保存成功！"
#define kHudMessage_saveFailure @"数据保存失败！"

//从返回的数据中，判断当前的数据类型
#define kUnknowDataType  @"注意，未知数据类型"


#define kNavigationBarTintColor RGB(45, 102, 209)
#define kButtonDefaultColor     RGB(0, 183, 215)
#define kButtonSystemColor      RGB(0, 120, 255)

#define kFontDefaultSize 14
#define kFontDefaultFont [UIFont systemFontOfSize:kFontDefaultSize]



