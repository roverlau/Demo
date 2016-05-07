//
//  CarSeriesViewController.h
//  Car
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarSeriesViewController : UIViewController

@property (nonatomic,strong) UITableView * tableView;

//从一页面传递过来的参数
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * name;
@end
