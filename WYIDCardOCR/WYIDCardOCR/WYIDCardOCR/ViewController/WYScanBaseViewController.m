//
//  WYScanBaseViewController.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYScanBaseViewController.h"
#import "WYAuthorization.h"


@interface WYScanBaseViewController () <UIAlertViewDelegate>
@end

@interface WYScanBaseViewController ()

@end

@implementation WYScanBaseViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //  每次进入界面读取用户权限
    [[WYAuthorization sharedInstance] requestAuthorizationStatus:^{
        [self.cameraManager doSomethingWhenWillAppear];
    }];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.cameraManager respondsToSelector:@selector(doSomethingWhenWillDisappear)]) {
        [self.cameraManager doSomethingWhenWillDisappear];
    }
}



- (WYScanManager *)cameraManager {
    if (!_cameraManager) {
        _cameraManager = [[WYScanManager alloc] init];
    }
    return _cameraManager;
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
                    [self onceDenied];
                }
            }];
            
        } else if (authStatus == AVAuthorizationStatusAuthorized) {
            
            // 已授权
            status();
            
        } else if (authStatus == AVAuthorizationStatusDenied) {
            
            // 拒绝
            [self onceDenied];
            
        } else if (authStatus == AVAuthorizationStatusRestricted) {
            
            // 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
            [self onceRestricted];
        }
        
    } else {
        
        // 硬件等不支持,模拟器
        [self onceNotSupport];
        
    }
}


//  用户拒绝
- (void)onceDenied
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self alertViewWithTitle:@"相机未授权" message:@"请到系统的“设置-隐私-相机”中授权此应用使用您的相机" cancelTitle:@"取消" otherTitle:@"去设置"];
    });
}

//  家长控制，无权限
- (void)onceRestricted
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self alertViewWithTitle:@"提示" message:@"您的设备没有相关权限！" cancelTitle:@"确定" otherTitle:nil];
    });
}

//  设备不支持 模拟器
- (void)onceNotSupport
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self alertViewWithTitle:@"提示" message:@"您的设备不支持，请到真机测试！" cancelTitle:@"确定" otherTitle:nil];
    });
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
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






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
