//
//  ReadViewController.m
//  Car
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ReadViewController.h"

@interface ReadViewController ()

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-150, 25, 300, 25)];
    label.text = @"还没有订阅内容吧,";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.textColor = [UIColor grayColor];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-150,50, 300, 25)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:14];
    label1.text= @"快去文章的下方订阅你感兴趣的标签吧!";
    label1.textColor = [UIColor grayColor];
    [self.view addSubview:label1];
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-130, 80, 260, KMainScreenHeight- 150)];
    imgView.image = [UIImage imageNamed:@"blank_Subscribe"];
    [self.view addSubview:imgView];
    
    self.view.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1.0];
    
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
