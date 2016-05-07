//
//  BeauViewController.m
//  猿生活
//
//  Created by RoverLau on 15/11/4.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "BeauViewController.h"
#import "PrefixHeader.pch"
#import "BuModel.h"
#import "MyCollectionViewCell.h"
#import "ShowViewController.h"


@interface BeauViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *dataArrId;
@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation BeauViewController

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
    
}

-(NSMutableArray *)dataArrId{
    if (!_dataArrId) {
        _dataArrId = [NSMutableArray new];
    }
    return _dataArrId;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self requestNet];
}
/*
-(void)UI{
    static BOOL flag = YES;
    for (int i = 0; i < 12 ; i ++) {
        if (i==4|i==5|i==7|i==8) {
            if (flag) {
                UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)/3, ([UIScreen mainScreen].bounds.size.height-64)/4, ([UIScreen mainScreen].bounds.size.width)/3*2, ([UIScreen mainScreen].bounds.size.height-64)/2)];
                [img addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClick:)]];
                [self.view addSubview:img];
                img.userInteractionEnabled = YES;
                
                NSLog(@"------%@",NSStringFromCGSize(img.frame.size));
                
                img.backgroundColor = [UIColor orangeColor];
                flag = NO;
            }
        }else{
            
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i%3*([UIScreen mainScreen].bounds.size.width)/3, i/3*([UIScreen mainScreen].bounds.size.height-64)/4, ([UIScreen mainScreen].bounds.size.width)/3, ([UIScreen mainScreen].bounds.size.height-64)/4)];
            [img addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClick:)]];
            [self.view addSubview:img];
            img.backgroundColor = [UIColor redColor];
            img.userInteractionEnabled = YES;
            NSLog(@"++++%@",NSStringFromCGSize(img.frame.size));
        }
    }

}

-(void)imgClick:(UITapGestureRecognizer*)tap{
    NSLog(@"=");
}
*/
#pragma mark -
-(void)requestNet{
    AFHTTPRequestOperationManager *manager =[ AFHTTPRequestOperationManager manager];
    [manager GET:URL_beau parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"Beauties"]) {
            [self.dataArrId addObject:dic[@"Id"]];
            for (NSDictionary *beau in dic[@"Beauty"]) {
                BuModel *model = [BuModel new];
                [model setValuesForKeysWithDictionary:beau];
                [self.dataArr addObject:model];
            }
        }
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma  mark - 
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    BuModel *model = self.dataArr[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.m_url]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/3-8, self.view.frame.size.height/4);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    ShowViewController *show = [ShowViewController new];
    BuModel *model = self.dataArr[indexPath.row];
    
    if (model.raw_url==nil) {
        show.imgUrl = model.url;
    }else{
    show.imgUrl = model.raw_url;
    }
    show.page = indexPath.row;
    show.dataArr = self.dataArr;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:show animated:NO];

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
