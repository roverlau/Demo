//
//  NextStopController.m
//  qinkeTtavel
//
//  Created by ZQ on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NextStopController.h"
#import <AFNetworking/AFNetworking.h>
#import "NextStopViewModel.h"
#import "NextStopView.h"


#define GETNEXTSTOP @"http://appsrv.flyxer.com/api/digest/article/%@?s2=lMQbnn&s1=f4ab623105876793f58be8fb321232c2"

@interface NextStopController ()

@property (nonatomic , retain) UIActivityIndicatorView *loadAnimo;

@property (nonatomic , retain) NextStopViewModel *model;

@end

@implementation NextStopController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadAnimoStar];
    
    [self obserNet];
}

-(void)loadAnimoStar
{
    _loadAnimo = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _loadAnimo.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    //        _actView
    _loadAnimo.hidesWhenStopped = YES;
    _loadAnimo.color = [UIColor redColor];
    
    [self.view addSubview:_loadAnimo];
    
    [_loadAnimo startAnimating];
}

-(void)obserNet
{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //网络异常
            
            [_loadAnimo stopAnimating];
        }
        else
        {
            [self getData];
        }
        
    }];
}

-(void)getData
{
    NSString *urlStr = [NSString stringWithFormat:GETNEXTSTOP,_goodId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.model = [NextStopViewModel yy_modelWithJSON:responseObject];
        
        [_loadAnimo stopAnimating];
        
        [self loadMianView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"NextStop数据获取失败");
        [_loadAnimo stopAnimating];
    }];
}

-(void)loadMianView
{
    
    NextStopView *nextView = [[NextStopView alloc]initWithFrame:self.view.frame];
//    nextView.bodyArray = _model.body;
    nextView.model = _model;
    [self.view addSubview:nextView];
    
   
    
    
}

@end
