//
//  BCollectionViewCell.m
//  qinkeTtavel
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BCollectionViewCell.h"

@interface BCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@end

@implementation BCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)initUI:(CityModel *)model{
    
    self.title.text = model.title;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.bg_pic]];
    self.content.text = model.sub_title;
    self.location.text = model.destination;
    self.imgView .clipsToBounds = YES;
    [self.imgView .layer setCornerRadius:5];
    self.imgView .layer.shouldRasterize = YES;
    self.imgView .layer.rasterizationScale=[UIScreen mainScreen].scale;
    
}

@end
