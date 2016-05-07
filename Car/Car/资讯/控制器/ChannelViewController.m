//
//  ChannelViewController.m
//  汽车导购
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ChannelViewController.h"
#import "ChannelCell.h"
#import "ChannelDownCell.h"

@interface ChannelViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//已选频道
@property (nonatomic,strong) NSMutableArray * selectedArr;
//未选频道
@property (nonatomic,strong) NSMutableArray * unSelectedArr;
//已选频道UISCrollView
@property (nonatomic,strong) UICollectionView * upCollectionView;
//未选频道UIScrollView
@property (nonatomic,strong) UICollectionView * downCollectionView;

@end

@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     [self creatUI];
    
     [_upCollectionView registerNib:[UINib nibWithNibName:@"ChannelCell" bundle:nil] forCellWithReuseIdentifier:@"ChannelCell"];
     [_downCollectionView registerNib:[UINib nibWithNibName:@"ChannelDownCell" bundle:nil] forCellWithReuseIdentifier:@"ChannelDownCell"];
    
}

#pragma mark - 创建UI
-(void)creatUI
{
    _unSelectedArr = [[NSMutableArray alloc]init];
    
    NSArray *arr = @[@"最新",@"订阅",@"导购",@"新闻",@"新车",@"优惠",@"试驾",@"图趣",@"视频"];
    _selectedArr = [[NSMutableArray alloc]initWithArray:arr];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
     _upCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 130, KMainScreenWidth, 150) collectionViewLayout:layout];
    _upCollectionView.delegate = self;
    _upCollectionView.dataSource = self;
    
    _upCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_upCollectionView];
    
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 100, 30)];
    lb.textColor = [UIColor redColor];
    lb.text = @"全部频道";
    lb.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:lb];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-60, 30, 30, 30)];
    btn.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 60, 30)];
    lb1.text = @"已选频道";
    lb1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:lb1];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(85, 85, 150, 25)];
    lb2.text = @"点击删除，长按拖动排序";
    lb2.font = [UIFont systemFontOfSize:12];
    lb2.textColor = [UIColor grayColor];
    [self.view addSubview:lb2];
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 120, KMainScreenWidth-20,1)];
    img1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:img1];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-15, KMainScreenHeight-40,30 , 20)];
    [btn1 setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(10,130+_upCollectionView.bounds.size.height, 60,30)];
    lb3.text = @"待选频道";
    lb3.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:lb3];
    
    UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(85, 130+_upCollectionView.bounds.size.height, 60, 30)];
    lb4.text = @"点击添加";
    lb4.textColor = [UIColor grayColor];
    lb4.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:lb4];
    
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 320, KMainScreenWidth-20,1)];
    img2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:img2];
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc]init];
    _downCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 330, KMainScreenWidth, 100) collectionViewLayout:layout1];
    _downCollectionView.delegate = self;
    _downCollectionView.dataSource = self;
    _downCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_downCollectionView];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:_upCollectionView]) {
        return self.selectedArr.count;
    }
    if ([collectionView isEqual:_downCollectionView]) {
        return  self.unSelectedArr.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([collectionView isEqual:_upCollectionView]) {
        ChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChannelCell" forIndexPath:indexPath];
        cell.nameLabel.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1.0];
        cell.nameLabel.text = self.selectedArr[indexPath.row];
    
        return cell;
    }
    if([collectionView isEqual:_downCollectionView]){
        
        ChannelDownCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChannelDownCell" forIndexPath:indexPath];
        if (self.unSelectedArr.count > indexPath.row ) {
            cell1.nameLabel.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1.0];
            cell1.nameLabel.text = self.unSelectedArr[indexPath.row];
        return cell1;
        }
    }
    
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([collectionView isEqual:_upCollectionView]) {
        if (indexPath.row >= 2) {
            [_unSelectedArr addObject:self.selectedArr[indexPath.row]];
              [_selectedArr removeObjectAtIndex:indexPath.row];
        }
    }
    if ([collectionView isEqual:_downCollectionView]) {
        [_selectedArr addObject:self.unSelectedArr[indexPath.row]];
        [_unSelectedArr removeObjectAtIndex:indexPath.row];
    }
    [_upCollectionView reloadData];
    [_downCollectionView reloadData];

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 30);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
    
}

#pragma mark - 点击按钮返回
-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
