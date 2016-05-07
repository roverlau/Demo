//
//  MddViewController.m
//  qinkeTtavel
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MddViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYModel.h"
#import "MddModel.h"
#import "CityModel.h"
#import "ACollectionViewCell.h"
#import "BCollectionViewCell.h"

#define Jo_mmUrl @"http://appsrv.flyxer.com/api/digest/recomm/dest/%@/cities"

@interface MddViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic)UIView *myView;
@property(nonatomic)NSMutableArray *dataArr;
@property(nonatomic)NSMutableArray *cityArr;

@property (nonatomic , retain) UIScrollView *bournScrollView;

@property (nonatomic , retain) UIActivityIndicatorView *loadAnimo;
@end

@implementation MddViewController
static NSString * const reuseIdentifierA = @"CellA";
static NSString * const reuseIdentifierB = @"CellB";
static NSString * const reuseIdentifierHeader = @"CellHeader";

#pragma mark - 懒加载-热门城市
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
#pragma mark - 懒加载-热门产品
-(NSMutableArray *)cityArr{
    if (!_cityArr) {
        _cityArr = [NSMutableArray new];
    }
    return _cityArr;
}
#pragma mark - tableView
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
    }
    
    
    
    return _tableView;
}
#pragma mark -头部视图
-(UIView *)myView{
    if (!_myView) {
        _myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        
        UILabel *lab = [UILabel new];
        lab.numberOfLines = 0;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:_myView.frame];
        [imgView sd_setImageWithURL:[NSURL URLWithString:_url]];
        [imgView addSubview:lab];
        [_myView addSubview:imgView];
        lab.font = [UIFont systemFontOfSize:14];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView).with.offset(10);
            make.bottom.equalTo(imgView).with.offset(0);
            make.right.equalTo(imgView).with.offset(10);
            make.height.mas_equalTo(@50);
        }];
        [lab setTranslatesAutoresizingMaskIntoConstraints:NO];
        //        lab setTranslatesAutoresizingMaskIntoConstraints
        lab.text = self.desc;
    }
    return _myView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableHeaderView = self.myView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifierA];
    
    [self requestNet];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - requestNet
-(void)requestNet{
    NSString *sUrl = [NSString stringWithFormat:Jo_mmUrl,self.cityId];
    AFHTTPRequestOperationManager * rq = [AFHTTPRequestOperationManager manager];
    
    [rq GET:sUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"cities"]) {
            
            MddModel *mModel = [MddModel yy_modelWithJSON:dic];
            [self.dataArr addObject:mModel];
        }
        for (NSDictionary *dic in responseObject[@"hot_recomm"]) {
            
            CityModel *cModel = [CityModel yy_modelWithJSON:dic];
            [self.cityArr addObject:cModel];
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataArr.count;
    }
    return self.cityArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierA];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld----%ld",indexPath.section,indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100;
    
}

#pragma mark -- getter
-(UIScrollView *)bournScrollView
{
    if (!_bournScrollView) {
        
        _bournScrollView = [[UIScrollView alloc]init];
        _bournScrollView.backgroundColor = self.view.backgroundColor;
        
        
        
    }
    return _bournScrollView;
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


@end
