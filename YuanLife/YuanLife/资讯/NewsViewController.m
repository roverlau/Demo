//
//  NewsViewController.m
//  猿生活
//
//  Created by RoverLau on 15/11/5.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "NewsViewController.h"
#import "PrefixHeader.pch"
#import "NewsTableViewCell.h"
#import "MyModel.h"
#import "WebViewController.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *dataImg;
@property (nonatomic,strong)NSMutableArray *dataFlag;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,copy)NSString *webUrl;

@end

@implementation NewsViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
/*
-(NSMutableArray *)dataFlag{
    if (!_dataFlag) {
        _dataFlag = [NSMutableArray new];
    }
    return _dataFlag;
}

-(NSMutableArray *)dataImg{
    if (!_dataImg) {
        _dataImg = [NSMutableArray new];
    }
    return _dataImg;
}
*/
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.height = 44;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self requestNet];
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"查看原文" style:UIBarButtonItemStylePlain target:self action:@selector(show)];
}

-(void)show{
    WebViewController *web = [WebViewController new];
    web.url = self.webUrl;
//    NSLog(@"%@",self.webUrl);
    
    [self.navigationController pushViewController:web animated:YES];
}

-(void)requestNet{
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    [manage GET:self.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       self.webUrl = responseObject[@"ArtUrl"];
        for (NSDictionary *dic in responseObject[@"ArtContent"]) {
            
            for (NSString *str in dic) {
                
                MyModel *model = [MyModel new];
                if ([str isEqualToString:@"Text"]) {
                    model.text =dic[str];
                    model.flag = YES;
                    model.url = @"";
                }else{
                    model.text =@"";
                    model.flag = NO;
                    model.url = dic[str];
                }
                [self.dataArr addObject:model];
            }
            
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.dataArr.count==0) {
        return cell;
    }
    MyModel *model =self.dataArr[indexPath.row];
    
        [cell refreshTextUI:model];
    
    [self setIntroductionText:model.text :cell.lab];
    self.height = cell.lab.frame.size.height+17;
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)setIntroductionText:(NSString*)text :(UILabel*)introduction{
    //文本赋值
    introduction.text = text;
    //设置label的最大行数
    introduction.numberOfLines = 0;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [introduction.text sizeWithFont:introduction.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    introduction.frame = CGRectMake(introduction.frame.origin.x, introduction.frame.origin.y, labelSize.width, labelSize.height);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyModel *model =self.dataArr[indexPath.row];
    if (!model.flag) {
        return 350;
    }
    return  self.height;
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
