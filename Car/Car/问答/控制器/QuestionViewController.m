//
//  QuestionViewController.m
//  Car
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "QuestionModel.h"
#import "MJRefresh.h"
#import "FMDatabase.h"
#import "DetaliQuestionViewController.h"
#import "SearchQuestionViewController.h"


@interface QuestionViewController ()<UITableViewDelegate,UITableViewDataSource>

//记录刷新时获取的最后一个数据的 q_id
@property (nonatomic,copy) NSString * Id;

@property (nonatomic,strong)FMDatabase *dataBase;
//本地是否存在数据
@property (nonatomic,assign) BOOL isOwnData;

@end

@implementation QuestionViewController

-(FMDatabase *)dataBase
{
    if (!_dataBase) {
        _dataBase = [[FMDatabase alloc]initWithPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/news.rdb"]];
       // NSLog(@"%@",NSHomeDirectory());
        
        if (![_dataBase open]) {
            NSLog(@"打开数据库失败");
        }
        
        if (![_dataBase executeUpdate:@"create table if not exists Question (id integer primary key autoincrement,title text,member_name text,ins_time text,member_img text,q_id text,comment_nums text)"]) {
            
            NSLog(@"创建表失败");
        }

        
    }
    return _dataBase;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [NSMutableArray new];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight-108) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //注册XIB
    [_tableView registerNib:[UINib nibWithNibName:@"QuestionCell" bundle:nil] forCellReuseIdentifier:@"QuestionCell"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-60, 25, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-50, 30, 100, 30)];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.text = @"最新消息";
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleLabel];
    
    //先从本地请求数据
    [self loadDataFromDataBase];
    [self refresh];
}

-(void)searchAction
{
    SearchQuestionViewController *ctl = [[SearchQuestionViewController alloc]init];
    [self presentViewController:ctl animated:NO completion:nil];

}
-(BOOL)ownData
{
    FMResultSet *set = [self.dataBase executeQuery:@"select *from Question"];
    
    return [set next];
}

-(void)loadDataFromDataBase
{
    self.isOwnData = [self ownData];
    
    if (self.isOwnData) {
        FMResultSet *set = [self.dataBase executeQuery:@"select *from Question"];
        
        while ([set next]) {
            QuestionModel * model = [QuestionModel new];
            model.title = [set stringForColumn:@"title"];
            model.member_name = [set stringForColumn:@"member_name"];
            model.ins_time = [set stringForColumn:@"ins_time"];
            model.member_img = [set stringForColumn:@"member_img"];
            model.q_id = [set stringForColumn:@"q_id"];
            model.comment_nums = [set stringForColumn:@"comment_nums"];
            
            [self.dataArr addObject:model];
        }
        
        [self.tableView reloadData];
    }
    [self isOnline];
}

-(void)isOnline
{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"没有网络，请检查您的网络设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alerView show];
        }else{
        
            [self requestData];
        }
    }];

}
#pragma  mark - 上下拉刷新
-(void)refresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self performSelector:@selector(ending) withObject:nil afterDelay:2.0f];
        [self requestData];
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.Id = [self.dataArr[self.dataArr.count-1] q_id];
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
#pragma mark - 请求网络数据
-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:QUESTION_URL parameters:@{@"count":@20,@"tord":@"up",@"startId":[NSString stringWithFormat:@"%@",self.Id]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
           if (self.isOwnData) {
            [self.dataArr removeAllObjects];
        }
        
        for (NSDictionary *dic in responseObject[@"result"][@"qlist"]) {
            QuestionModel *model = [[QuestionModel alloc]init];
            model.title = dic[@"title"];
            model.member_name = dic[@"member_name"];
            model.ins_time = dic[@"ins_time"];
            model.member_img = dic[@"member_img"];
            model.q_id = dic[@"q_id"];
            model.comment_nums = dic[@"comment_nums"];
            [self.dataArr addObject:model];
            
            if (self.isOwnData) {
                //更新
                if (![self.dataBase executeUpdate:@"update Question set title = ?,member_name = ?,ins_time = ?,member_img = ?,q_id = ? ,comment_nums = ?where id = ?",model.title,model.member_name,model.ins_time,model.member_img,model.q_id,model.comment_nums,@(self.dataArr.count)]) {
                    NSLog(@"更新失败");
               
                }else{
                //插入
                if (![self.dataBase executeUpdate:@"insert into Question (title,member_name,ins_time,member_img,q_id,comment_nums) values (?,?,?,?,?,?)",model.title,model.member_name,model.ins_time,model.member_img,model.q_id,model.comment_nums]) {
                    
                    NSLog(@"插入失败");
                    
                }
                
            }
            
        }

        }
        [self.tableView reloadData];
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error = %@",error);
    }];
}

#pragma mark - UITabelViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
    if (cell == nil) {
        cell = [[QuestionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    [cell refreshUI:_dataArr[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str = [_dataArr[indexPath.row] title];
    CGSize size = [str boundingRectWithSize:CGSizeMake(KMainScreenWidth, KMainScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height+68;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 1;
//}

// XIB自定义UIView 不能使用initWithFrame:
// XIB中加载UIView  固定写法
// loadNibNamed: 与自定义的UIView对应XIB文件名一致
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *header = [[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
//    _tableView.tableHeaderView = header;
//    return header;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetaliQuestionViewController *ctl = [[DetaliQuestionViewController alloc]init];
    ctl.q_id = [self.dataArr[indexPath.row] q_id];
    ctl.comment_nums = [self.dataArr[indexPath.row] comment_nums];
    [self presentViewController:ctl animated:NO completion:nil];

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
