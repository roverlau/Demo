//
//  BeauTableViewController.m
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "BeauTableViewController.h"
#import "JXTableViewCell.h"
#import "HomeModel.h"
#import "JXViewController.h"
#import "RequestNetwork.h"
#import "PrefixHeader.pch"

@interface BeauTableViewController ()

@property(nonatomic,assign)NSInteger page;

@end

@implementation BeauTableViewController

-(NSMutableArray *)dataBeau{
    if (!_dataBeau) {
        _dataBeau = [NSMutableArray new];
    }
    return _dataBeau;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
       [self.tableView registerNib:[UINib nibWithNibName:@"JXTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//        [self.tableView reloadData];
    
    
    [RequestNetwork requestBeau:self :self.page];

    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [self.dataBeau removeAllObjects];
        [self performSelector:@selector(ending) withObject:nil afterDelay:1.0f];
        [RequestNetwork requestBeau:self :self.page];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page+=20;
        [self performSelector:@selector(ending) withObject:nil afterDelay:1.0f];
        [RequestNetwork requestBeau:self :self.page];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.tableView reloadData];
//}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataBeau.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    HomeModel *model = self.dataBeau[indexPath.row];
    [cell refreshUI:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JXViewController *jc = [JXViewController new];
    HomeModel *hm = self.dataBeau[indexPath.row];
    jc.info =hm.content_url;
    [self.navigationController pushViewController:jc animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
