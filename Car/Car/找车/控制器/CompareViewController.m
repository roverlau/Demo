//
//  CompareViewController.m
//  Car
//
//  Created by qianfeng on 15/11/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CompareViewController.h"
#import "Compare.h"
#import "CarTypeModel.h"
#import "CompareCarViewController.h"


@interface CompareViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableDictionary *dataDic;


@end

@implementation CompareViewController

-(NSMutableDictionary *)dataDic
{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshUI];
}

-(void)refreshUI
{
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, 44)];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-40, 5, 80, 30)];
    title.text = @"比车列表";
    title.textColor = [UIColor redColor];
    [v addSubview:title];
    [self.view addSubview:v];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(8, 5, 20, 30)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];

    if ([self.num isEqualToString:@"0"]) {
        UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, KMainScreenHeight)];
        backGroundView.backgroundColor = [UIColor blackColor];
        backGroundView.alpha = 0.1;
        [self.view addSubview:backGroundView];
        
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"目前你还没有添加车辆到比车队列,\n赶紧前往添加吧！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alterView.delegate = self;
        [alterView show];
    }else{
    
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight-108)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    UIButton *clickBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, KMainScreenHeight-44, KMainScreenWidth-80, 38)];
    [clickBtn setBackgroundImage:[UIImage imageNamed:@"icoBtn@2x"] forState:UIControlStateNormal];
    [clickBtn setTitle:@"开始对比" forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(compareCar) forControlEvents:UIControlEventTouchUpInside];
    [clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:clickBtn];
    
}

-(void)backBtn
{
    [self dismissViewControllerAnimated:NO completion:nil];

}

#pragma mark - UIAlterViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
      
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Compare *compare = [Compare shareInstance];
    return compare.compareArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    Compare *compare = [Compare shareInstance];
    cell.textLabel.text = [compare.compareArr[indexPath.row] name];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
     cell.imageView.image = [UIImage imageNamed:@"radio_nor"];
    cell.tag = 10+indexPath.row;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Compare *compare = [Compare shareInstance];
    
    UITableViewCell *cell = (UITableViewCell *)[self.view viewWithTag:indexPath.row+10];

    if ([self.dataDic allKeys].count >= 2) {
        if ([[self.dataDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
            cell.imageView.image = [UIImage imageNamed:@"radio_nor"];
            [self.dataDic removeObjectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
            NSLog(@">>%ld",[self.dataDic allKeys].count);
            return ;
        }
        
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"添加的比较车辆不能超过两辆,\n如有需要请重新选择!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alterView show];
        
        return;
    }
    
    if ([[self.dataDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
        cell.imageView.image = [UIImage imageNamed:@"radio_nor"];
        [self.dataDic removeObjectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"reviewSure"];
        [self.dataDic setValue:compare.compareArr[indexPath.row] forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
    
        
}

//跳转到比车参数控制器
-(void)compareCar
{
    if ([self.dataDic allKeys].count < 2) {
        
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请选择两款车辆进行比较" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        
        return;
    }
    
    CompareCarViewController *ctl = [[CompareCarViewController alloc]init];
    ctl.dataArr = [NSMutableArray arrayWithArray:[self.dataDic allValues]];
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
