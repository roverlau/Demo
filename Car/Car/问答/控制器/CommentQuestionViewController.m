//
//  CommentQuestionViewController.m
//  Car
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommentQuestionViewController.h"
#import "AFNetworking.h"
#import "CommentModel.h"
#import "CommentCell.h"

@interface CommentQuestionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation CommentQuestionViewController

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 30, 20, 25)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[CommentCell class] forCellReuseIdentifier:@"cell"];
    [self requestData];
}

-(void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:COMMAND_REPLY_URL parameters:@{@"startId":@0,@"aid":[NSString stringWithFormat:@"%@",_aid],@"count":@10,@"type":@3,@"tord":@"up"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dic in responseObject[@"result"][@"items"]) {
            CommentModel *model = [CommentModel new];
            model.member_icon = dic[@"author"][@"member_icon"];
            model.nickname = dic[@"author"][@"nickname"];
            model.content = dic[@"content"];
            model.zan_nums = dic[@"zan_nums"];
            
            [self.dataArr addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, 30)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 3, 40, 25)];
    titleLabel.text = @"评论";
    titleLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:titleLabel];
    
    return  headerView;
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
