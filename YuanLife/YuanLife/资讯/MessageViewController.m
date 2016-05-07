//
//  MessageViewController.m
//  猿生活
//
//  Created by RoverLau on 15/11/4.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "MessageViewController.h"
#import "TableViewCell.h"
#import "HomeModel.h"
#import "WebViewController.h"
#import "NewsViewController.h"
#import "GameViewController.h"


@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign)NSInteger page;

@end

@implementation MessageViewController

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
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"点好" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
//    self.navigationItem.leftBarButtonItem = btn;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self updateNetworkState];
    
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

-(void)click{
    [self.navigationController pushViewController:[GameViewController new] animated:YES];
}

#pragma mark -

-(void)updateNetworkState{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //检测网络状态
    [manager startMonitoring];
    //设置回调
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
            [av show];
        }else{
            //请求数据
            [self requestNet];
        }
    }];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
            [self updateNetworkState];
            break;
        default:{
//            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"程序即将退出" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [av show];
        }
            break;
    }
}

#pragma mark -刷新相关

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
    NSString *ss = [NSString stringWithFormat:URL_HOMEMORE,self.page];
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
#pragma mark -
-(void)requestNet{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL_HOME parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

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

#pragma  mark -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}

/*
 全球购优选金牌卖家，has 最新出品绅士黑色五折晴雨伞，配有手提拉链盒，创意实用，携带非常方便！
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model =self.dataArr[indexPath.row];
    NewsViewController *news = [NewsViewController new];
    news.url = [NSString stringWithFormat:URL_HOMEINFO,model.Id];
    
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
