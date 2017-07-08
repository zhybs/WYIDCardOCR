//
//  WYIDDownViewController.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/7.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYIDDownViewController.h"

@interface WYIDDownViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *idImage;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation WYIDDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.idImage.image = self.resultModel.idImage;
    self.address.text = self.resultModel.issue;
    self.date.text = self.resultModel.valid;
    
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
