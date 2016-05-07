//
//  ParameterViewController.h
//  Car
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParameterViewController : UIViewController

@property (nonatomic,strong) NSString * mid;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,strong) NSString * params_value_type;

@end
