//
//  ViewController.m
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "ViewController.h"
#import "SroModel.h"
#import "TitleModel.h"
#import "HomeModel.h"
#import "JXTableViewCell.h"
#import "JXViewController.h"
#import "ZTTableViewController.h"
#import "RequestNetwork.h"
#import "InfoTableViewController.h"
#import "FBViewController.h"
#import "ZCZBarViewController.h"
#import "QRCodeGenerator.h"
#import "UMSocial.h"



#import "PrefixHeader.pch"

/*
//#define URL_SCR @"http://api.liwushuo.com/v1/banners?_=635815059420353341"
//#define URL_IMG @"http://api.liwushuo.com/v2/promotions?generation=2&gender=1&_=635815059427884340"
//#define URL_HOME @"http://api.liwushuo.com/v2/channels/101/items?offset=0&limit=20&generation=2&gender=1&_=635815089487349097"
//#define URL_BEAU @"http://api.liwushuo.com/v1/collections/22/posts?offset=0&limit=20&_=635815060228960021"
*/
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UMSocialUIDelegate>

@property(nonatomic,assign)NSInteger page;

@end


@implementation ViewController

-(BeauTableViewController *)bt{
    if (!_bt) {
        _bt = [BeauTableViewController new];
    }
    return _bt;
    
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(NSMutableArray *)dataBeau{
    if (!_dataBeau) {
        _dataBeau = [NSMutableArray new];
    }
    return _dataBeau;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

-(NSMutableArray *)dataArrImg{
    if (!_dataArrImg) {
        _dataArrImg = [NSMutableArray new];
    }
    return _dataArrImg;
}

-(NSMutableArray *)dataHome{
    if (!_dataHome) {
        _dataHome = [NSMutableArray new];
    }
    return _dataHome;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"JXTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self requestNetTilte];
    [self configerUI];
    [RequestNetwork requestHome:self :self.page];
    [RequestNetwork requestNet:self];
   
    self.page = 0;
//    RequestNetwork
    
    //通知中心传值
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNoti:) name:@"Rover" object:nil];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
            [self.dataHome removeAllObjects];
        [self performSelector:@selector(ending) withObject:nil afterDelay:1.0f];
         [RequestNetwork requestHome:self :self.page];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page+=20;
        [self performSelector:@selector(ending) withObject:nil afterDelay:1.0f];
         [RequestNetwork requestHome:self :self.page];
    } ];
}
-(void)ending{
    if (self.tableView.header.isRefreshing) {
        //如果下拉控件处于刷新状态 则结束刷新
        [self.tableView.header endRefreshing];
    }else if (self.tableView.footer.isRefreshing) {
        [self.tableView.footer endRefreshing];
    }
}

#pragma mark - 通知中心
-(void)receiveNoti:(NSNotification*)niti{
    //接收到通知后回调的方法
    
    NSDictionary* dic = (NSDictionary*)niti.object;
    for (NSString* obj in dic) {
        if ([dic[obj]isEqualToString:@"11"]||[dic[obj]isEqualToString:@"12"]) {
            
            JXViewController *jc = [JXViewController new];
            jc.info =obj;
            [self.navigationController pushViewController:jc animated:YES];
            
        }else{
                InfoTableViewController *info = [InfoTableViewController new];
                info.url = obj;
                [self.navigationController pushViewController:info animated:YES];
        }
    }

    
}

#pragma mark - 网络请求相关

//四格
-(void)requestNetTilte{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL_IMG parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"OK"]) {
            for (NSDictionary *dic in responseObject[@"data"][@"promotions"]) {
                

                
                TitleModel *model = [TitleModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArrImg addObject:model];
            }
        }
        for (NSInteger i = 0; i<4; i++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.hp.frame.size.width/4+10, 140, self.hp.frame.size.width/4-20, 70)];            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(i*self.hp.frame.size.width/4+10,  210, self.hp.frame.size.width/4-5, 24)];
            TitleModel *tm = self.dataArrImg[i];
            [img sd_setImageWithURL:[NSURL URLWithString:tm.icon_url]];
            UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
            [img addGestureRecognizer:myTap];
            img.tag = i+10;
            img.userInteractionEnabled = YES;
            lab.text = tm.title;
            [self.hp addSubview:img];
            [self.hp addSubview:lab];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 图片点击事件
-(void)click:(UITapGestureRecognizer*)sender{
    
    switch (sender.view.tag) {
        case 10:
           [self.navigationController pushViewController:self.bt animated:YES];
            break;
        case 11:
            [self.navigationController pushViewController:[ZTTableViewController new] animated:YES];
            break;
        case 12:
        {
            NSString *str = @"http://www.liwushuo.com/credit/sign?_=635816227630264250";
            JXViewController *jc = [JXViewController new];
            jc.info =str;
            [self.navigationController pushViewController:jc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 头部ScrollView视图
-(void)configerUI{
    self.hp = [HomePage circleViewFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 250)];
    self.tableView.tableHeaderView = self.hp;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataHome.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    HomeModel *model = self.dataHome[indexPath.row];
    [cell refreshUI:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JXViewController *jc = [JXViewController new];
    HomeModel *hm = self.dataHome[indexPath.row];
    jc.info =hm.content_url;
    [self.navigationController pushViewController:jc animated:YES];
}

#pragma mark - MORE
- (IBAction)more:(id)sender {
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"更多" message:@"message" delegate:self cancelButtonTitle:@"扫码" otherButtonTitles:@"生成二维码",@"分享", nil];
    [al show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:{
            FBViewController *fb= [FBViewController new];
            fb.view.backgroundColor = [UIColor orangeColor ];
            
            
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
            //参数1.生成二维码的文字 也就是别人扫描二维码的结果，第二参数是图像的清晰度
            img.image = [QRCodeGenerator qrImageForString:@"www.liwushuo.com" imageSize:500];
            [fb.view addSubview:img];
            [self.navigationController pushViewController:fb animated:YES];
        }
            break;
        case 0:{
            [self QRcode];
        }
            break;
        default:
        {
            
              [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5636c18467e58e18e0000796" shareText:@"您要分享的内容" shareImage:nil shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToLWSession] delegate:self];
            
//            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"待实现" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
        }
            break;
    }
}

#pragma mark-友盟代理方法
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    //response.responseCode枚举类型等于200是登录成功
    if (response.responseCode == 200) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"分享失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
    }
}
-(void)QRcode{
    ZCZBarViewController *zbar=  [[ZCZBarViewController alloc]initWithBlock:^(NSString *str, BOOL flag) {
        if (flag) {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }else{
//            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"失败，请重试" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [av show];
        }
    }];
    [self presentViewController:zbar animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - -

@end
