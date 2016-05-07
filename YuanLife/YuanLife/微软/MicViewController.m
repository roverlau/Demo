//
//  MicViewController.m
//  猿生活
//
//  Created by RoverLau on 15/11/7.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "MicViewController.h"
#import "TableViewCell.h"
#import "HomeModel.h"
#import "WebViewController.h"
#import "NewsViewController.h"


@interface MicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign)NSInteger page;

@end

@implementation MicViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableview registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self requestNet];
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArr removeAllObjects];
        [self requestNet];
        [self performSelector:@selector(ending) withObject:nil afterDelay:1.0f];
    }];
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestNetMore];
        self.page-=15;
        [self performSelector:@selector(ending) withObject:nil afterDelay:1.0f];
    }];
}

-(void)ending{
    if (self.tableview.header.isRefreshing) {
        //如果下拉控件处于刷新状态 则结束刷新
        [self.tableview.header endRefreshing];
    }else if (self.tableview.footer.isRefreshing) {
        [self.tableview.footer endRefreshing];
    }
}

-(void)requestNetMore{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *ss = [NSString stringWithFormat:URL_MICMore,self.page];
    [manager GET:ss parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        for (NSDictionary *dic in responseObject[@"Articles"]) {
            HomeModel *model = [HomeModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        [self.tableview reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

-(void)requestNet{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL_MIC parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"Articles"]) {
            HomeModel *model = [HomeModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
            self.page = [model.Id integerValue];
        }
        
        [self.tableview reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.dataArr.count==0) {
        return cell;
    }
    
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model =self.dataArr[indexPath.row];
    NSLog(@"%@",model.Id);
    NewsViewController *news = [NewsViewController new];
    news.url = [NSString stringWithFormat:URL_MICInfo,model.Id];
    
    [self.navigationController pushViewController:news animated:YES];
    
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
