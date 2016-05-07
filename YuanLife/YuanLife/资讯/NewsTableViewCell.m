//
//  NewsTableViewCell.m
//  猿生活
//
//  Created by RoverLau on 15/11/6.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@end

@implementation NewsTableViewCell


-(void)refreshTextUI:(MyModel *)model{

            self.lab.text = model.text;
     [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.imageView.frame = CGRectMake(0, 0, WIGTH, 400);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
