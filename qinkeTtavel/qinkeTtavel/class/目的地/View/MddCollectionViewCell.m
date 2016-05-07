//
//  MddCollectionViewCell.m
//  qinkeTtavel
//
//  Created by admin on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MddCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MddCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titile;

@end

@implementation MddCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)initUI:(MddModel *)model{
    self.titile.text = model.name;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.bg_pic]];
    
    self.imgView .clipsToBounds = YES;
    [self.imgView .layer setCornerRadius:10];
    self.imgView .layer.shouldRasterize = YES;
    self.imgView .layer.rasterizationScale=[UIScreen mainScreen].scale;
    
    
}

@end
