//
//  BasicNavigationController.m
//  Resume
//
//  Created by 汪年成 on 17/4/14.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "BasicNavigationController.h"

@interface BasicNavigationController () <UINavigationBarDelegate>

@end

@implementation BasicNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundColor:[UIColor blackColor]];
    [self.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationBar setTranslucent:NO];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) {
        
//        自定义返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        [backBtn setFrame:CGRectMake(0, 0, 70, 25)];
        [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [backBtn addTarget:self action:@selector(returnBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        //当视图推送时隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)returnBtnClick
{
    // 取出导航控制器中栈 的 vc
    UIViewController *vc = self.topViewController;
    // 查看是否实现了我们定义的协议
    if ([vc conformsToProtocol:@protocol(BasicNavigationControllerDelegate)])
    {
        
        if ([vc respondsToSelector:@selector(navationControllerShouldPopWhenSystemBackBtnselectted:)]) {
            // 协议方法的返回值
            BOOL isProtocol = [(id<BasicNavigationControllerDelegate>)vc navationControllerShouldPopWhenSystemBackBtnselectted:self];
            
            if (isProtocol) { // vc返回的是yes, 则返回系统默认的实现
                [self popViewControllerAnimated:YES];
            }
            else { // vc返回no, 说明暂时不想pop
                
            }
            
        }
        
        else {
            //  未实现协议方法 默认pop
            [self popViewControllerAnimated:YES];
        }
        
        
        
    }else{ // 没有, 自己返回系统默认的实现
        
        [self popViewControllerAnimated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
