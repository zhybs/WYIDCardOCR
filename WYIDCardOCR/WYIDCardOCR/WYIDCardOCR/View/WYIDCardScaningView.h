//
//  WYIDCardScaningView.h
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ScaningCardType)
{
    ScaningCardIDWithFront,     // 身份证正面
    ScaningCardIDWithDown,      // 身份证反面
    ScaningCardIDWithBank       // 银行卡
};

@interface WYIDCardScaningView : UIView

@property (nonatomic,assign) CGRect facePathRect;


/** 扫描类型 */
- (void)scaningCardIDWithType:(ScaningCardType)type;



@end
