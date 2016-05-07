//
//  MyLableViewController.m
//  Car
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyLableViewController.h"

@interface MyLableViewController ()

@end

@implementation MyLableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, 44)];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-70, 5, 140, 30)];
    title.text = @"我订阅的标签";
    title.textAlignment = NSTextAlignmentCenter;
    v.backgroundColor = [UIColor whiteColor];
    title.textColor = [UIColor redColor];
    [v addSubview:title];
    [self.view addSubview:v];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(8, 5, 20, 30)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-150, 75, 300, 25)];
    label.text = @"还没有订阅内容吧,";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.textColor = [UIColor grayColor];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-150,100, 300, 25)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:14];
    label1.text= @"快去文章的下方订阅你感兴趣的标签吧!";
    label1.textColor = [UIColor grayColor];
    [self.view addSubview:label1];
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-130, 120, 260, KMainScreenHeight- 150)];
    imgView.image = [UIImage imageNamed:@"blank_Subscribe"];
    [self.view addSubview:imgView];
    
    self.view.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1.0];
}

-(void)backBtn
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
