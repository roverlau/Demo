//
//  SHTableViewCell.m
//  猿生活
//
//  Created by RoverLau on 15/11/5.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation SHTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)refreshUI:(SHModel *)model{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.CoverImg]];
    self.content.text = [NSString stringWithFormat:@"%@      %@",model.Source,model.PublishTime];
    self.price.text = model.Price;
    self.title.text = model.Title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
