//
//  ShowTableViewCell.m
//  qinkeTtavel
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShowTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShowTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *contant;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end

@implementation ShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)initUI:(FunModel *)model{
    self.title.text = model.title;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.bg_pic[0]]];
    self.contant.text = model.sub_title;
    self.location.text = model.destination;
    
    
    [self.imgView .layer setCornerRadius:10];
    self.imgView .layer.shouldRasterize = YES;
    self.imgView .layer.rasterizationScale=[UIScreen mainScreen].scale;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
