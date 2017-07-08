//
//  WYScanManagerInitialize.h
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//


#import "WYScanBaseManager.h"

@interface WYScanManagerInitialize : WYScanBaseManager

- (void)configIDScan;

- (BOOL)configOutPutAtQue:(dispatch_queue_t)queue;

- (BOOL)configInPutAtQue:(dispatch_queue_t)queue;

- (void)configConnection;


@end
