//
//  RecommendController.m
//  qinkeTtavel
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommendController.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "LIstModel.h"
#import "ListCollectionCell.h"
#import "ListSonModel.h"
#import "UIImage+ZQCorp.h"
#import "SelectShowController.h"

#define GETLISTRECOMMEND @"http://appsrv.flyxer.com/api/digest/collection/%@?s2=g9sSR1&s1=a4d5434bcace3ee7b179636e006d82f4&v=3&page=1"

@interface RecommendController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic , retain) LIstModel *model;

@property (nonatomic , retain) UITableView *recommendTabel;

@property (nonatomic , retain) UICollectionView *listCollectionView;

@property (nonatomic , retain) UIActivityIndicatorView *loadAnimo;

@property (nonatomic , retain) NSArray *dataArray;

@property (nonatomic , retain) UIImageView *imageV;

@end

@implementation RecommendController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadAnimoStar];
    
    [self obserNet];
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
    NSString *urlStr = [NSString stringWithFormat:GETLISTRECOMMEND,_goodId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        NSLog(@"%@",responseObject);
         _model = [LIstModel yy_modelWithJSON:responseObject];
        
        [self.view addSubview:self.listCollectionView];
        
       
        _dataArray = _model.recomms;
        
        [_loadAnimo stopAnimating];
        
        [_listCollectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        NSLog(@"select数据获取失败");
        [_loadAnimo stopAnimating];
    }];
}

#pragma mark -- collectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCollectionCell *cell = [_listCollectionView dequeueReusableCellWithReuseIdentifier:@"ListCollectionCell" forIndexPath:indexPath];
    
    ListSonModel *model = _dataArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    ListSonModel *model = _dataArray[indexPath.row];
    
    return [ListCollectionCell SizeWithModel:model];
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        
        head.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLbabel = [[UILabel alloc]init];
        titleLbabel.font = [UIFont boldSystemFontOfSize:20];
        titleLbabel.textColor = [UIColor grayColor];
        titleLbabel.text = _model.title;
        titleLbabel.backgroundColor = head.backgroundColor;
        titleLbabel.layer.masksToBounds = YES;
        
        [head addSubview:titleLbabel];
        
        [titleLbabel  mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(40);
            make.centerX.mas_equalTo(head);
            
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor grayColor];
        [head addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.mas_equalTo(titleLbabel.mas_bottom).offset(20);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(1);
            
        }];
        
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:head.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = head.bounds;
        maskLayer.path = path.CGPath;
        head.layer.mask = maskLayer;
        
        
        return head;
    }
    else
    {
        return 0;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListSonModel *model = _dataArray[indexPath.row];
    
    SelectShowController *vc = [[SelectShowController alloc]init];
    
    vc.goodId = model.goodId;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- gettet
-(UICollectionView *)listCollectionView
{
    if (!_listCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
       
        
        _listCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        _listCollectionView.backgroundColor = [UIColor whiteColor];
        
        _listCollectionView.delegate = self;
        _listCollectionView.dataSource = self;
        
        [_listCollectionView registerClass:[ListCollectionCell class] forCellWithReuseIdentifier:@"ListCollectionCell"];
        [_listCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        
        _listCollectionView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
        
        
//        _listCollectionView.pagingEnabled = YES;
        
        
        
        
        [self addHeadImageV];
        
    }
    return _listCollectionView;
}



-(void)addHeadImageV
{
    _imageV = [[UIImageView alloc]init];
    
    SDWebImageManager *manage = [SDWebImageManager sharedManager];
    
    [manage downloadImageWithURL:_model.bg_pic[0] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        _imageV.image = [image zq_cropEqyalScaleImageToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 250)];
        
    }];
    
    
    _listCollectionView.backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    [_listCollectionView.backgroundView addSubview:_imageV];
    
    
//    [_imageV mas_updateConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
//        
//        make.height.mas_equalTo(250).priorityHigh();
//        
//        make.height.lessThanOrEqualTo(@300);
//        make.height.greaterThanOrEqualTo(@0);
//        
//    }];
    [self setheadImageVAnimoteWith:250];
}

-(void)setheadImageVAnimoteWith:(float)height
{
    [_imageV layoutIfNeeded];
    [_imageV setNeedsLayout];
    [_imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(height/5 - 50);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo(250).priorityHigh();
        
        make.height.lessThanOrEqualTo(@300);
        make.height.greaterThanOrEqualTo(@0);
    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float y = scrollView.contentOffset.y;
        [self setheadImageVAnimoteWith:-y+50];

//    NSLog(@"%f",y);
    if ( y < -250) {
        scrollView.contentOffset = CGPointMake(0, -250);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (y < 0) {
         self.title = @"";
        }
        else
        {
        self.title = _model.title;
        }
    });
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
}



@end
