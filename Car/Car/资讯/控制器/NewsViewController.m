//
//  NewsViewController.m
//  汽车导购
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#include "NewsViewController.h"
#import "DPScrollPageController.h"
#import "DPScrollPageTitleView.h"
#import "NewsCell.h"
#import "AllViewController.h"
#import "ChannelViewController.h"
#import "SearchViewController.h"
#import "LatestViewController.h"
#import "ReadViewController.h"

#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)

@interface NewsViewController () <DPScrollPageControllerDelegate, DPScrollPageTitleViewDelegate>

@property (nonatomic, strong) DPScrollPageController *scrollPageController;
@property (nonatomic, strong) DPScrollPageTitleView  *scrollTitleView;
@property (nonatomic, strong) NSArray                *newsViewControllers;
@property (nonatomic, strong) NSArray                *titles;
@property (nonatomic, strong) NSArray                *urlStrings;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.title = @"DPScrollPageController";
    
    /**
     DPScrollPageController和DPScrollPageTitleView 是我自己封装的两个控件
     DPScrollPageController 用来控制滚动页的，是ViewController
     DPScrollPageTitleView  是用来显示标题栏的，是View
     
     别的项目也可以直接那来用
     */
    
    // 添加标题栏，标题栏是用Getter方法创建的，详情见Getter方法
    [self.view addSubview:self.scrollTitleView];
    
    // 添加滚动页控件，也是用Getter方法创建的，是一个ViewController，所以用ChildViewController的方式创建
    [self addChildViewController:self.scrollPageController];
    [self.view addSubview:self.scrollPageController.view];
    [self.scrollPageController didMoveToParentViewController:self];
    
    // 设置要显示的各个ViewController的数组
    self.scrollPageController.viewControllers = [NSMutableArray arrayWithArray:self.newsViewControllers];
    
    // 设置自动调整ScrollView的ContentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
}



#pragma mark - DPScrollPageControllerDelegate

// DPScrollPage的代理方法，滚动的时候调用
- (void)scrollPage:(DPScrollPageController *)scrollPage didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex scale:(CGFloat)scale
{
    UILabel *fromTitleLabel = [self.scrollTitleView titleLabelForIndex:fromIndex];
    UILabel *toTitleLabel = [self.scrollTitleView titleLabelForIndex:toIndex];
    
    // 滚动的时候调整TitleLabel的颜色
    fromTitleLabel.textColor = [UIColor colorWithRed:1-scale green:0 blue:0 alpha:1.0f];
    toTitleLabel.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0f];
    
    // 滚动的时候调整TitleLabel的大小
    CGFloat p = 0.2*scale;
    fromTitleLabel.transform = CGAffineTransformMakeScale(1.1-p, 1.1-p);
    toTitleLabel.transform = CGAffineTransformMakeScale(1+p, 1+p);
}

// DPScrollPage的代理方法，滚动停止是调用
- (void)scrollPage:(DPScrollPageController *)scrollPage didEndScrollToIndex:(NSInteger)toIndex
{
    // 让对应的标题在屏幕上可见
    //    [self.scrollTitleView scrollToVisibleTitleLabelAtIndex:toIndex];
    [self.scrollTitleView scrollToCenterForTitleLabelAtIndex:toIndex];
}


#pragma mark - DPScrollPageTitleViewDelegate

- (void)scrollPageTitleView:(DPScrollPageTitleView *)titleView titleDidTap:(UILabel *)titleLabel atIndex:(NSInteger)index
{
    NSInteger currentIndex = self.scrollPageController.currentIndex;
    UILabel *currentLabel = [self.scrollTitleView titleLabelForIndex:currentIndex];
    currentLabel.textColor = [UIColor blackColor];
    currentLabel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    
    titleLabel.textColor = [UIColor redColor];
    titleLabel.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    
    [self.scrollPageController scrollToPageAtIndex:index animated:NO];
}


#pragma mark - Getter

- (DPScrollPageController *)scrollPageController
{
    if (_scrollPageController == nil) {
        _scrollPageController = [[DPScrollPageController alloc] init];
        _scrollPageController.view.frame = CGRectMake(0, 20+35, KMainScreenWidth, kScreenHeight-104);
        _scrollPageController.delegate = self;
    }
    
    return _scrollPageController;
}

