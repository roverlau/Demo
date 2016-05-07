//
//  CommandCell.h
//  Car
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommandModel.h"

@interface CommandCell : UITableViewCell

@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UILabel * metaLabel;
@property (nonatomic,strong) UIButton * downLoadButton;

-(void)refreshUI:(CommandModel *)model;

@end
