//
//  FindCarViewController.m
//  Car
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FindCarViewController.h"
#import "AFNetworking.h"
#import "CarModel.h"
#import "NameModel.h"
#import "UIButton+WebCache.h"
#import "CarCell.h"
#import "CarCatCell.h"
#import "CarCatModel.h"
#import "CarCatBrandModel.h"
#import "CarSeriesViewController.h"
#import "MapViewController.h"
#import "Compare.h"
#import "CompareViewController.h"



@interface FindCarViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *  brandArr;
@property (nonatomic,strong) NSMutableArray * dataArr;
//点击cell出现在上面的视图
@property (nonatomic,strong) UIView *v;

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) NSMutableArray * myBrandArr;

@property (nonatomic,strong) UIButton * compareBtn;

@end

@implementation FindCarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self requestData];
    
  
}

-(void)initData
{
    _brandArr = [NSMutableArray new];
    _dataArr = [NSMutableArray new];
    
}

-(void)createUI
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, 44)];
    [self.view addSubview:titleView];
    UIButton *myBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 15, 70, 25)];
    [myBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    myBtn.font = [UIFont systemFontOfSize:15];
    [myBtn setTitle:@"我的位置" forState:UIControlStateNormal];
    [myBtn addTarget:self action:@selector(jumpToMap) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:myBtn];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2 - 30, 10, 60, 30)];
    titleLabel.text = @"车型库";
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [titleView addSubview:titleLabel];
    _compareBtn = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-70, 15, 70, 25)];
    [_compareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _compareBtn.font = [UIFont systemFontOfSize:15];
    
    Compare *compare = [Compare shareInstance];
    
    NSString *str = [NSString stringWithFormat:@"%ld",compare.compareArr.count];
    [_compareBtn setTitle:[NSString stringWithFormat:@"比较(%@)",str] forState:UIControlStateNormal];
    [titleView addSubview:_compareBtn];
    [_compareBtn addTarget:self action:@selector(compareCarClick) forControlEvents:UIControlEventTouchUpInside];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, KMainScreenWidth, KMainScreenHeight-104) style:UITableViewStylePlain];
    
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[CarCell class] forCellReuseIdentifier:@"cell"];
    
    //接收通知  刷新UI
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNot) name:@"RefreshUI" object:nil];
}


-(void)receiveNot
{
    Compare *compare = [Compare shareInstance];
    NSString *str = [NSString stringWithFormat:@"%ld",compare.compareArr.count];
    [_compareBtn setTitle:[NSString stringWithFormat:@"比较(%@)",str] forState:UIControlStateNormal];
}


-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:BRAND_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dic in responseObject[@"result"]) {
            CarModel *m = [CarModel new];
            [m setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:m];
        }
        for (NSInteger i = 'A'; i <= 'Z'; i++) {
            NameModel *big = [NameModel new];
            char  ch = i;
            big.name = [NSString stringWithFormat:@"%c",ch];
            for (CarModel *m in self.dataArr) {
                if ([m.ename isEqualToString:big.name] ) {
                    
                    [big.nameArr addObject:m];
                }
            }
            if (big.nameArr.count > 0) {
                [self.brandArr addObject:big];
            }
         }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark - UITableViewDelegate
//返回组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _brandArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_brandArr[section] nameArr]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[CarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    CarModel * model = [self.brandArr[indexPath.section] nameArr][indexPath.row];
       cell.nameLabel.text = model.name;
    [cell.imgButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img]] forState:UIControlStateNormal];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%@",[_brandArr[section] name]];

}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 'A'; i <= 'Z'; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%c",i]];
    }
    return arr;
    
}

//点击cell时产生的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view bringSubviewToFront:_v];
    CarModel *model = [self.brandArr[indexPath.section] nameArr][indexPath.row];
    NSString *str = model.myId;
    [self initUI];
    [self requestNetData:str];
}

//创建上层视图的UI
-(void)initUI
{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, KMainScreenHeight)];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.1;
    [self.view addSubview:_backView];
     _v = [[UIView alloc]initWithFrame:CGRectMake(70, 20, KMainScreenWidth-70, KMainScreenHeight)];
    [self.view addSubview:_v];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
     _smallCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,KMainScreenWidth-70, KMainScreenHeight-64) collectionViewLayout:layout];
    _smallCollectionView.backgroundColor = [UIColor whiteColor];
    _smallCollectionView.delegate = self;
    _smallCollectionView.dataSource = self;
    [_v addSubview:_smallCollectionView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_v addGestureRecognizer:panGesture];
    
    [_smallCollectionView registerClass:[CarCatCell class] forCellWithReuseIdentifier:@"cell1"];

}

-(void)pan:(UIPanGestureRecognizer *)panGesture
{
    //手势刚开始的作用点 和目前手指移动位置点之间的偏移量
    CGPoint point = [panGesture translationInView:panGesture.view];
    CGRect rect = panGesture.view.frame;
    
    //NSLog(@"%f",point.x);
    if (point.x >= 0) {
         rect.origin.x += point.x;
    panGesture.view.frame = rect;
    }
    if (point.x >= KMainScreenWidth-100) {
        [_v removeFromSuperview];
    }
    [_backView removeFromSuperview];
    // point 会变为移动前后坐标的偏移量   如果不写那么它的偏移量比较点始终是手势刚刚开始作用的位置
    //[panGesture setTranslation:CGPointZero inView:panGesture.view];
}

-(void)requestNetData:(NSString *)myId
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:BRAND_CAR_URL parameters:@{@"pbid":[NSString stringWithFormat:@"%@",myId]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _myBrandArr = [NSMutableArray new];

         for (NSDictionary *dic in responseObject[@"result"]) {
            CarCatModel * cC = [[CarCatModel alloc]init];
            [cC setValuesForKeysWithDictionary:dic];
            [_myBrandArr addObject:cC];
        }
        [_smallCollectionView reloadData];
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.myBrandArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarCatCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
     cell.backgroundColor = [UIColor colorWithRed:230/256.0 green:234/256.0 blue:229/256.0 alpha:1.0];
    [cell refreshUI:self.myBrandArr[indexPath.row]];
    return cell;

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KMainScreenWidth-70, 70);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

#pragma mark - 点击车型cell跳转到车系详情
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarSeriesViewController *ctl = [[CarSeriesViewController alloc]init];
    
    ctl.userId = [self.myBrandArr[indexPath.row] pserid];
    ctl.price = [self.myBrandArr[indexPath.row] price];
    ctl.name = [self.myBrandArr[indexPath.row] name];
    [self presentViewController:ctl animated:NO completion:nil];

}

#pragma mark - 跳转到地图界面
-(void)jumpToMap
{
    MapViewController *ctl = [[MapViewController alloc]init];
    [self presentViewController:ctl animated:NO completion:nil];
}

#pragma mark - 跳转到比车列表
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
