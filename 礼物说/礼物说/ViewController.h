//
//  ViewController.h
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeauTableViewController.h"
#import "HomePage.h"

@interface ViewController : UIViewController

@property (nonatomic,strong)HomePage *hp;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *dataArrImg;
@property (nonatomic,strong)NSMutableArray *dataHome;
@property (nonatomic,strong)NSMutableArray *dataBeau;
@property (nonatomic,strong)BeauTableViewController *bt;


@end

