//
//  TagsShowController.m
//  qinkeTtavel
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TagsShowController.h"
#import <AFNetworking/AFNetworking.h>
#import "TagListModel.h"
#import "TagListCell.h"
#import "TagListTwoCell.h"
#import "SelectShowController.h"
#import "RecommendController.h"

#define GETTAGSSHOW @"http://appsrv.flyxer.com/api/digest/recomm/tag/%@?did=59911&s2=TK6QwH&s1=03b372b93ed596ea7928954a26c86842&v=3&page=1"


@interface TagsShowController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain) UIActivityIndicatorView *loadAnimo;

@property (nonatomic , retain) UITableView *tagTableView;

@property (nonatomic , retain) NSMutableArray *dataArray;

@end

@implementation TagsShowController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    self.title = _name;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tagTableView];
    
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
    NSString *urlStr = [NSString stringWithFormat:GETTAGSSHOW,_goodId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        for (NSDictionary *dic in responseObject) {
            
          
            TagListModel *model = [TagListModel yy_modelWithJSON:dic];
            [_dataArray addObject:model];
        
        }
        
        
        [_tagTableView reloadData];
       
        [_loadAnimo stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"select数据获取失败");
        [_loadAnimo stopAnimating];
    }];
}

#pragma mark -- TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TagListModel *model = _dataArray[indexPath.row];
    if (model.collections) {
        
        TagListTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TagListTwoCell"];
        if (!cell) {
            cell = [[TagListTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TagListTwoCell"];
        }
        
        TagListSonModel *sonModel = model.collections[0];
        cell.model = sonModel;
        
        return cell;
        
    }
    else
    {
        TagListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TagListCell"];
        if (!cell) {
            cell = [[TagListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TagListCell"];
        }
        cell.model = model;
        
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 202;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TagListModel *model = _dataArray[indexPath.row];
    
    if (model.collections) {
        TagListSonModel *sonModel = model.collections[0];
        RecommendController *vc = [[RecommendController alloc]init];
        
        vc.goodId = sonModel.goodId;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        SelectShowController *vc = [[SelectShowController alloc]init];
        
        vc.goodId = model.goodId;
        
        [self.navigationController pushViewController:vc animated:YES];

    }
    
}

#pragma mark -- getter
-(UITableView *)tagTableView
{
    if (!_tagTableView) {
        
        _tagTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tagTableView.backgroundColor = [UIColor whiteColor];
        _tagTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        
        _tagTableView.delegate = self;
        _tagTableView.dataSource = self;
        
    }
    return _tagTableView;
}

@end
