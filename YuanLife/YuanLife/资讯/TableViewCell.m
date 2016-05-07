//
//  TableViewCell.m
//  猿生活
//
//  Created by RoverLau on 15/11/5.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)refreshUI:(HomeModel *)model{
//    [self.delegate my];
    
    self.title.text = model.Title;
    self.time.text = [NSString stringWithFormat:@"%@      %@",model.Source,model.PublishTime];
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.CoverImg]];
    self.content.text = model.Summary;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
