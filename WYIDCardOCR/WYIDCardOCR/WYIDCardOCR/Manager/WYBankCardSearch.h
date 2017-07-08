//
//  WYBankCardSearch.h
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYBankCardSearch : NSObject

/**
 *  查询是哪个银行
 *
 *  @param numbers 获取的numbers
 *  @param nCount  数组个数
 *
 *  @return 所属银行
 */
+ (NSString *)getBankNameByBin:(char *)numbers count:(int)nCount;

@end
