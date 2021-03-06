//
//  SearchViewController.m
//  Car
//
//  Created by qianfeng on 15/11/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchViewController.h"
#import "AFNetworking.h"
#import "NewsCell.h"
#import "NewsModel.h"
#import "DetailNewsViewController.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) NSArray * arr;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) UIView * backView;
@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,copy) NSString *searchKeyWord;

@end

@implementation SearchViewController

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr = @[@"斯巴鲁",@"音朗",@"英菲尼迪QX50",@"皇冠",@"优惠",@"傲跑KX3",@"平行进口车",@"普拉多" ];
    
    [self initUI];
    
}

-(void)initUI
{
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenWidth, 44)];
    [self.view addSubview:v];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(3, 2, KMainScreenWidth-50, 40)];
    [_textField setPlaceholder:@"请输入搜索内容"];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1.0];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    _textField.delegate = self;
    [v addSubview:_textField];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-45, 2, 40, 40)];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];

    for (NSInteger i = 0 ; i < self.arr.count; i ++ ) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((KMainScreenWidth/3)*(i%3)+10, 74+50*(i/3), KMainScreenWidth/3-20, 35)];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_sarrowlabel"] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@",self.arr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.font = [UIFont systemFontOfSize:14];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(lookDetailAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
    
}

-(void)cancelAction
{
    [self dismissViewControllerAnimated:NO completion:nil];

}

-(void)lookDetailAction:(UIButton *)btn
{
    
    switch (btn.tag) {
        case 10:
            
            [self requestData:self.arr[10-10]];
            break;
        case 11:
            
            [self requestData:self.arr[11-10]];
            break;
        case 12:
            
            [self requestData:self.arr[12-10]];
            break;
        case 13:
            
            [self requestData:self.arr[13-10]];
            break;
        case 14:
            
            [self requestData:self.arr[14-10]];
            break;
        case 15:
            
            [self requestData:self.arr[15-10]];
            break;
        case 16:
            
            [self requestData:self.arr[16-10]];
            break;
        case 17:
            
            [self requestData:self.arr[17-10]];
            break;
        case 18:
            
            [self requestData:self.arr[18-10]];
            break;
        default:
            break;
    }
    
    [self create];
}

-(void)create
{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight-64)];
    _backView.backgroundColor = [UIColor purpleColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, KMainScreenHeight-64)];
    _tableView .delegate = self;
    _tableView.dataSource = self;
    [_backView addSubview:_tableView];
    [self.view addSubview:_backView];
    [_tableView registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
}

-(void)requestData:(NSString *)keyWord
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:SEARCH_RESULT_URL parameters:@{@"keyword":[NSString stringWithFormat:@"%@",keyWord]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //移除上一次搜索记录
        [self.dataArr removeAllObjects];
        
        for (NSDictionary *dic in responseObject[@"result"][@"article"]) {
            
            
            NewsModel *model = [[NewsModel alloc]init];
            
            model.title = dic[@"title"];
            model.comment_nums = dic[@"comment_nums"];
            model.cover_url = dic[@"cover_url"];
            model.instime = dic[@"instime"];
            model.myId = dic[@"id"];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, 20)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor whiteColor];
    lb.backgroundColor = [UIColor redColor];
    lb.text = [NSString stringWithFormat:@"共搜索到%ld个结果",self.dataArr.count];
    lb.font = [UIFont systemFontOfSize:15];
    [self.backView addSubview:lb];
    [UIView animateWithDuration:3.0 animations:^{
        lb.alpha = 0;
    }completion:^(BOOL finished) {
        [lb removeFromSuperview];
        
    }];
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailNewsViewController *ctl = [[DetailNewsViewController alloc]init];
    ctl.myId = [self.dataArr[indexPath.row] myId];
    [self presentViewController:ctl animated:NO completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _searchKeyWord = [NSString stringWithFormat:@"%@",textField.text];
    [_backView removeFromSuperview];
    [self create];
    [self requestData:_searchKeyWord];
    [textField resignFirstResponder];
    return YES;
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
