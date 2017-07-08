//
//  WYIDScanViewController.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYIDScanViewController.h"
#import "WYIDCardScaningView.h"

@interface WYIDScanViewController ()

@property (nonatomic, strong) WYIDCardScaningView *overlayView;

// 摄像头设备
@property (nonatomic,strong) AVCaptureDevice *device;

// 是否打开手电筒
@property (nonatomic,assign,getter = isTorchOn) BOOL torchOn;

/** 证件扫描类型 */
@property (nonatomic, assign) CardType cardInfo;


@end

@implementation WYIDScanViewController


/** 初始化方法 */
- (instancetype)initWithCarInfo:(CardType)carInfo
{
    self = [super init];
    if (self) {
        self.title = carInfo == CardIDBank ? @"扫描银行卡" : @"扫描身份证";
        self.cardInfo = carInfo;
        [self startOpenCameraInitializationWithType:carInfo];
    }
    return self;
}



/** 摄像头的初始化*/
- (void)startOpenCameraInitializationWithType:(CardType)cardType
{
    self.cameraManager.sessionPreset = AVCaptureSessionPresetHigh;
    
    //  身份证识别
    if (cardType == CardIDFront || cardType == CardIDDown) {
        
        if ([self.cameraManager configIDScanManager]) {
            UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
            [self.view insertSubview:view atIndex:0];
            AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.cameraManager.captureSession];
            preLayer.frame = [UIScreen mainScreen].bounds;
            
            preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [view.layer addSublayer:preLayer];
            
            
            //  加载扫描试图
            WYIDCardScaningView *overlayView = [[WYIDCardScaningView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            if (cardType == CardIDFront) {
                [overlayView scaningCardIDWithType:ScaningCardIDWithFront];
            }
            else if (cardType == CardIDDown)
            {
                [overlayView scaningCardIDWithType:ScaningCardIDWithDown];
            }
            
            [self.view addSubview:overlayView];
            [self.view bringSubviewToFront:overlayView];
            
        }
        
        else {
            NSLog(@"无法打开相机");
        }
        
        
        
    }
    
    
    //  银行卡识别
    else if (cardType == CardIDBank)
    {
        if ([self.cameraManager configBankScanManager]) {
            UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
            [self.view insertSubview:view atIndex:0];
            AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.cameraManager.captureSession];
            preLayer.frame = [UIScreen mainScreen].bounds;
            
            preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [view.layer addSublayer:preLayer];
            
            
            //  加载扫描试图
            WYIDCardScaningView *overlayView = [[WYIDCardScaningView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [overlayView scaningCardIDWithType:ScaningCardIDWithBank];
            [self.view addSubview:overlayView];
            [self.view bringSubviewToFront:overlayView];
            
            
        }
        else {
            
            NSLog(@"打开相机失败");
            
        }
        
        
    }
}

-(void)dealloc
{
    NSLog(@"%s dealloc",object_getClassName(self));
}

/** 扫描完成 */
- (void)scanDidFinishCarInfo:(ScanCarInfo)carInfo
{
    //  正面
    if (self.cardInfo == CardIDFront) {
        [self.cameraManager.idCardScanSuccess subscribeNext:^(id result)
         {
             WYScanResultModel *model = (WYScanResultModel *)result;
             if (!model.valid || !model.issue)
             {
                 
                 carInfo(CardIDFront, model);
                 
                 // 身份证信息识别完毕后，就将videoDataOutput的代理去掉，防止频繁调用AVCaptureVideoDataOutputSampleBufferDelegate方法而引起的“混乱”
//                 if (self.cameraManager.videoDataOutput.sampleBufferDelegate) {
//                     [self.cameraManager.videoDataOutput setSampleBufferDelegate:nil queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
//                 }
                 
                 
             }
             
         }];
    }
    
    
    //  反面
    else if (self.cardInfo == CardIDDown) {
        [self.cameraManager.idCardScanSuccess subscribeNext:^(id result)
         {
             WYScanResultModel *model = (WYScanResultModel *)result;
             if (model.valid || model.issue)
             {
                 
                 carInfo(CardIDDown, model);
                 
                 // 身份证信息识别完毕后，就将videoDataOutput的代理去掉，防止频繁调用AVCaptureVideoDataOutputSampleBufferDelegate方法而引起的“混乱”
//                 if (self.cameraManager.videoDataOutput.sampleBufferDelegate) {
//                     [self.cameraManager.videoDataOutput setSampleBufferDelegate:nil queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
//                 }
             }
             
         }];
    }
    
    
    //  银行卡
    else if (self.cardInfo == CardIDBank)
    {
        [self.cameraManager.bankScanSuccess subscribeNext:^(id result)
         {
             
             WYScanResultModel *model = (WYScanResultModel *)result;
             carInfo(CardIDBank, model);
             
             // 身份证信息识别完毕后，就将videoDataOutput的代理去掉，防止频繁调用AVCaptureVideoDataOutputSampleBufferDelegate方法而引起的“混乱”
//             if (self.cameraManager.videoDataOutput.sampleBufferDelegate) {
//                 [self.cameraManager.videoDataOutput setSampleBufferDelegate:nil queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
//             }
             
         }];
    }
    
    
    
    [self.cameraManager.scanError subscribeNext:^(id x) {
        // 扫描失败的提醒
    }];
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    
    //  开灯按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开灯" style:UIBarButtonItemStylePlain target:self action:@selector(openLights)];
    
    
}



/** 开关灯 */
- (void)openLights
{
    [self turnOnOrOffTorch];
}




#pragma mark - 打开／关闭手电筒
-(void)turnOnOrOffTorch
{
    self.torchOn = !self.isTorchOn;
    
    if ([self.device hasTorch]){ // 判断是否有闪光灯
        [self.device lockForConfiguration:nil];// 请求独占访问硬件设备
        
        if (self.isTorchOn) {
            self.navigationItem.rightBarButtonItem.title = @"关灯";
            [self.device setTorchMode:AVCaptureTorchModeOn];
        } else {
            self.navigationItem.rightBarButtonItem.title = @"开灯";
            [self.device setTorchMode:AVCaptureTorchModeOff];
        }
        [self.device unlockForConfiguration];// 请求解除独占访问硬件设备
    }
    else {
        //初始化AlertView
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"您的设备没有闪光设备，不能提供手电筒功能!"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}




#pragma mark - Lazy

- (AVCaptureDevice *)device {
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        if ([_device lockForConfiguration:&error]) {
            if ([_device isSmoothAutoFocusSupported]) {// 平滑对焦
                _device.smoothAutoFocusEnabled = YES;
            }
            
            if ([_device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {// 自动持续对焦
                _device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
            }
            
            if ([_device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure ]) {// 自动持续曝光
                _device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
            }
            
            if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {// 自动持续白平衡
                _device.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
            }
            
            [_device unlockForConfiguration];
        }
    }
    
    return _device;
}



@end
