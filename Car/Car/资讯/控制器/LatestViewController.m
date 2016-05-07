//
//  LatestViewController.m
//  Car
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LatestViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "NewsCell.h"
#import "DetailNewsViewController.h"
#import "smallScrollVModel.h"
#import "MJRefresh.h"

@interface LatestViewController ()<UITableViewDelegate,UITableViewDataSource>
//中间的滚动视图的数据数组
@property (nonatomic,strong) NSMutableArray * scrollDataArr;

//中间的滚动视图
@property (nonatomic,strong) UIScrollView * scrollView;

//表头
@property (nonatomic,strong) UIView * headerView;

//分页控制器
@property (nonatomic,strong) UIPageControl * pageCtl;

@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSString * numId;
@end

@implementation LatestViewController
#pragma mark - 懒加载数据
-(NSMutableArray *)scrollDataArr
{
    if (_scrollDataArr == nil) {
        _scrollDataArr = [NSMutableArray new];
    }
    return _scrollDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建UI
    [self createUI];

    _dataArr = [[NSMutableArray alloc]init];

    //表头
    [self myHeaderView];

   //请求表头scrollView的数据
    [self requestScrollViewData];

    [self requestData];

    [self refresh];

}

#pragma mark - 初始化scrollView
-(void)myHeaderView
{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    //隐藏横向纵向滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    //关闭偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.delegate = self;
    [_headerView addSubview:_scrollView];

}

#pragma mark - 创建UI
-(void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-108)];

    _tableView.delegate = self;
    _tableView.dataSource = self;
     [_tableView registerClass:[NewsCell class] forCellReuseIdentifier:@"cell1"];
   
    [self.view addSubview:_tableView];
}


#pragma mark -  最新scrollView数据请求
-(void)requestScrollViewData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:MIDDLE_AD_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        for (NSDictionary *dic in responseObject[
             @"result"]) {
            smallScrollVModel *model = [[smallScrollVModel alloc]init];
            model.meta = dic[@"meta"];
            model.url = dic[@"url"];
            [self.scrollDataArr addObject:model];
        }

        _scrollView.contentSize = CGSizeMake((self.scrollDataArr.count+2)*[UIScreen mainScreen].bounds.size.width, 200);
        _scrollView.tag = 10;
        _tableView.tableHeaderView = _headerView;
        for (NSInteger i = 0; i < self.scrollDataArr.count+2; i ++) {

            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width,200)];
            UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width *i +10, 150, [UIScreen mainScreen].bounds.size.width-100, 40)];
            lb.textColor = [UIColor whiteColor];
            lb.font = [UIFont systemFontOfSize:14];
//            lb.text = [self.scrollDataArr[i] meta];
//            [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.scrollDataArr[i] url]]]];
            
            if (i == 0) {
                lb.text = [self.scrollDataArr[self.scrollDataArr.count-1] meta];
                [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.scrollDataArr[self.scrollDataArr.count-1] url]]]];
            }else if(i == self.scrollDataArr.count+1){
                lb.text = [self.scrollDataArr[0] meta];
                [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.scrollDataArr[0] url]]]];
            }else{
                lb.text = [self.scrollDataArr[i-1] meta];
                [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.scrollDataArr[i-1] url]]]];
            }
            

            [self.scrollView addSubview:imgView];
            [self.scrollView addSubview:lb];
            [lb bringSubviewToFront:self.scrollView];
        }

        [_scrollView scrollRectToVisible:CGRectMake(KMainScreenWidth, 0, KMainScreenWidth, 200) animated:NO];
        UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120,177 , 120, 20)];
        [self.tableView addSubview:pageView];
        pageView.backgroundColor = [UIColor clearColor];

        //设置pageCtl的分页数
        _pageCtl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,0,120, 20)];
        _pageCtl.numberOfPages = self.scrollDataArr.count;
        //_pageCtl.numberOfPages = 1;
        [_pageCtl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];

        _pageCtl.pageIndicatorTintColor = [UIColor yellowColor];
        //当前索引颜色
        _pageCtl.currentPageIndicatorTintColor = [UIColor grayColor];
        _pageCtl.pageIndicatorTintColor = [UIColor whiteColor];

        [pageView addSubview:_pageCtl];

        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scroll) userInfo:nil repeats:YES];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];

}

-(void)scroll
{
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:10];
      int index = (scrollView.contentOffset.x +375) / 375 ;
 
    // 右滑判断
    if (index == 0) {
        scrollView.contentOffset = CGPointMake((self.scrollDataArr.count-1)*375, 0);
        _pageCtl.currentPage = self.scrollDataArr.count;
    }
    // 左滑判断
    if (index == self.scrollDataArr.count+1) {
        scrollView.contentOffset = CGPointMake(0, 0);
        _pageCtl.currentPage = 1;
    }

      [scrollView scrollRectToVisible:CGRectMake(scrollView.contentOffset.x+KMainScreenWidth, 0, KMainScreenWidth, 200) animated:YES];
    
    _pageCtl.currentPage = scrollView.contentOffset.x/KMainScreenWidth;
   
}


-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:NEW_NEWS_URL parameters:@{@"topicId":@0,@"startId":[NSString stringWithFormat:@"%@",_numId],@"cate":@0,@"count":@20,@"tagId":@0,@"tord":@"up"} success:^(AFHTTPRequestOperation *operation, id responseObject) {

        for (NSDictionary *dic in responseObject[@"result"][@"artlist"]) {

            NewsModel * model  = [[NewsModel alloc]init];
          
            model.cover_url = dic[@"cover_url"];
            model.instime = dic[@"instime"];
            model.comment_nums = dic[@"comment_nums"];
            model.title = dic[@"title"];
            model.myId = dic[@"id"];

            [self.dataArr addObject:model];
        }

        [self.tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];

}


#pragma mark - 上下拉刷新
-(void)refresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self requestData];
        [self performSelector:@selector(ending) withObject:nil afterDelay:2.0f];
    }];

    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _numId = [self.dataArr[self.dataArr.count-1] instime];
        [self requestData];
        [self performSelector:@selector(ending) withObject:nil afterDelay:2.0f];
    }];

}

-(void)ending
{
    if (self.tableView.header.isRefreshing
        ) {
        [self.tableView.header endRefreshing];
    }else if(self.tableView.footer.isRefreshing){

        [self.tableView.footer endRefreshing];

    }
}

#pragma  mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailNewsViewController * ctl = [[DetailNewsViewController alloc]init];
    ctl.myId = [self.dataArr[indexPath.row] myId];
    [self presentViewController:ctl animated:NO completion:nil];
}




@end
