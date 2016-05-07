//
//  FoundController.m
//  qinkeTtavel
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FoundController.h"
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "FoundModel.h"
#import "TagsCell.h"
#import "NextStopCell.h"
#import "CollectionCell.h"
#import "CollectionModel.h"
#import "TopSelectCell.h"
#import "FoundHeadScroll.h"
#import "TagsShowController.h"
#import "RecommendController.h"
#import "SelectShowController.h"
#import "NextStopController.h"


#define GETFOUND @"http://appsrv.flyxer.com/api/digest/discovery?s2=DGLLj6&s1=a38cc112c020b55371fa3c742ac91a96&did=59911"

@interface FoundController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain) UITableView *foundTableView;

@property (nonatomic , retain) UIActivityIndicatorView *loadAnimo;

@property (nonatomic , retain) FoundModel *model;

@end


@implementation FoundController



-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.title = @"发现";
    
    [self.view addSubview:self.foundTableView];
    
    [self loadAnimoStar];
    
    [self getData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
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

-(void)getData
{
        NSString *urlStr = [NSString stringWithFormat:GETFOUND];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
//                    NSLog(@"%@",responseObject);
            _model = [FoundModel yy_modelWithJSON:responseObject];
           
            [self addHeadView];
            [_foundTableView reloadData];
            [_loadAnimo stopAnimating];
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //        NSLog(@"select数据获取失败");
            [_loadAnimo stopAnimating];
        }];
}

-(void)addHeadView
{
    FoundHeadScroll *scrollView = [[FoundHeadScroll alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    scrollView.headArray = _model.articles;
    
    _foundTableView.tableHeaderView = scrollView;
}


#pragma mark -- tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        break;
            
        case 1:
            return 1;
        break;
            
        case 2:
            return 3;
        break;
            
        case 3:
            return 5;
        break;
            
            
        default:
            break;
    }
    
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 150;
            break;
            
        case 1:
            return 200;
            break;
            
        case 2:
            return 100;
            break;
            
        case 3:
            return 80;
            break;
            
            
        default:
            break;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.layer.masksToBounds = YES;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [headView addSubview:titleLabel];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    
    NSArray *titleArr = @[@"发现·我的兴趣",@"发现·下一站",@"发现·精选主题",@"发现·一周最热"];
   
    titleLabel.text = titleArr[section];

    
    return headView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TagsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TagsCell"];
        if (!cell) {
            cell = [[TagsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TagsCell"];
            cell.tagArray = _model.tags;
        }
        
        [cell setPushTagBlock:^(NSString *tag,NSString *name) {
            TagsShowController *vc = [[TagsShowController alloc]init];
            vc.goodId = tag;
            vc.name = name;
            
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        NextStopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NextStopCell"];
        if (!cell) {
            cell = [[NextStopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NextStopCell"];
            cell.array = _model.next_stops;
        }
        [cell setPushNextBlock:^(NSNumber *goodId) {
            NextStopController *vc = [[NextStopController alloc]init];
            vc.goodId = goodId;
            
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell"];
        if (!cell) {
            cell = [[CollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionCell"];
        }
        CollectionModel *sonModel = _model.collections[indexPath.row];
        cell.collectionModel = sonModel;
        
        return cell;
    }
    else
    {
        TopSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopSelectCell"];
        
        if (!cell) {
            cell = [[TopSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TopSelectCell"];
        }
        
        TopSelectModel *model = _model.top_selections[indexPath.row];
        cell.topModel = model;
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        CollectionModel *sonModel = _model.collections[indexPath.row];
        
        RecommendController *vc = [[RecommendController alloc]init];
        vc.goodId = sonModel.goodId;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.section == 3)
    {
        TopSelectModel *model = _model.top_selections[indexPath.row];
        TopSelectSonModel *sonModel = model.selection;
        
        
        SelectShowController *vc = [[SelectShowController alloc]init];
        vc.goodId = sonModel.goodId;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark -- getter
-(UITableView *)foundTableView
{
    if (!_foundTableView) {
        
        _foundTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _foundTableView.backgroundColor = self.view.backgroundColor;
        _foundTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _foundTableView.delegate = self;
        _foundTableView.dataSource = self;
        
        
        
    }
    return _foundTableView;
}


@end
