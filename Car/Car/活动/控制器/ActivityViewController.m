//
//  ActivityViewController.m
//  汽车导购
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ActivityViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "ActivityCell.h"
#import "UIImageView+WebCache.h"
#import "ActivityCenterViewController.h"

@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    UILabel *lb = [[UILabel alloc]init];
    
    lb.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-50 , 0, 100, 44);
    
    lb.text = @"活动中心";
    lb.textColor = [UIColor redColor];
    [self.view addSubview:v];
    [v addSubview:lb];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-108)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //注册xib
    [_tableView registerClass:[ActivityCell class] forCellReuseIdentifier:@"ActivityCell"];
    
    _dataArr = [[NSMutableArray alloc]init];
    //请求网络相关数据
    [self requestData];
}

#pragma mark - 请求网络相关数据
-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:ACTIVITY_CENTER_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"responseObject = %@",responseObject);
        for (NSDictionary *dic in responseObject[@"result"]) {
            [_dataArr addObject:dic[@"share_hd_img"]];
        }
        
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"]; [cell.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row]]]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCenterViewController *ctl = [[ActivityCenterViewController alloc]init];
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
