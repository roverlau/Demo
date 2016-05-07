//
//  BournController.m
//  qinkeTtavel
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BournController.h"
#import "MddViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYModel.h"
#import "MddCollectionViewCell.h"
#import "MddXqCollectionViewController.h"
#import "MddModel.h"

#define Jo_url @"http://appsrv.flyxer.com/api/digest/recomm/dests"
#define Jo_info @"http://appsrv.flyxer.com/api/digest/recomm/dest/"

@interface BournController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) NSMutableArray *dataArr;

@property (nonatomic , retain) UIScrollView *bournScrollView;

@property (nonatomic , retain) UIActivityIndicatorView *loadAnimo;

@end

@implementation BournController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-108) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
    }
    
    
    
    return _collectionView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
   
   [self loadAnimoStar];
    [self getData];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MddCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:Jo_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dic in responseObject) {
            MddModel * model = [MddModel yy_modelWithJSON:dic];
            [self.dataArr addObject:model];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
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

#pragma mark -dataSoure
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.dataArr.count/2;
//}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    MddModel *model = self.dataArr[indexPath.row];
    
    [cell initUI:model];
    return cell;
    
}
//返回多少个
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.view.frame.size.width-20)/2, (self.view.frame.size.width-20)/2-50);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MddModel *model = self.dataArr[indexPath.row];
    MddXqCollectionViewController *mddXq = [MddXqCollectionViewController new];
    mddXq.url = model.bg_pic;
    mddXq.cityId = model.ID;
    mddXq.desc = model.desc;
//    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:mddXq animated:YES];
}

@end
