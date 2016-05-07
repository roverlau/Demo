//
//  NewsCell.h
//  汽车导购
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"


@interface NewsCell : UITableViewCell

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UILabel * dataLabel;

@property (nonatomic,strong) UILabel * commentNumLabel;

@property (nonatomic,strong) UIImageView * imgView;

-(void)refreshUI:(NewsModel *)model;

@end
