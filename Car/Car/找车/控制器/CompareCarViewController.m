//
//  CompareCarViewController.m
//  Car
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CompareCarViewController.h"
#import "TwoParameterCell.h"
#import "AFNetworking.h"
#import "CarTypeModel.h"
#import "ParameterModel.h"

@interface CompareCarViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *_oneDataDic;
    NSMutableDictionary *_twoDataDic;
}
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation CompareCarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _oneDataDic = [NSMutableDictionary dictionary];
        _twoDataDic = [NSMutableDictionary dictionary];
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
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-40, 5, 80, 30)];
    title.text = @"车型对比";
    title.textColor = [UIColor redColor];
    [v addSubview:title];
    [self.view addSubview:v];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(8, 5, 20, 30)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];
    
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, 100, 100)];
    typeLabel.text = @"车型";
    typeLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:typeLabel];
    
    CarTypeModel *model1 = self.dataArr[0];
    CarTypeModel *model2 = self.dataArr[1];
    
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 64, (KMainScreenWidth-100)/2, 100)];
    oneLabel.font = [UIFont systemFontOfSize:15];
    oneLabel.numberOfLines = 0;
    oneLabel.text = model1.name;
    [self.view addSubview:oneLabel];
    UIView *v1= [[UIView alloc]initWithFrame:CGRectMake(100+(KMainScreenWidth-100)/2+1, 64, 0.4, 100)];
    v1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:v1];
    UILabel *twoLabel = [[UILabel alloc]initWithFrame:CGRectMake((KMainScreenWidth-100)/2+101, 64, (KMainScreenWidth-100)/2-1, 100)];
    twoLabel.numberOfLines = 0;
    twoLabel.text = model2.name;
    twoLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:twoLabel];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 164, KMainScreenWidth, KMainScreenHeight-164) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[TwoParameterCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];

}

-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    CarTypeModel *model1 = self.dataArr[0];
    CarTypeModel *model2 = self.dataArr[1];
    NSString *str1 = [NSString stringWithFormat:@"%@",model1.mid];
    NSString *str2 = [NSString stringWithFormat:@"%@",model2.mid];
    NSString *str = [NSString stringWithFormat:@"%@,%@",str1,str2];
    
    [manager GET:TWO_CAR_PARAMETER_URL parameters:@{@"mids":[NSString stringWithFormat:@"%@",str]}  success:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSDictionary *dic = responseObject;
        
        _name = dic[@"result"][0][@"name"];
        _params_value_type = dic[@"result"][0][@"params_value_type"];
        
        for (NSDictionary *tempDic in dic[@"result"][0][@"allparams"]){
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *tempDic1 in tempDic[@"list"]) {
                ParameterModel *model = [[ParameterModel alloc]init];
                model.name = tempDic1[@"name"];
                model.value = tempDic1[@"value"];
                [tempArray addObject:model];
            }
            [_oneDataDic setObject:tempArray forKey:tempDic[@"name"]];
        }
        
        
        for (NSDictionary *tempDic in dic[@"result"][1][@"allparams"]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *tempDic1 in tempDic[@"list"]) {
                ParameterModel *model = [[ParameterModel alloc]init];
                model.name = tempDic1[@"name"];
                model.value = tempDic1[@"value"];
                [tempArray addObject:model];
            }
            [_twoDataDic setObject:tempArray forKey:tempDic[@"name"]];

        }
        
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败error == %@",error);
    }];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _oneDataDic.allKeys.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *string = _oneDataDic.allKeys[section];
    NSArray *array = [_oneDataDic objectForKey:string];
    return array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwoParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[TwoParameterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    NSString *string = _oneDataDic.allKeys[indexPath.section];
    NSArray *array = [_oneDataDic objectForKey:string];
    ParameterModel *model = array[indexPath.row];

    cell.titleLabel.text = model.name;
    cell.oneCarLabel.text = model.value;
    
    NSString *string1 = _twoDataDic.allKeys[indexPath.section];
    NSArray *array1 = [_twoDataDic objectForKey:string1];
    ParameterModel *model1 = array1[indexPath.row];
    cell.twoCarLabel.text = model1.name;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * v = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, 20)];
    v.layer.backgroundColor = [UIColor blackColor].CGColor;
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    nameLabel.text = _oneDataDic.allKeys[section];
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


-(void)backBtn
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
