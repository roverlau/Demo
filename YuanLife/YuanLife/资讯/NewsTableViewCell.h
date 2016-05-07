//
//  NewsTableViewCell.h
//  猿生活
//
//  Created by RoverLau on 15/11/6.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lab;

-(void)refreshTextUI:(MyModel*)model;
//-(void)refreshUrlUI:(NSString *)url;

@end
