//
//  CommentZeroViewController.m
//  Car
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommentZeroViewController.h"

@interface CommentZeroViewController ()

@end

@implementation CommentZeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(8, 25, 20, 30)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    UILabel * lb= [[UILabel alloc]initWithFrame:CGRectMake(30, 70, KMainScreenWidth-100, 30)];
    lb.text = @"还没有评论，快来抢占沙发吧";
    lb.font = [UIFont systemFontOfSize:13];
    lb.textColor = [UIColor grayColor];
    lb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(30,100 , KMainScreenWidth-60, KMainScreenHeight-150)];
    imgView.image = [UIImage imageNamed:@"blank_talk"];
    [self.view addSubview:imgView];
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
