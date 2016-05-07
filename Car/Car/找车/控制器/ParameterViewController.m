//
//  ParameterViewController.m
//  Car
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ParameterViewController.h"
#import "AFNetworking.h"
#import "ParameterModel.h"
#import "ParameterCell.h"

@interface ParameterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
//    NSString *name;
//    NSString *params_value_type;
    NSMutableDictionary *_dataDic;
}

@end

@implementation ParameterViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
    
}
-(void)initUI
{
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, 44)];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-40, 3, 80, 30)];
    title.text = @"参数配置";
    title.textColor = [UIColor redColor];
    [v addSubview:title];
    [self.view addSubview:v];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(8, 5, 20, 30)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight-64)style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[ParameterCell class] forCellReuseIdentifier:@"cell"];
}

-(void)backBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:CAR_PARAMETER_URL parameters:@{@"mid":[NSString stringWithFormat:@"%@",_mid]}  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = responseObject;
        
        _name = dic[@"result"][@"name"];
        _params_value_type = dic[@"result"][@"params_value_type"];
    
        
        for (NSDictionary *tempDic in dic[@"result"][@"allparams"]){
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *tempDic1 in tempDic[@"list"]) {
                ParameterModel *model = [[ParameterModel alloc]init];
                model.name = tempDic1[@"name"];
                model.value = tempDic1[@"value"];
                [tempArray addObject:model];
            }
            [_dataDic setObject:tempArray forKey:tempDic[@"name"]];
        }
        [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"数据请求失败error == %@",error);
    }];
    
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataDic.allKeys.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sting = _dataDic.allKeys[section];
    NSArray *array = [_dataDic objectForKey:sting];
    return array.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ParameterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    NSString *sting = _dataDic.allKeys[indexPath.section];
    NSArray *array = [_dataDic objectForKey:sting];
    ParameterModel *model = array[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.paremeterLabel.text = model.name;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * v = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, 20)];
    v.layer.backgroundColor = [UIColor blackColor].CGColor;
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    nameLabel.text = _dataDic.allKeys[section];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.textColor = [UIColor whiteColor];
    [v addSubview:nameLabel];
    
    UILabel *paramsLabel = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth-200, 0, 180, 20)];
    paramsLabel.text = _params_value_type;
    paramsLabel.font = [UIFont systemFontOfSize:13];
    paramsLabel.textAlignment = NSTextAlignmentRight;
    paramsLabel.textColor = [UIColor whiteColor];
    [v addSubview:paramsLabel];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
