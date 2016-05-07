//
//  SelectShowController.m
//  qinkeTtavel
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SelectShowController.h"
#import "ShowScroll.h"
#import <AFNetworking/AFNetworking.h>
#import "ShowModel.h"
#import <Masonry/Masonry.h>
#import "MapViewController.h"
#import "ImageShowController.h"
#import "HYBBubbleTransition.h"

#define GETSHOWSELECT @"http://appsrv.flyxer.com/api/digest/recomm/%@?s2=fF2vcx&s1=a9fc13ce5852079a5bf508880786760a&v=3"

@interface SelectShowController ()<UIScrollViewDelegate>

@property (nonatomic , retain) ShowScroll *showScroll;

@property (nonatomic , retain) UIActivityIndicatorView *loadAnimo;

@property (nonatomic , retain) ShowModel *model;

@property (nonatomic , retain) HYBBubbleTransition *bubbleTransition;

@end

@implementation SelectShowController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self obserNet];
    [self starLoadView];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


-(void)starLoadView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tabBarController.tabBar.hidden = YES;
        [self.view addSubview:self.showScroll];
        
        [self loadAnimoStar];
    });
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
    NSString *urlStr = [NSString stringWithFormat:GETSHOWSELECT,_goodId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        NSLog(@"%@",responseObject);
        
        _model = [ShowModel yy_modelWithJSON:responseObject];
            
        
        _showScroll.model = _model;
        
        
        [_loadAnimo stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"select数据获取失败");
        [_loadAnimo stopAnimating];
    }];
    
}

#pragma mark -- getter
-(ShowScroll *)showScroll
{
    if (!_showScroll) {
        _showScroll = [[ShowScroll alloc]initWithFrame:self.view.bounds];
        _showScroll.backgroundColor = [UIColor whiteColor];
        _showScroll.alwaysBounceVertical = YES;
//        _showScroll.bounces = NO;
        _showScroll.delegate = self;
//        self.navigationController.navigationBar.hidden = NO;
        
        __weak typeof(self)weakSelf = self;
        [_showScroll setPushMap:^(NSString *str) {
           
            MapViewController *vc = [[MapViewController alloc]init];
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }];
        
//        __weak typeof(ShowModel *)weakModel = _model;
        [_showScroll setPushImageV:^(NSInteger cc,ShowModel *model) {
            
            ImageShowController *isc = [ImageShowController new];
            isc.cc = cc;
            isc.model = model;
//            [weakSelf.navigationController pushViewController:isc animated:YES];
            isc.modalPresentationStyle = UIModalPresentationCustom;
            
            weakSelf.bubbleTransition = [[HYBBubbleTransition alloc]initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
                
                HYBBubbleTransition *bubble = (HYBBubbleTransition *)transition;
                
                bubble.bubbleColor = presented.view.backgroundColor;
                
                
            } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
                
                transition.transitionMode = kHYBTransitionDismiss;
                
            }];
            
            isc.transitioningDelegate = weakSelf.bubbleTransition;
            
            [weakSelf presentViewController:isc animated:YES completion:nil];
            
        }];
        
    }
    return _showScroll;
}

#pragma mark -- scrollDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _showScroll) {
//        NSLog(@"%f -- %f",scrollView.contentOffset.y,scrollView.contentInset.top);
        
        if (scrollView.contentOffset.y > -63) {
            self.navigationController.navigationBar.hidden = NO;
            
        }
        else
        {
//            scrollView.zoomBouncing
            self.navigationController.navigationBar.hidden = YES;
            
            float y = scrollView.contentOffset.y;
            if ( y < -250) {
//                _showScroll.contentInset = UIEdgeInsetsMake(-y, 0, 0, 0);
                
//                CGRect rect = _showScroll.headImageV.bounds;
//                
//                rect.origin.y = y;
//                rect.size.height = -y;
//                
//                _showScroll.headImageV.frame = rect;
                
                [_showScroll setheadImageVAnimoteWith:-y];
                
                CGFloat s = 0.008;
                CGFloat scale = (-y - 250) * s;
                
                _showScroll.headImageV.transform = CGAffineTransformMakeScale(1+scale, 1+scale);
                
            }
           
        }
    }
}













@end
