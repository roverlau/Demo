//
//  SelectionController.m
//  qinkeTtavel
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SelectionController.h"
#import <AFNetworking.h>
#import "Masonry.h"
#import "SelectModel.h"
#import "SelectionCell.h"
#import "SelectionTwoCell.h"
#import "SelectShowController.h"
#import "RecommendController.h"

#define GETSELECT  @"http://appsrv.flyxer.com/api/digest/main?did=59911&s2=hdGQc5&qid=0&s1=d0f13494ca02b2b91c130b15d8e080bf&v=4&page=1"


@interface SelectionController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain) UITableView *selectTable;

@property (nonatomic , retain) NSMutableArray *dataArray;

@property (nonatomic , retain) UIActivityIndicatorView *loadAnimo;

@end

@implementation SelectionController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidLoad
{
   
    [super viewDidLoad];
    
    [self obserNet];
    
    [self.view addSubview:self.selectTable];
    
    [_selectTable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(-20);
        make.bottom.mas_equalTo(44);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        
    }];
    
    [self loadAnimoStar];
    
}

-(void)loadAnimoStar
{
    _loadAnimo = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _loadAnimo.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    //        _actView
    _loadAnimo.hidesWhenStopped = YES;
    _loadAnimo.color = [UIColor redColor];
    
    [self.view addSubview:_loadAnimo];
 
    [_loadAnimo startAnimating];
}

-(void)obserNet
{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //网络异常
            
            [_loadAnimo stopAnimating];
        }
        else
        {
            [self getData];
        }
        
    }];
    
}

-(void)getData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:GETSELECT parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        for ( NSDictionary *dic in responseObject[@"recomms"]) {
            SelectModel *model = [SelectModel yy_modelWithJSON:dic];
            
            [_dataArray addObject:model];
        }
        
        
        [_selectTable reloadData];
        [_loadAnimo stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"select数据获取失败");
         [_loadAnimo stopAnimating];
    }];
    
}


#pragma mark -- delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectModel *model = _dataArray[indexPath.row];
    if (model.collections) {
        SelectionCell *cell = [_selectTable dequeueReusableCellWithIdentifier:@"SelectionCell"];
        
        if (!cell) {
            cell = [[SelectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectionCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.model = model;
        
        __weak typeof(self)weakSelf = self;
        [cell setImageBlock:^(NSNumber *numStr) {
            RecommendController *vc = [[RecommendController alloc]init];
            vc.goodId = numStr;
            
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;
    }
    
    else
    {
        SelectionTwoCell *cell = [_selectTable dequeueReusableCellWithIdentifier:@"SelectionTwoCell"];
        
        if (!cell) {
            cell = [[SelectionTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectionTwoCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.model = model;
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectModel *model = _dataArray[indexPath.row];
    if (model.collections) {
        return 250;
    }
    else
    {
      return  [SelectionTwoCell heightWithModel:model];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectModel *model = _dataArray[indexPath.row];
    
    if ([model.type isEqualToString:@"Recomm"]) {
        SelectShowController *vc = [[SelectShowController alloc]init];
        vc.goodId = model.goodId;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark -- setter
-(UITableView *)selectTable
{
    if (!_selectTable) {
        
        _selectTable = [[UITableView alloc]init];
        
        
        _selectTable.backgroundColor = self.view.backgroundColor;
        _selectTable.delegate = self;
        _selectTable.dataSource = self;
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    return _selectTable;
}

@end
