//
//  LoginViewController.m
//  汽车导购
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

-(void)createUI
{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    UIImageView  *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,44)];
    [imageV setImage:[UIImage imageNamed:@"comments-bar"]];
    UIButton *btnImg = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [btnImg setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btnImg addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:imageV];
    [v addSubview:btnImg];
    [self.view addSubview:v];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-130, 200, 260, 40)];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"icoBtnNo"] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [loginBtn setTitle:[NSString stringWithFormat:@"登 录"] forState:UIControlStateNormal];
    
    [self.view addSubview:loginBtn];
    
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-130, 280, 260, 40)];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"icoBtnNo"] forState:UIControlStateNormal];
    [registerBtn setTitle:[NSString stringWithFormat:@"注 册"] forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-80, 360, 160, 20)];
    lb.text = @"选择以下第三方快速登录";
    lb.font = [UIFont systemFontOfSize:12];
    lb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb];

    
    UIButton *blogBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/5, 440, [UIScreen mainScreen].bounds.size.width/5, [UIScreen mainScreen].bounds.size.width/5)];
    [blogBtn setBackgroundImage:[UIImage imageNamed:@"iwoSina"] forState:UIControlStateNormal];
    [self.view addSubview:blogBtn];
    
    UIButton *qqBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/5*3, 440,[UIScreen mainScreen].bounds.size.width/5 , [UIScreen mainScreen].bounds.size.width/5)];
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"iwoQq"] forState:UIControlStateNormal];
    [self.view addSubview:qqBtn];
    
    
}


#pragma mark - 点击<
-(void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
