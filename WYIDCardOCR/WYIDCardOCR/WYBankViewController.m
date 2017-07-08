//
//  WYBankViewController.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/7.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYBankViewController.h"

@interface WYBankViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *icomimage;

@property (weak, nonatomic) IBOutlet UILabel *bank;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation WYBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.icomimage.image = self.resultModel.bankImage;
    self.bank.text = self.resultModel.bankNumber;
    self.name.text = self.resultModel.bankName;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/** 错误，重新拍 */
- (IBAction)wrong:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

/** 正确，下一步 */
- (IBAction)exactness:(id)sender {
     NSLog(@"经用户核对，身份证号码正确，那就进行下一步，比如经加密后，传递给后台");
}



@end
