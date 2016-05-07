//
//  CommentCell.h
//  Car
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentCell : UITableViewCell

@property (nonatomic,strong) UIImageView * headerImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong) UIButton * zanBtn;
@property (nonatomic,strong) UILabel * zanLabel;

-(void)refreshUI:(CommentModel *)model;

@end
