//
//  DetaliQuestionViewController.m
//  Car
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetaliQuestionViewController.h"
#import "AFNetworking.h"
#import "CommentQuestionViewController.h"
#import "CommentZeroViewController.h"

@interface DetaliQuestionViewController ()

@property (nonatomic,strong) UIWebView * webView;

@end

@implementation DetaliQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

-(void)initUI
{
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight-108)];
    [self.view addSubview:_webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:QUESTION_ANSWER_URL]];
    [_webView loadRequest:request];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, 44)];
    topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topView];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 20, 25)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightBtn];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, 10, 20, 20)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [topView addSubview:shareBtn];

    UIView * bottonView = [[UIView alloc]initWithFrame:CGRectMake(0, KMainScreenHeight-44, KMainScreenWidth, 44)];
    [self.view addSubview:bottonView];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(3, 2, KMainScreenWidth-70, 40)];
    btn.backgroundColor = [UIColor colorWithRed:220/256.0 green:225/256.0 blue:230/256.0 alpha:1.0];
    [bottonView addSubview:btn];
    [btn setTitle:@"说两句吧" forState:UIControlStateNormal];
    btn.font = [UIFont systemFontOfSize:15];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(100, 15, 20, 20)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    image.image = [UIImage imageNamed:@"ico_write_grey"];
    [btn addTarget:self action:@selector(sayAction) forControlEvents:UIControlEventTouchUpInside];
    [bottonView addSubview:image];
    
    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth-40, 10, 30, 20)];
    lb.font = [UIFont systemFontOfSize:12];
    lb.textColor = [UIColor redColor];
    lb.text = self.comment_nums;
    [bottonView addSubview:lb];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-30, 5, 15, 13)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"ico_talk"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    [bottonView addSubview:btn1];
}

-(void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)sayAction
{
    
}

-(void)jumpAction
{
   // NSLog(@"%@",_comment_nums);
    
    if ( [_comment_nums integerValue]!= 0) {
        CommentQuestionViewController *ctl = [[CommentQuestionViewController alloc]init];
        ctl.aid = _q_id;
        [self presentViewController:ctl animated:NO completion:nil];
    }
    
    if ([_comment_nums integerValue] == 0){
        CommentZeroViewController *ctl = [[CommentZeroViewController alloc]init];
        [self presentViewController:ctl animated:NO completion:nil];
    }
   
    
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
