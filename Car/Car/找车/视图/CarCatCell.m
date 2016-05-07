//
//  CarCatCell.m
//  Car
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CarCatCell.h"
#import "UIImageView+WebCache.h"

@implementation CarCatCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         _bottonImg = [[UIImageView alloc]initWithFrame:CGRectMake(2, 3, 90, 58)];
        _bottonImg.image = [UIImage imageNamed:@"load_albumcover_750"];
        [self.contentView addSubview:_bottonImg];
        
        _topImg =[[UIImageView alloc]initWithFrame:CGRectMake(2, 3,90, 58)];
        [self.contentView addSubview:_topImg];
        
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, KMainScreenWidth-170, 25)];
        [self.contentView addSubview:_nameLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 40, 100, 25)];
        [self.contentView addSubview:_priceLabel];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

-(void)refreshUI:(CarCatModel *)model
{
    _priceLabel.text = model.price;
    [_topImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img]]];
    _nameLabel.text = model.name;

}

@end
