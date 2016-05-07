//
//  JXTableViewCell.m
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "JXTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface JXTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *rate;

@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation JXTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)refreshUI:(HomeModel *)model{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    self.title.text = model.title;
    self.rate.text = model.likes_count;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
