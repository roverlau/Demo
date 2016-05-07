//
//  ShopViewController.m
//  猿生活
//
//  Created by RoverLau on 15/11/4.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "ShopViewController.h"
#import "SHModel.h"
#import "PrefixHeader.pch"
#import "SHTableViewCell.h"
#import "ShopInfoViewController.h"

@interface ShopViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign)NSInteger page;

@end

@implementation ShopViewController


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
    
    [self.tableview registerNib:[UINib nibWithNibName:@"SHTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
   
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
    NSString *ss = [NSString stringWithFormat:URL_shopMore,self.page];
    [manager GET:ss parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"Goods"]) {
            SHModel *model = [SHModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
            self.page = [model.Id integerValue];
        }
        [self.tableview reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
-(void)requestNet{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL_shoping parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"Goods"]) {
            SHModel *model = [SHModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        [self.tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 158;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell refreshUI:self.dataArr[indexPath.row]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopInfoViewController *info = [ShopInfoViewController new];
    SHModel *model = self.dataArr[indexPath.row];
    info.time = [NSString stringWithFormat:@"%@      %@",model.Source,model.PublishTime];
    info.picUrl = model.CoverImg;
    info.myTitle = model.Title;
    info.url = [NSString stringWithFormat:URL_shopInfo,model.Id];
    info.price = model.Price;
    [self.navigationController pushViewController:info animated:YES];
    
    
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