- (DPScrollPageTitleView *)scrollTitleView
{
    if (_scrollTitleView == nil) {
        _scrollTitleView = [[DPScrollPageTitleView alloc] initWithFrame:CGRectMake(0, 20, KMainScreenWidth-70, 44) titles:self.titles itemWidth:70];
        _scrollTitleView.delegate = self;
        
        _scrollTitleView.backgroundColor = [UIColor clearColor];
        UILabel *firstLabel = [_scrollTitleView titleLabelForIndex:0];
        firstLabel.textColor = [UIColor redColor];
        firstLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        UIButton *downBtn = [[UIButton alloc]initWithFrame:CGRectMake((KMainScreenWidth- KMainScreenWidth/5)+10, 37, 24, 13)];
            [downBtn setBackgroundImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
            [self.view addSubview:downBtn];
        
            [downBtn addTarget:self action:@selector(allAction) forControlEvents:UIControlEventTouchUpInside];
        
            UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake((KMainScreenWidth- KMainScreenWidth/5)+40, 33, 20, 20)];
            [searchBtn setBackgroundImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
            [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:searchBtn];

    }
    
    return _scrollTitleView;
}

#pragma mark - 点击v产生的事件
-(void)allAction
{
    ChannelViewController *ctl = [[ChannelViewController alloc]init];
    [self presentViewController:ctl animated:NO completion:nil];
}

#pragma mark - 点击搜索按钮产生的事件
-(void)searchAction
{
    SearchViewController *ctl = [[SearchViewController alloc]init];
    [self presentViewController:ctl animated:NO completion:nil];
}

- (NSArray *)newsViewControllers
{
    if (_newsViewControllers == nil) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.titles.count; i ++) {
            
            if (i == 0) {
                LatestViewController *latestVC = [[LatestViewController alloc]init];
                [tempArr addObject:latestVC];
            }else if (i == 1) {
                ReadViewController *readVC = [[ReadViewController alloc]init];
                [tempArr addObject:readVC];
            }else if (i == 2){
                AllViewController *newsVC = [[AllViewController alloc] initWithNibName:@"AllViewController" bundle:nil];
                newsVC.urlString = self.urlStrings[i-2];
                newsVC.cate = 1365;
                [tempArr addObject:newsVC];
        }else if(i == 3){
            AllViewController *newsVC = [[AllViewController alloc] initWithNibName:@"AllViewController" bundle:nil];
            newsVC.urlString = self.urlStrings[i-2];
            newsVC.cate = 1361;
            [tempArr addObject:newsVC];
        }else if(i == 4){
            AllViewController *newsVC = [[AllViewController alloc] initWithNibName:@"AllViewController" bundle:nil];
            newsVC.urlString = self.urlStrings[i-2];
            newsVC.cate = 1360;
            [tempArr addObject:newsVC];
        
        }else if(i == 5){
            AllViewController *newsVC = [[AllViewController alloc] initWithNibName:@"AllViewController" bundle:nil];
            newsVC.urlString = self.urlStrings[i-2];
            newsVC.cate = 1362;
            [tempArr addObject:newsVC];
        }else if(i ==6){
            AllViewController *newsVC = [[AllViewController alloc] initWithNibName:@"AllViewController" bundle:nil];
            newsVC.urlString = self.urlStrings[i-2];
            newsVC.cate = 1449;
            [tempArr addObject:newsVC];
        
        }else if(i == 7){
            AllViewController *newsVC = [[AllViewController alloc] initWithNibName:@"AllViewController" bundle:nil];
            newsVC.urlString = self.urlStrings[i-2];
            newsVC.cate = 1364;
            [tempArr addObject:newsVC];
        }
            
        }
        
        _newsViewControllers = [[NSArray alloc] initWithArray:tempArr];
    }
    
    return _newsViewControllers;
}

- (NSArray *)titles
{
    if (_titles == nil) {
    
         _titles = @[@"最新",@"订阅",@"优惠", @"图趣", @"新车", @"新闻", @"视频", @"导购"];
    }
    return _titles;
}

- (NSArray *)urlStrings
{
    if (_urlStrings == nil) {
        _urlStrings = @[FREE_URL,IMAGE_URL,NEW_CAR_URL,NEWS_URL,VEDIO_URL,SHOP_URL];
    }
    
    return _urlStrings;
}





//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
