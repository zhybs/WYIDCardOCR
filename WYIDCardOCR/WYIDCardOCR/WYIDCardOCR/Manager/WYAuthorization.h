//
//  WYAuthorization.h
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/7.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface WYAuthorization : NSObject

/** 获取权限单例 */
+ (instancetype)sharedInstance;


/** 获得相机权限回调 */
- (void)requestAuthorizationStatus:(void(^)())status;




@end
