//
//  ZTTableViewCell.m
//  礼物说
//
//  Created by RoverLau on 15/10/28.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "ZTTableViewCell.h"
#import "PrefixHeader.pch"

@interface ZTTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation ZTTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)refreshUI:(ZTModel *)model{
    self.title.text = model.title;
    if ([model.subtitle isKindOfClass:[NSNull class]]) {
        self.content.text = @"";
    }else{
        self.content.text = model.subtitle;
    }
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
