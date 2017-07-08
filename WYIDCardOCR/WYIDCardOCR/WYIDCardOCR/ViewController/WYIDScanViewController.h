//
//  WYIDScanViewController.h
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYScanBaseViewController.h"

typedef NS_ENUM(NSUInteger, CardType)
{
    CardIDFront,  // 正面身份证
    CardIDDown,   // 反面身份证
    CardIDBank    // 银行卡
};

/** 扫描完成回调 */
typedef void(^ScanCarInfo)(CardType status, WYScanResultModel *scanModel);


@interface WYIDScanViewController : WYScanBaseViewController

/** 初始化 */
- (instancetype)initWithCarInfo:(CardType)carInfo;

/** 扫描完成回调 */
- (void)scanDidFinishCarInfo:(ScanCarInfo)carInfo;


@end
