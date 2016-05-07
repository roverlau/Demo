//
//  ShowViewController.h
//  猿生活
//
//  Created by RoverLau on 15/11/5.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewController : UIViewController

@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end
