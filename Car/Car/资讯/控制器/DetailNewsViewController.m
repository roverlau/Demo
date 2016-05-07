//
//  DetailNewsViewController.m
//  Car
//
//  Created by qianfeng on 15/11/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailNewsViewController.h"
#import "AFNetworking.h"
#import "UMSocial.h"


@interface DetailNewsViewController ()<UMSocialDataDelegate>

@property (nonatomic,strong) UIWebView * webView;
@property (nonatomic,copy) NSString * str;
@end

@implementation DetailNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    [self requestData];
}

-(void)initUI
{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, 44)];
    topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topView];

    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 20, 25)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightBtn];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, 10, 20, 20)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:shareBtn];
    
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight-64)];
    [self.view addSubview:_webView];
    

}

-(void)share
{
    
    [[UMSocialControllerService defaultControllerService] setShareText:@"你想说啥呢" shareImage:nil socialUIDelegate:self];
    
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}

-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:DATA_DETAIL_URL parameters:@{@"id":_myId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
         _str = responseObject[@"result"][@"body"];
        [_webView loadHTMLString:_str baseURL:nil];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

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
