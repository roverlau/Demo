//
//  HotCollectionViewCell.m
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "HotCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface HotCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titile;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *rate;

@end

@implementation HotCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)refreshUI:(HotModel *)model{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    self.titile.text = model.name;
    self.price.text = model.price;
    self.rate.text = model.favorites_count;
}


@end
