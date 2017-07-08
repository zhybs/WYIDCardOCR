//
//  WYScanBaseViewController.h
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYScanManager.h"

#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

@interface WYScanBaseViewController : UIViewController

@property (nonatomic, strong) WYScanManager *cameraManager;

@end
