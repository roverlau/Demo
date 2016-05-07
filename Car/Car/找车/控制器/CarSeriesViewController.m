//
//  CarSeriesViewController.m
//  Car
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CarSeriesViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "ImageModel.h"
#import "BigJSONModel.h"
#import "CarTypeModel.h"
#import "DetailCarCell.h"
#import "ParameterViewController.h"
#import "ImageViewController.h"
#import "MyHeaderView.h"
#import "AppDelegate.h"
#import "Compare.h"
#import "CompareViewController.h"

@interface CarSeriesViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) NSMutableArray * listArr;
@property (nonatomic,strong) NSMutableArray * imgArr;

@property (nonatomic,strong) UIButton *compareBtn;

@property (nonatomic,strong) UIView *backView;

@end

@implementation CarSeriesViewController
-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

-(NSMutableArray *)listArr
{
    if (_listArr == nil) {
        _listArr = [[NSMutableArray alloc]init];
    }
    return _listArr;
}

-(NSMutableArray *)imgArr
{
    if (_imgArr == nil) {
        _imgArr = [[NSMutableArray alloc]init];
    }
    return _imgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self requestData];
}

-(void)createUI
{
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, 44)];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-40, 5, 80, 30)];
    title.text = @"车系信息";
    title.textColor = [UIColor redColor];
    [v addSubview:title];
    [self.view addSubview:v];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(8, 5, 20, 30)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];

    _compareBtn = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-70, 15, 70, 25)];
    [_compareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _compareBtn.font = [UIFont systemFontOfSize:15];
    [_compareBtn addTarget:self action:@selector(compareCarClick) forControlEvents:UIControlEventTouchUpInside];
    Compare *compare = [Compare shareInstance];
    
    NSString *str = [NSString stringWithFormat:@"%ld",compare.compareArr.count];
    [_compareBtn setTitle:[NSString stringWithFormat:@"比较(%@)",str] forState:UIControlStateNormal];
    [v addSubview:_compareBtn];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[DetailCarCell class] forCellReuseIdentifier:@"cell"];
    
}

-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:CAR_SERIES_URL parameters:@{@"pserid":_userId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BigJSONModel * big = [[BigJSONModel alloc]initWithDictionary:responseObject[@"result"] error:nil];
         [self.dataArr addObject:big];
        for (NSDictionary *dic in responseObject[@"result"][@"carlist"]) {
            CarTypeModel *model = [[CarTypeModel alloc]initWithDictionary:dic error:nil];
            [self.listArr addObject:model];
        }
        
        for (NSDictionary *dic in responseObject[@"result"][@"img_list"]) {
            ImageModel *model = [[ImageModel alloc]initWithDictionary:dic error:nil];
            [self.imgArr addObject:model];
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}


#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[DetailCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.nameLabel.text = [self.listArr[indexPath.row] name];
    cell.btn.tag = indexPath.row;
    [cell.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 270;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    MyHeaderView * v = [[MyHeaderView alloc]init];
     if (self.dataArr.count != 0)
    {
        [v.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",((BigJSONModel*)self.dataArr[0]).topimg]] placeholderImage:[UIImage imageNamed:@"load_s"]];
        
        if (((BigJSONModel*)self.dataArr[0]).img_count != 0) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myTap:)];
        v.img.userInteractionEnabled = YES;
        [v.img addGestureRecognizer:tap];
        
        v.lb4.text = [NSString stringWithFormat:@"共%@张图",((BigJSONModel*)self.dataArr[0]).img_count];
        }
        
    }
     v.lb1.text = _name;
    if ([_price isEqualToString:@""]) {
        v.lb3.text = @"无";
    }else{
        v.lb3.text = _price;
    }

    _tableView.tableHeaderView = v;
    return v;
    
}

//点击cell上面的button，将车辆加入比车
-(void)click:(UIButton *)btn
{
    Compare *compare = [Compare shareInstance];
    //判断是否被点击过
    if (btn.selected) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, KMainScreenHeight)];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.08;
        [self.view addSubview:_backView];
        
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你已添加过不能重复添加" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alterView.delegate = self;
        [alterView show];
        
    }else{
        [btn setImage:[UIImage imageNamed:@"btn_added_nor"] forState:UIControlStateNormal];
        [compare.compareArr addObject:self.listArr[btn.tag]];

    }
    btn.selected = YES;
     NSString *str = [NSString stringWithFormat:@"%ld",compare.compareArr.count];
    [_compareBtn setTitle:[NSString stringWithFormat:@"比较(%@)",str] forState:UIControlStateNormal];
    //发出通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshUI" object:nil];
}

#pragma mark - UIAlterViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_backView removeFromSuperview];

}

//点击图片跳转到图片下载界面
-(void)myTap:(UITapGestureRecognizer *)tap
{
    if (_imgArr.count > 0) {
        ImageViewController *ctl = [[ImageViewController alloc]init];
        ctl.name = _name;
        ctl.imageArr = _imgArr;
        [self presentViewController:ctl animated:NO completion:nil];
    }
    
}

//点击cell跳转到汽车参数详情界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParameterViewController *ctl = [[ParameterViewController alloc]init];
    
    ctl.mid = [self.listArr[indexPath.row] mid];
    [self presentViewController:ctl animated:YES completion:nil];
}

//返回到上一界面
-(void)backBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//跳转到比较界面
-(void)compareCarClick
{
    CompareViewController *ctl = [[CompareViewController alloc]init];
    Compare *compare = [Compare shareInstance];
    ctl.num = [NSString stringWithFormat:@"%ld",compare.compareArr.count];
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
