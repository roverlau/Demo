//
//  ACollectionViewCell.m
//  qinkeTtavel
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ACollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ACollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation ACollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)initUI:(MddModel *)model{
    self.title.text = model.name;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.bg_pic]];
    
    self.imgView .clipsToBounds = YES;
    [self.imgView .layer setCornerRadius:10];
    self.imgView .layer.shouldRasterize = YES;
    self.imgView .layer.rasterizationScale=[UIScreen mainScreen].scale;
    
    
}

@end
