//
//  ViewController.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "ViewController.h"
#import "WYIDScanViewController.h"


#import "WYBankViewController.h"
#import "WYIDFrontViewController.h"
#import "WYIDDownViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描身份证";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat Width = [UIScreen mainScreen].bounds.size.width;
    
    UIButton *bt1 = [[UIButton alloc] initWithFrame:CGRectMake((Width - 250)/2, 160, 250, 40)];
    [bt1 setBackgroundColor:[UIColor blackColor]];
    [bt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt1 setTitle:@"身份证正面" forState:UIControlStateNormal];
    [self.view addSubview:bt1];
    
    
    UIButton *bt2 = [[UIButton alloc] initWithFrame:CGRectMake((Width - 250)/2, 240, 250, 40)];
    [bt2 setBackgroundColor:[UIColor blackColor]];
    [bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt2 setTitle:@"身份证反面" forState:UIControlStateNormal];
    [self.view addSubview:bt2];
    
    
    UIButton *bt3 = [[UIButton alloc] initWithFrame:CGRectMake((Width - 250)/2, 320, 250, 40)];
    [bt3 setBackgroundColor:[UIColor blackColor]];
    [bt3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt3 setTitle:@"银行卡" forState:UIControlStateNormal];
    [self.view addSubview:bt3];
    
    
    [bt1 addTarget:self action:@selector(pushFront:) forControlEvents:UIControlEventTouchUpInside];
    [bt2 addTarget:self action:@selector(pushDown:) forControlEvents:UIControlEventTouchUpInside];
    [bt3 addTarget:self action:@selector(pushBank:) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)pushFront:(UIButton *)sender
{
    WYIDScanViewController *VC = [[WYIDScanViewController alloc] initWithCarInfo:CardIDFront];
    
    [VC scanDidFinishCarInfo:^(CardType status, WYScanResultModel *scanModel) {
        
        
        WYIDFrontViewController *VC = [WYIDFrontViewController new];
        VC.resultModel = scanModel;
        [self.navigationController pushViewController:VC animated:YES];
        
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


- (void)pushDown:(UIButton *)sender
{
    WYIDScanViewController *VC = [[WYIDScanViewController alloc] initWithCarInfo:CardIDDown];
    
    [VC scanDidFinishCarInfo:^(CardType status, WYScanResultModel *scanModel) {
        
        WYIDDownViewController *VC = [WYIDDownViewController new];
        VC.resultModel = scanModel;
        [self.navigationController pushViewController:VC animated:YES];
        
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


- (void)pushBank:(UIButton *)sender
{
    WYIDScanViewController *VC = [[WYIDScanViewController alloc] initWithCarInfo:CardIDBank];
    
    [VC scanDidFinishCarInfo:^(CardType status, WYScanResultModel *scanModel) {
        
        
        WYBankViewController *VC = [WYBankViewController new];
        VC.resultModel = scanModel;
        [self.navigationController pushViewController:VC animated:YES];
        
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
