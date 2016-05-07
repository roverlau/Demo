//
//  MddXqCollectionViewController.m
//  qinkeTtavel
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MddXqCollectionViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYModel.h"
#import "MddModel.h"
#import "CityModel.h"
#import "ACollectionViewCell.h"
#import "BCollectionViewCell.h"
#import "HCollectionReusableView.h"
#import "SelectShowController.h"
#import "FUnViewController.h"


#define Jo_mmUrl @"http://appsrv.flyxer.com/api/digest/recomm/dest/%@/cities"

@interface MddXqCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property(nonatomic)UIView *myView;
@property(nonatomic)NSMutableArray *dataArr;
@property(nonatomic)NSMutableArray *cityArr;
@property(nonatomic)UICollectionView *collectionView;
@property (nonatomic , retain) UIScrollView *bournScrollView;


@property (nonatomic , retain) UIActivityIndicatorView *loadAnimo;

@end

@implementation MddXqCollectionViewController

static NSString * const reuseIdentifierA = @"CellA";
static NSString * const reuseIdentifierB = @"CellB";
static NSString * const reuseIdentifierHeader = @"header";

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
#pragma mark - collectionView
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.headerReferenceSize = CGSizeMake(100, 22);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
     [self loadAnimoStar];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    
    //导航栏透明化
   self.navigationController.navigationBar.hidden = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ACollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifierA];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifierB];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HCollectionReusableView" bundle:nil] forCellWithReuseIdentifier:reuseIdentifierHeader];
    [self requestNet];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

-(void)loadAnimoStar
{
    _loadAnimo = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _loadAnimo.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    _loadAnimo.hidesWhenStopped = YES;
    _loadAnimo.color = [UIColor redColor];
    
    [self.view addSubview:_loadAnimo];
    
    [_loadAnimo startAnimating];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
        if (scrollView.contentOffset.y > 100) {
            self.navigationController.navigationBar.hidden = NO;
            
        }
        else
        {
            //            scrollView.zoomBouncing
            self.navigationController.navigationBar.hidden = YES;
          
    }
}



#pragma mark -- getter



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
        
        
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
#pragma mark -
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.frame.size.width, 30);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==1) {
        return self.dataArr.count;
    }else if(section==0){
        return 1;
    }
    return self.cityArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==1) {
        ACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierA forIndexPath:indexPath];
        MddModel *model = self.dataArr[indexPath.row];
        [cell initUI:model];
        return cell;
    }
    
    if (indexPath.section==0) {
        HCollectionReusableView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        [cell initUI:self.url name:self.desc];
        return cell;
    }
    
    BCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierB forIndexPath:indexPath];
    
    CityModel *model = self.cityArr[indexPath.row];
    [cell initUI:model];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

#pragma mark - 单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return CGSizeMake((self.view.frame.size.width-20)/2, 90);
    }
    
    if (indexPath.section==0) {
        return CGSizeMake(self.view.frame.size.width, 200);
    }
    
    
    return CGSizeMake(self.view.frame.size.width, 80);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        
        CityModel *model = self.cityArr[indexPath.row];
        SelectShowController *vc = [[SelectShowController alloc]init];
        vc.goodId = model.ID;

        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section==1) {
        FUnViewController *fc = [FUnViewController new];
        MddModel *model = self.dataArr[indexPath.row];
        fc.name = model.name;
        fc.picUrl = model.bg_pic;
        fc.HId = model.ID;
        fc.contant = model.desc;
        [self.navigationController pushViewController:fc animated:YES];
       
    }
}


@end
