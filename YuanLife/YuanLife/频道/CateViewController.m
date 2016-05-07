//
//  CateViewController.m
//  猿生活
//
//  Created by RoverLau on 15/11/4.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "CateViewController.h"
#import "PrefixHeader.pch"
#import "MessageViewController.h"
#import "InfoViewController.h"
#import "HomeModel.h"
#import "TableViewCell.h"
#import "NewsViewController.h"

@interface CateViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

@property (nonatomic,strong)UITableView *tableView;
//@property (nonatomic,strong)UITableView *tableView2;
@property (nonatomic,assign)BOOL flag;
@property (nonatomic,strong)UIView *vi;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *moreUrl;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign)NSInteger page;

@end

@implementation CateViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


-(UIView *)vi{
    if (!_vi) {
        _vi = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 100, self.view.frame.size.height-64)];
        [self.view addSubview:_vi];
//        _vi.backgroundColor = [UIColor orangeColor];
    }
    return _vi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = YES;
    self.url =URL_keji;
    [self creatUI];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(share)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self requestNet];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArr removeAllObjects];
        [self requestNet];
        [self performSelector:@selector(ending) withObject:nil afterDelay:1.0f];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestNetMore];
        self.page-=15;
        [self performSelector:@selector(ending) withObject:nil afterDelay:1.0f];
    }];
}
/**
 *  分享
 */
-(void)share{

   [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5636c18467e58e18e0000796" shareText:@"原生活、分享你的生活,www.www.www" shareImage:nil shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToLWSession,UMShareToSms] delegate:self];
    
}

#pragma mark - UM
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    //response.responseCode枚举类型等于200是登录成功
    if (response.responseCode == 200) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"分享失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
    }

}

-(void)ending{
    if (self.tableView.header.isRefreshing) {
        //如果下拉控件处于刷新状态 则结束刷新
        [self.tableView.header endRefreshing];
    }else if (self.tableView.footer.isRefreshing) {
        [self.tableView.footer endRefreshing];
    }
}
#pragma mark - Net
-(void)requestNetMore{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *ss = [NSString stringWithFormat:self.moreUrl,self.page];
    [manager GET:ss parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"Articles"]) {
            HomeModel *model = [HomeModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
            self.page = [model.Id integerValue];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark - UI
-(void)creatUI{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"栏目" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    NSArray *arr = @[@"科技",@"数码",@"极客",@"黑客",@"创业"];
    for (int i = 0; i<5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.tag = 10+i;
        btn.frame = CGRectMake(20, i*HEIGHT/7+70, 60, 30);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick:)];
        [btn addGestureRecognizer:tap];
        btn.backgroundColor = [UIColor greenColor];
        [self.vi addSubview:btn];
//        NSLog(@"%@",NSStringFromCGRect(btn.frame));
    }
    
    
    
    
}
#pragma mark - lanmu
-(void)btnClick:(UITapGestureRecognizer*)tap{
    [self.dataArr removeAllObjects];
    switch (tap.view.tag) {
        case 10:
            self.url = URL_keji;
            self.moreUrl = URL_kejiMore;
            [self requestNet];
            break;
        case 11:
            self.url = URL_shame;
            self.moreUrl =URL_shameMore;
            [self requestNet];
            break;
        case 12:
            self.url = URL_jike;
            self.moreUrl =URL_jikeMore;
            [self requestNet];
            break;
        case 13:
            self.url = URL_heike;
            self.moreUrl =URL_hekeMore;
            [self requestNet];
            break;
        default:
            self.url = URL_cye;
            self.moreUrl = URL_cyeMore;
            [self requestNet];
            break;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.vi.frame = CGRectMake(-100, 64, 100, self.view.frame.size.height-64);
        self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    }];
    self.flag = YES;
}

#pragma mark - 网络请求
-(void)requestNet{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:self.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"Articles"]) {
            HomeModel *model = [HomeModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
            self.page = [model.Id integerValue];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


#pragma mark - 栏目
-(void)click{
    if (self.flag) {
        [UIView animateWithDuration:0.2 animations:^{
            self.vi.frame =CGRectMake(0, 64, 100, self.view.frame.size.height-64);
            self.tableView.frame = CGRectMake(100, 64, 300, HEIGHT);
        }];
        self.flag = NO;
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.vi.frame = CGRectMake(-100, 64, 100, self.view.frame.size.height-64);
            self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        }
         
         ];
        
        self.flag = YES;
        
    }
    
    //    [self.tableView reloadData];
}

#pragma mark -代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.dataArr.count==0) {
        return cell;
    }
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.2 animations:^{
        self.vi.frame = CGRectMake(-100, 64, 100, self.view.frame.size.height-64);
        self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) ;}
     
     ];
    HomeModel *model = self.dataArr[indexPath.row];
    NewsViewController *news = [NewsViewController new];
    
    news.url = [NSString stringWithFormat:URL_HOMEINFO,model.Id];
    
    [self.navigationController pushViewController:news animated:YES];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

/*
-(void)creatUI{
    NSArray *imgArr = @[@"1",@"2",@"3",@"4",@"5"];
    for (int i = 0; i < 5; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i%2 * (WIGTH/3+WIGTH/9)+WIGTH/9, i/2 * (HEIGHT/4+20)+HEIGHT/8, WIGTH/3, HEIGHT/5)];
        [self.view addSubview:img];
        img.image = [UIImage imageNamed:imgArr[i]];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [img addGestureRecognizer:tap];
        img.userInteractionEnabled = YES;
        img.tag = 10+i;
    }
    
}


-(void)click:(UITapGestureRecognizer*)tap{
    NSArray *arr = @[@"科技",@"数码",@"极客",@"黑客",@"创业"];
    InfoViewController *info = [InfoViewController new];
    switch (tap.view.tag) {
        case 10:
            info.url = URL_keji;
            break;
        case 11:
            info.url = URL_shame;
            break;
        case 12:
            info.url = URL_jike;
            break;
        case 13:
            info.url = URL_heike;
            break;
        default:
            info.url = URL_cye;
            break;
    }
    info.title = arr[tap.view.tag-10];
    [self.navigationController pushViewController:info animated:YES];
    
}*/

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
