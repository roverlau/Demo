//
//  RequestNetwork.m
//  礼物说
//
//  Created by RoverLau on 15/10/28.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "RequestNetwork.h"

@implementation RequestNetwork


-(ViewController *)vc{
    if (!_vc) {
        _vc = [ViewController new];
    }
    return _vc;
}

#pragma mark - 网络请求相关


//轮播
+(void)requestNet:(ViewController*)vc{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL_SCR parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"OK"]) {
            for (NSDictionary *dic in responseObject[@"data"][@"banners"]) {
                SroModel *model = [SroModel new];
                [model setValuesForKeysWithDictionary:dic];
                [vc.dataArr addObject:model];
            }
            [vc.hp setImgUrlArr:vc.dataArr];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
//首页
+(void)requestHome:(ViewController*)vc :(NSInteger)page{
    NSString *str = [NSString stringWithFormat:URL_HOME,page];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"OK"]) {
            for (NSDictionary *dic in responseObject[@"data"][@"items"]) {
                HomeModel *model = [HomeModel new];
                [model setValuesForKeysWithDictionary:dic];
                [vc.dataHome addObject:model];
            }
        }
        [vc.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
//美好小物
+(void)requestBeau:(BeauTableViewController*)vc :(NSInteger)page{
   NSString *str = [NSString stringWithFormat:URL_BEAU,page];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"OK"]) {
            for (NSDictionary *dic in responseObject[@"data"][@"posts"]) {
                HomeModel *model = [HomeModel new];
                [model setValuesForKeysWithDictionary:dic];
                [vc.dataBeau addObject:model];
            }
        }
        [vc.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#pragma mark - 推送
+(void)push{
}


@end
