//
//  BasicNavigationController.h
//  Resume
//
//  Created by 汪年成 on 17/4/14.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BasicNavigationController;

// 定义协议方法
@protocol BasicNavigationControllerDelegate <NSObject>

/** 点击返回时触发的方法 */
- (BOOL)navationControllerShouldPopWhenSystemBackBtnselectted:(BasicNavigationController *)navigationController;

@end

@interface BasicNavigationController : UINavigationController

@end
