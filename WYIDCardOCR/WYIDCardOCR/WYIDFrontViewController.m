//
//  WYIDFrontViewController.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/7.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYIDFrontViewController.h"

@interface WYIDFrontViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *birthLabel;

@property (weak, nonatomic) IBOutlet UILabel *genderLabel;

@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;

@property (weak, nonatomic) IBOutlet UILabel *adressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *idImage;

@end

@implementation WYIDFrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.nameLabel.text = self.resultModel.name;
    self.numberLabel.text = self.resultModel.code;
    self.birthLabel.text = [self judgeBirthDayWith:self.numberLabel.text];
    self.genderLabel.text = self.resultModel.gender;
    self.nationalityLabel.text = self.resultModel.nation;
    self.adressLabel.text = self.resultModel.address;
    self.idImage.image = self.resultModel.idImage;
    
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


#pragma mark - 判断生日
- (NSString *)judgeBirthDayWith:(NSString *)idNumber {
    NSInteger year = [[idNumber substringWithRange:NSMakeRange(6, 4)] integerValue];
    NSInteger month = [[idNumber substringWithRange:NSMakeRange(10, 2)] integerValue];
    NSInteger day = [[idNumber substringWithRange:NSMakeRange(12, 2)] integerValue];
    return [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day];
}



@end
