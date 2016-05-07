//
//  FUnViewController.m
//  qinkeTtavel
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FUnViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYModel.h"
#import "FunModel.h"
#import "ShowTableViewCell.h"
#import "SelectShowController.h"
#import "MyView.h"

#define Jo_FunUrl @"http://appsrv.flyxer.com/api/digest/recomm/dest/%@?s2=JkTOor&s1=aab2bb2fd12b870a99c31a740ba5be3c&v=3&page=1"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface FUnViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic)UIScrollView *scrollView;
@property(nonatomic)UITableView *tableView;
@property(nonatomic)NSMutableArray *dataArrO;
@property(nonatomic)NSMutableArray *dataArrT;
@property(nonatomic)NSMutableArray *dataArrS;


@end

@implementation FUnViewController

-(NSMutableArray *)dataArrO{
    if (!_dataArrO) {
        _dataArrO = [NSMutableArray new];
        _dataArrT = [NSMutableArray new];
        _dataArrS = [NSMutableArray new];
    }
    return _dataArrO;
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:@"ShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2);
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        MyView *view = [[[NSBundle mainBundle]loadNibNamed:@"MyView" owner:self options:nil] lastObject];
        view.frame = CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT);
        [view initUI:self.picUrl :self.name:self.contant];
        [_scrollView addSubview:view];
        
        [_scrollView addSubview:self.tableView];
        
    }
    
    return _scrollView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self requestNet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)requestNet{
    NSString *sUrl = [NSString stringWithFormat:Jo_FunUrl,self.HId];
    AFHTTPRequestOperationManager * rq = [AFHTTPRequestOperationManager manager];
    
    [rq GET:sUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dic in responseObject) {
             FunModel *model= [FunModel new];
            if ([dic[@"group"] isEqualToString:@"热门景点"]) {
                model = [FunModel yy_modelWithJSON:dic];
                [self.dataArrO addObject:model];
            }else if([dic[@"group"] isEqualToString:@"热门体验"]){
            
                model = [FunModel yy_modelWithJSON:dic];
                [self.dataArrT addObject:model];
            
            }else{
                model = [FunModel yy_modelWithJSON:dic];
                [self.dataArrS addObject:model];
            }
        
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
    }];
}


#pragma mark -tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.dataArrO.count;
    }
    if (section==1) {
        return self.dataArrT.count;
    }
    return self.dataArrS.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowTableViewCell *fc = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    FunModel *model = [FunModel new];
    if (indexPath.section ==0) {
        model = self.dataArrO[indexPath.row];
    }else if(indexPath.section ==1){
        model = self.dataArrT[indexPath.row];
    }else{
        model = self.dataArrS[indexPath.row];
    }
    [fc initUI:model];
    return fc;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"热门景点";
    }if (section==1) {
        return @"热门体验";
    }
    return @"周边精选";
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FunModel *model = [FunModel new];
    if (indexPath.section ==0) {
        model = self.dataArrO[indexPath.row];
    }else if(indexPath.section ==1){
        model = self.dataArrT[indexPath.row];
    }else{
        model = self.dataArrS[indexPath.row];
    }
    SelectShowController *vc = [[SelectShowController alloc]init];
    vc.goodId = model.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
