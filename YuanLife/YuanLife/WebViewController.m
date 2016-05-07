//
//  WebViewController.m
//  猿生活
//
//  Created by RoverLau on 15/11/5.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()


@end

@implementation WebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    NSLog(@"%@",self.url);
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:web];


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
