//
//  FLViewController.m
//  礼物说
//
//  Created by RoverLau on 15/10/28.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "FLViewController.h"
#import "FLCollectionViewCell.h"
#import "GroupModel.h"
#import "ItemModel.h"
#import "HeadCRView.h"
#import "FLXQViewController.h"

#define URL @"http://api.daogou.bjzzcb.com/m/spider/pserisel/?pbid=2"

@interface FLViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collection;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation FLViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collection];
    }
    return _collection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    [self requestNet];
    
    
    
     [self.collection registerNib:[UINib nibWithNibName:@"FLCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.collection registerNib:[UINib nibWithNibName:@"HeadCRView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadCVR"];
    
}

-(void)requestNet{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL_FL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if ([responseObject[@"message"] isEqualToString:@"OK"]) {
            for (NSDictionary *dic in responseObject[@"data"][@"channel_groups"]) {
                GroupModel *model = [GroupModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArr addObject:model];
            }
         }
       [self.collection reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.dataArr.count==0) {
        return 0;
    }
    GroupModel *model = self.dataArr[section];
    
    return model.kinds.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FLCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    GroupModel *model = self.dataArr[indexPath.section];
    [cell refreshUI:model.kinds[indexPath.row]];
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.frame.size.width, 30);
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        HeadCRView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeadCVR" forIndexPath:indexPath];
    
    GroupModel *model = self.dataArr[indexPath.section];
    header.name.text = model.name;
        return header;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width-50)/4, 100);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GroupModel *model = self.dataArr[indexPath.section];
    ItemModel *mod = model.kinds[indexPath.row];
    NSString *str = [NSString stringWithFormat:URL_FL_K,mod.myId];
    FLXQViewController *jc = [FLXQViewController new];
    jc.url = str;
    [self.navigationController pushViewController:jc animated:YES];
    
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
