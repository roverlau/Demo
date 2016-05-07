//
//  AboutMeViewController.m
//  汽车导购
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AboutMeViewController.h"
#import "LoginViewController.h"
#import "MyCollectionViewController.h"
#import "MyLableViewController.h"
#import "RecommendAppViewController.h"

@interface AboutMeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //cell中图片名字的集合
    NSArray * _imageNameArr;
    //cell中的标题的集合
    NSArray * _titleArr;
}

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height/5)*2-20)];
    v.backgroundColor = [UIColor colorWithRed:62/256.0 green:63/256.0 blue:62/256.0 alpha:1.0];
    [self.view addSubview:v];

    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, 20, 80, 80)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"head_man"] forState:UIControlStateNormal];
    [v addSubview:btn1];
    [btn1 addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-30, 110, 60, 25)];
    lb.text = @"立即登录";
    lb.font = [UIFont systemFontOfSize:15];
    lb.textColor = [UIColor whiteColor];
    [v addSubview:lb];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-60, 145, 50, 20)];
    lb1.text = @"当前积分";
    lb1.textColor = [UIColor grayColor];
    lb1.font = [UIFont systemFontOfSize:12];
    [v addSubview:lb1];
    
   UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 150, 10, 10)];
    img.image = [UIImage imageNamed:[NSString stringWithFormat:@"ico_goldcoin_gray"]];
    [v addSubview:img];
    
    UILabel * numLb = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2+30, 150, 100, 13)];
    numLb.text = @"0";
    numLb.textColor = [UIColor grayColor];
    numLb.font = [UIFont systemFontOfSize:14];
    [v addSubview:numLb];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, 180, 80, 20)];
    [btn setBackgroundImage:[UIImage imageNamed:@"icoBtn"] forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:[NSString stringWithFormat:@"签到"] forState:
     UIControlStateNormal];
    btn.font = [UIFont systemFontOfSize:15];
    [v addSubview:btn];
    [btn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
       
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height/5)*2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    _imageNameArr = @[@"profiles_ico_msg",@"profiles_ico_heart",@"profiles_ico_lable",@"profiles_ico_app",@"profiles_ico_cart",@"profiles_ico_setting"];
    _titleArr = @[@"我的消息",@"我的收藏",@"我订阅的标签",@"推荐安装",@"积分商城",@"设置"];
    
}

#pragma mark - 点击头像和签到产生的事件
-(void)loginAction
{
    LoginViewController *ctl = [[LoginViewController alloc]init];
    
    [self presentViewController:ctl animated:NO completion:nil];

}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellName";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@",_titleArr[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_imageNameArr[indexPath.row]]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        MyCollectionViewController *ctl = [[MyCollectionViewController alloc]init];
        [self presentViewController:ctl animated:NO completion:nil];
    }
    if (indexPath.row ==2) {
        MyLableViewController *ctl = [[MyLableViewController alloc]init];
        [self presentViewController:ctl animated:NO completion:nil];
    }
    if (indexPath.row == 3) {
        RecommendAppViewController *ctl = [[RecommendAppViewController alloc]init];
        [self presentViewController:ctl animated:NO completion:nil];
    }

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
