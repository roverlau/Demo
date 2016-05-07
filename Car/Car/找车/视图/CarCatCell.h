//
//  CarCatCell.h
//  Car
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarCatModel.h"

@interface CarCatCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *bottonImg;
@property (nonatomic,strong) UILabel * priceLabel;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UIImageView *topImg;

-(void)refreshUI:(CarCatModel *)model;

@end
