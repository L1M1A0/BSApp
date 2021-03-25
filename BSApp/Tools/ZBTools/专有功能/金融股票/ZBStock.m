//
//  ZBStock.m
//  BSApp
//
//  Created by lizb on 2017/12/29.
//  Copyright © 2017年 lizb. All rights reserved.
//

#import "ZBStock.h"

@implementation ZBStock

/**
 计算总额
 
 @param price 成本价或单价
 @param total 持仓数量
 @return 持仓总额、购入成本总额、出售总额
 */
-(CGFloat)amountWithPrice:(CGFloat)price total:(NSInteger)total{
    //所有已购入成本总额 = 成本价 * 持仓量
    //11.523 * 14100 = 162474.3
    return price * total;
}


/**
 计算以当前价位出售全部当前股票之后的收益
 
 @param sellPrice 出售价格
 @param buyPrice 购入价格（单价）
 @param total 持仓量或出售数量
 @return <#return value description#>
 */
-(CGFloat)sellCount:(CGFloat)sellPrice buyPrice:(CGFloat)buyPrice total:(NSInteger)total{
    //当前亏损总额：现价 * 持仓量 - 所有已购入成本总额
    //8.960 * 14100 - 162474.3 = -36138.3  //注：同花顺中为：-36131.310，与结果相差6.99
    
    //当前卖出总额
    CGFloat sellAmount = [self amountWithPrice:sellPrice total:total];
    //当前持仓总额
    CGFloat allAmount = [self amountWithPrice:buyPrice total:total];
    CGFloat count = sellAmount - allAmount;
    return count;
}



/**
 减仓后的股价
 
 @param sellPrice 减仓股价
 @param sellTotal 减仓总量
 @param price     减仓前持仓股价
 @param total     减仓前持仓总量
 @return return value description
 */
-(CGFloat)priceAfterSell:(CGFloat)sellPrice sellTotal:(NSInteger)sellTotal price:(CGFloat)price total:(NSInteger)total {
    //减仓后单价：（减仓前的购入成本总额 - 减仓总额）/（减仓前的总持仓量 - 减仓量）
    //（162474.3 - 66500）/ (14100 - 7000) = 95974.3 / 7100 = 13.518
    
    //减仓后的持仓总额
    CGFloat currentAmount = [self amountAfterSell:sellPrice sellTotal:sellTotal price:price total:total];
    
    //减仓后的持仓量
    CGFloat currentTotal = total - sellTotal;
    
    //减仓后的股价
    CGFloat currentPrice = currentAmount / currentTotal;
    return currentPrice;
}
/**
 减仓后的总额
 
 @param sellPrice 减仓股价
 @param sellTotal 减仓总量
 @param price     减仓前持仓股价
 @param total     减仓前持仓总量
 @return return value description
 */
-(CGFloat)amountAfterSell:(CGFloat)sellPrice sellTotal:(NSInteger)sellTotal price:(CGFloat)price total:(NSInteger)total {
    //减仓后单价：（减仓前的购入成本总额 - 减仓总额）/（减仓前的总持仓量 - 减仓量）
    //（162474.3 - 66500）/ (14100 - 7000) = 95974.3 / 7100 = 13.518
    
    //减仓前的购入成本总额
    CGFloat allAmount  = [self amountWithPrice:price total:total];
    
    //减仓总额
    CGFloat sellAmount = [self amountWithPrice:sellPrice total:sellTotal];

    //减仓后的持仓总额
    CGFloat currentAmount = allAmount - sellAmount;
 
    return currentAmount;
}

/**
 补仓后的股价
 
 @param buyPrice 补仓股价
 @param buyTotal 补仓总量
 @param price    补仓前持仓股价
 @param total    补仓前持仓总量
 @return <#return value description#>
 */
-(CGFloat)priceAfterBuy:(CGFloat)buyPrice buyTotal:(NSInteger)buyTotal price:(CGFloat)price total:(NSInteger)total {
    //补仓后单价：（补仓前的购入成本总额 + 补仓总额）/（补仓前的总持仓量 - 补仓量）
    //（162474.3 + 66500）/ (14100 + 7000) = 95974.3 / 7100 = 13.518

    //补仓后的持仓总额
    CGFloat currentAmount = [self amountAfterBuy:buyPrice buyTotal:buyTotal price:price total:total];
    
    //补仓后的持仓量
    CGFloat currentTotal = total + buyTotal;
    
    //补仓后的股价
    CGFloat currentPrice = currentAmount / currentTotal;
    return currentPrice;
}

/**
 补仓后的总金额
 
 @param buyPrice 补仓股价
 @param buyTotal 补仓总量
 @param price    补仓前持仓股价
 @param total    补仓前持仓总量
 @return <#return value description#>
 */
-(CGFloat)amountAfterBuy:(CGFloat)buyPrice buyTotal:(NSInteger)buyTotal price:(CGFloat)price total:(NSInteger)total {
    //补仓前的购入成本总额
    CGFloat allAmount  = [self amountWithPrice:price total:total];
    
    //补仓总额
    CGFloat buyAmount = [self amountWithPrice:buyPrice total:buyTotal];
    
    //补仓后的持仓总额
    CGFloat currentAmount = allAmount + buyAmount;
    
    return currentAmount;
}
@end
