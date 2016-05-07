//
//  ActivityCenterViewController.m
//  汽车导购
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ActivityCenterViewController.h"

@interface ActivityCenterViewController ()

@end

@implementation ActivityCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createUI];
    
}

#pragma mark - 搭建UI
-(void)createUI
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    [self.view addSubview:topView];
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 20, 25)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightBtn];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, 10, 20, 20)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [topView addSubview:shareBtn];
    
    UIView *buttomView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44, [UIScreen mainScreen].bounds.size.width, 44)];
    [self.view addSubview:buttomView];
    
    UIButton *sayBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 3, [UIScreen mainScreen].bounds.size.width -100, 34)];
    [sayBtn setBackgroundImage:[UIImage imageNamed:@"icoBtnNo"] forState:UIControlStateNormal];
    [buttomView addSubview:sayBtn];
    [sayBtn setTitle:@"说两句吧" forState:UIControlStateNormal];
    [sayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    sayBtn.font = [UIFont systemFontOfSize:12];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 13, 15, 15)];
    imgView.image = [UIImage imageNamed:@"ico_write_grey"];
    [buttomView addSubview:imgView];
    
    NSString *str = [[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:ACTIVITY_DETAIL_URL] encoding:NSUTF8StringEncoding error:nil];
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth,KMainScreenHeight-108)];
    [webView loadHTMLString:str baseURL:nil];
    [self.view addSubview:webView];
}


#pragma mark - 点击<返回
-(void)backAction
{

    [self dismissViewControllerAnimated:YES completion:nil];
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
