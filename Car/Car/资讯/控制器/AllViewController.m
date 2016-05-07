//
//  AllViewController.m
//  Car
//
//  Created by qianfeng on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AllViewController.h"

#import "AFNetworking.h"
#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "JGProgressHUD.h"
#import "NewsModel.h"
#import "DetailNewsViewController.h"
#import "MJRefresh.h"

@interface AllViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,copy) UITableView * tableView;


@property (nonatomic, strong) JGProgressHUD *messageHUD;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic,copy) NSString * numId;

@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, KMainScreenHeight-100)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
     [self.tableView registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
    
    [self refresh];
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

-(void)ending{
    if (self.tableView.header.isRefreshing) {
        [self.tableView.header endRefreshing];
     }else if(self.tableView.footer.isRefreshing){
        [self.tableView.footer endRefreshing];
        
    }
}
//在页面即将出现时请求数据
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self requestData];
    
}

-(void)requestData
{
    CGRect destRect = self.view.frame;
    destRect.origin = CGPointMake(0, -64);
    destRect.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+64);
    [self.messageHUD showInRect:destRect inView:self.view animated:YES];
    
    NSDictionary *parameters = @{@"topicId":@0,@"startId":[NSString stringWithFormat:@"%@",_numId],@"cate":[NSString stringWithFormat:@"%ld",_cate],@"count":@20,@"tagId":@0,@"tord":@"up"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:self.urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         for (NSDictionary *dic in responseObject[@"result"]) {
            NewsModel * model  = [[NewsModel alloc]init];
            model.cover_url = dic[@"cover_url"];
            model.instime = dic[@"instime"];
            model.comment_nums = dic[@"comment_nums"];
            model.title = dic[@"title"];
            model.myId = dic[@"id"];
            [self.dataArr addObject:model];
        }

        [self.tableView reloadData];
        [self.messageHUD dismissAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.messageHUD dismissAnimated:YES];
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@">>>>>%ld",self.dataArr.count);
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailNewsViewController *ctl = [[DetailNewsViewController alloc]init];
    ctl.myId = [self.dataArr[indexPath.row] myId];
    [self presentViewController:ctl animated:NO completion:nil];
}


#pragma mark - Getter
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    
    return _dataArr;
}

- (JGProgressHUD *)messageHUD
{
    if (_messageHUD == nil) {
        _messageHUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
        _messageHUD.textLabel.text = @"正在加载数据...";
    }
    
    return _messageHUD;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
