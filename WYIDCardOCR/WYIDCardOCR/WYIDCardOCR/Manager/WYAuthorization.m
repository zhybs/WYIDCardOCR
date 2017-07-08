//
//  WYAuthorization.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/7.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYAuthorization.h"

@interface WYAuthorization () <UIAlertViewDelegate>

@end

@implementation WYAuthorization

//  单例
+ (id)sharedInstance {
    static WYAuthorization *sharedInstance;
    static dispatch_once_t onceToken;   
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}



//  获取权限状态
- (void)requestAuthorizationStatus:(void(^)())status
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    
                    // 已授权
                    status();
                    
                } else {
                    
                    // 拒绝
                    [self alertViewWithTitle:@"相机未授权" message:@"请到系统的“设置-隐私-相机”中授权此应用使用您的相机" cancelTitle:@"取消" otherTitle:@"去设置"];
                }
            }];
            
        } else if (authStatus == AVAuthorizationStatusAuthorized) {
            
            // 已授权
            status();
            
        } else if (authStatus == AVAuthorizationStatusDenied) {
            
            // 拒绝
            [self alertViewWithTitle:@"相机未授权" message:@"请到系统的“设置-隐私-相机”中授权此应用使用您的相机" cancelTitle:@"取消" otherTitle:@"去设置"];
            
        } else if (authStatus == AVAuthorizationStatusRestricted) {
            
            // 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
            [self alertViewWithTitle:@"提示" message:@"您的设备没有相关权限！" cancelTitle:@"确定" otherTitle:nil];
            
        }
        
    } else {
        
        // 硬件等不支持,模拟器
        [self alertViewWithTitle:@"提示" message:@"请到真机测试！" cancelTitle:@"确定" otherTitle:nil];
        
    }
}



- (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
               cancelTitle:(NSString *)cancel
                otherTitle:(NSString *)other
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:cancel
                                          otherButtonTitles:other, nil];
    [alert show];
}



#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //  用户解决授权跳转设置
    if (buttonIndex == 1) {
        
        UIApplication *app = [UIApplication sharedApplication];
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([app canOpenURL:settingsURL]) {
            [app openURL:settingsURL];
        }
        
    }
}





@end
