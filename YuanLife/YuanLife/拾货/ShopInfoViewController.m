//
//  ShopInfoViewController.m
//  猿生活
//
//  Created by RoverLau on 15/11/6.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "ShopInfoViewController.h"
#import "WebViewController.h"


@interface ShopInfoViewController ()

@end
@interface ShopInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,copy)NSString *tbUrl;
@property (nonatomic,copy)NSMutableArray *imgUrl;

@end

@implementation ShopInfoViewController

-(NSMutableArray *)imgUrl{
    if (!_imgUrl) {
        _imgUrl = [NSMutableArray new];
    }
    return _imgUrl;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableview registerNib:[UINib nibWithNibName:@"SHTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self requestNet];
    [self creatUI];
    
}

#pragma mark - UI
-(void)creatUI{
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIGTH, 100)];
    
    CGSize constraint = CGSizeMake(500, CGFLOAT_MAX);
   
    lab.text = self.myTitle;
    lab.numberOfLines = 0;

    lab.font = [UIFont systemFontOfSize:20];
    CGSize size = [self.myTitle sizeWithFont: lab.font constrainedToSize:constraint lineBreakMode:0];
//        NSLog(@"%f",size.height);
    lab.frame = CGRectMake(0, 0, WIGTH, size.height+10);
    UILabel *tim = [[UILabel alloc]initWithFrame:CGRectMake(0, size.height+10, WIGTH, 27)];
    tim.textColor = [UIColor grayColor];
    tim.text = self.time;
    UIImageView *imgVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, size.height+37, WIGTH, 200)];
    [imgVIew sd_setImageWithURL:[NSURL URLWithString:self.picUrl]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:[NSString stringWithFormat:@"%@  |  马上拥有>",self.price] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)]];
    btn.frame = CGRectMake(50, size.height+237, WIGTH-100, 40);
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIGTH, 280+size.height)];
    [v addSubview:lab];
    [v addSubview:tim];
    [v addSubview:imgVIew];
    [v addSubview:btn];
    self.tableview.tableHeaderView = v;

}

-(void)click{
    
    WebViewController *web = [WebViewController new];
    

    web.url = self.tbUrl;
    [self.navigationController pushViewController:web animated:YES];
    
}

#pragma mark - 网络请求
-(void)requestNet{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:self.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tbUrl = responseObject[@"ClickUrl"];
        for (NSDictionary *dic in responseObject[@"GoodsContent"]) {
            for (NSString *str in dic) {
//                NSLog(@"%@",str);
//                NSLog(@"%@",[dic valueForKey:str]);
                if ([str isEqualToString:@"Image"]) {
                    [self.imgUrl addObject:[dic valueForKey:str]];
                }
            }
        }
        [self.tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imgUrl.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIGTH, 250)];
    [imgV sd_setImageWithURL:[NSURL URLWithString:self.imgUrl[indexPath.row]]];
    [cell addSubview:imgV];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
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
