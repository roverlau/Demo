//
//  HotViewController.m
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "HotViewController.h"
#import "HomeModel.h"
#import "AFNetworking.h"
#import "HotCollectionViewCell.h"
#import "HotShowViewController.h"

#define URL_HOT @"http://api.liwushuo.com/v2/item_channels/1/items?offset=%ld&limit=20&generation=2&gender=1&_=635815091543602479"

@interface HotViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UICollectionView *coll;
@end

@implementation HotViewController

-(UICollectionView *)coll{
    if (!_coll) {
        //UICollectionViewFlowLayout
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _coll = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];

        _coll.delegate = self;
        _coll.dataSource = self;
        _coll.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_coll];
    }
    return _coll;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    [self.coll registerNib:[UINib nibWithNibName:@"HotCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self requestNet];
    
    self.coll.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [self.dataArr removeAllObjects];
        [self performSelector:@selector(ending) withObject:nil afterDelay:1.0f];
        [self requestNet];
    }];
    self.coll.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page+=20;
        [self performSelector:@selector(ending) withObject:nil afterDelay:1.0f];
        [self requestNet];
    } ];
    
}
-(void)ending{
    if (self.coll.header.isRefreshing) {
        //如果下拉控件处于刷新状态 则结束刷新
        [self.coll.header endRefreshing];
    }else if (self.coll.footer.isRefreshing) {
        [self.coll.footer endRefreshing];
    }
}

#pragma mark - 网络请求
-(void)requestNet{
    NSString *str = [NSString stringWithFormat:URL_HOT,self.page];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"OK"]) {
            for (NSDictionary *dic in responseObject[@"data"][@"items"]) {
                HotModel *model = [HotModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArr addObject:model];
            }
            [self.coll reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width - 20)/2, 190);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HotShowViewController *hs = [HotShowViewController new];
    HotModel *model =self.dataArr[indexPath.row];
    hs.info = model.url;
    [self.navigationController pushViewController:hs animated:YES];
    
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
