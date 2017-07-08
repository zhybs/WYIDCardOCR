//
//  WYScanResultModel.h
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WYScanResultModel : NSObject

/** 身份证信息 */
@property (nonatomic, assign)  int type;          //1:正面  2:反面
@property (nonatomic, copy)    NSString *code;    //身份证号
@property (nonatomic, copy)    NSString *name;    //姓名
@property (nonatomic, copy)    NSString *gender;  //性别
@property (nonatomic, copy)    NSString *nation;  //民族
@property (nonatomic, copy)    NSString *address; //地址
@property (nonatomic, copy)    NSString *issue;   //签发机关
@property (nonatomic, copy)    NSString *valid;   //有效期
@property (nonatomic, strong)  UIImage *idImage;   //正反面照片

/** 银行卡信息 */
@property (nonatomic, copy)   NSString *bankNumber; //银行卡卡号
@property (nonatomic, copy)   NSString *bankName;   //银行卡名称
@property (nonatomic, strong) UIImage *bankImage;  //银行卡照片


/** 身份证字符串 */
- (NSString *)toString;

/** 是否为身份证 */
- (BOOL)isOK;


@end
