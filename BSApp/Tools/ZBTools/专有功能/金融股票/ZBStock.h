//
//  ZBStock.h
//  BSApp
//
//  Created by 李振彪 on 2017/12/29.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 股票 */
@interface ZBStock : NSObject{
    
}
/** 已持仓的股价 */
@property (nonatomic, assign) CGFloat price;
/** 已持仓的总量 */
@property (nonatomic, assign) CGFloat total;
/** 已持仓总额 */
@property (nonatomic, assign) CGFloat amount;
/** 当前股价 */
@property (nonatomic, assign) CGFloat currentPrice;
/** 当前操作股数 */
@property (nonatomic, assign) CGFloat currentTotal;









/**
 计算总额
 
 @param price 成本价或单价
 @param total 持仓数量
 @return 持仓总额、购入成本总额、出售总额
 */
-(CGFloat)amountWithPrice:(CGFloat)price total:(NSInteger)total;

/**
 计算以当前价位出售全部当前股票之后的收益
 
 @param sellPrice 出售价格
 @param buyPrice 购入价格（单价）
 @param total 持仓量或出售数量
 @return <#return value description#>
 */
-(CGFloat)sellCount:(CGFloat)sellPrice buyPrice:(CGFloat)buyPrice total:(NSInteger)total;


/**
 减仓后的股价
 
 @param sellPrice 减仓股价
 @param sellTotal 减仓总量
 @param price     减仓前持仓股价
 @param total     减仓前持仓总量
 @return <#return value description#>
 */
-(CGFloat)priceAfterSell:(CGFloat)sellPrice sellTotal:(NSInteger)sellTotal price:(CGFloat)price total:(NSInteger)total;
/**
 减仓后的总额
 
 @param sellPrice 减仓股价
 @param sellTotal 减仓总量
 @param price     减仓前持仓股价
 @param total     减仓前持仓总量
 @return return value description
 */
-(CGFloat)amountAfterSell:(CGFloat)sellPrice sellTotal:(NSInteger)sellTotal price:(CGFloat)price total:(NSInteger)total;

/**
 补仓后的股价
 
 @param buyPrice 补仓股价
 @param buyTotal 补仓总量
 @param price    补仓前持仓股价
 @param total    补仓前持仓总量
 @return <#return value description#>
 */
-(CGFloat)priceAfterBuy:(CGFloat)buyPrice buyTotal:(NSInteger)buyTotal price:(CGFloat)price total:(NSInteger)total;

/**
 补仓后的总金额
 
 @param buyPrice 补仓股价
 @param buyTotal 补仓总量
 @param price    补仓前持仓股价
 @param total    补仓前持仓总量
 @return <#return value description#>
 */
-(CGFloat)amountAfterBuy:(CGFloat)buyPrice buyTotal:(NSInteger)buyTotal price:(CGFloat)price total:(NSInteger)total;
@end
