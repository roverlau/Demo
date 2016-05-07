//
//  RecommendAppViewController.m
//  Car
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RecommendAppViewController.h"
#import "CommandCell.h"
#import "AFNetworking.h"
#import "CommandModel.h"

@interface RecommendAppViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation RecommendAppViewController

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
}

-(void)initUI
{
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, 44)];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-70, 5, 140, 30)];
    title.text = @"推荐安装";
    title.textAlignment = NSTextAlignmentCenter;
    v.backgroundColor = [UIColor whiteColor];
    title.textColor = [UIColor redColor];
    [v addSubview:title];
    [self.view addSubview:v];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(8, 5, 20, 30)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];


    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)backBtn
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:RECOMMEND_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       
        for (NSDictionary *dic in responseObject[@"result"]) {
            CommandModel *model = [[CommandModel alloc]init];
            model.app_icon = dic[@"app_icon"];
            model.app_meta = dic[@"app_meta"];
            model.app_name = dic[@"app_name"];
            model.download_url = dic[@"download_url"];
            model.weight = dic[@"weight"];
            
            [self.dataArr addObject:model];
            
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        
    }];

}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"%ld",self.dataArr.count);
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommandCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CommandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
